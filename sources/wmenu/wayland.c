#define _POSIX_C_SOURCE 200809L
#include <assert.h>
#include <errno.h>
#include <poll.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <time.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/timerfd.h>
#include <wayland-client.h>
#include <wayland-client-protocol.h>
#include <xkbcommon/xkbcommon.h>

#include "menu.h"
#include "pool-buffer.h"
#include "render.h"
#include "wayland.h"
#include "xdg-activation-v1-client-protocol.h"
#include "wlr-layer-shell-unstable-v1-client-protocol.h"

// A Wayland output.
struct output {
	struct wl_context *context;
	struct wl_output *output;
	const char *name;    // output name
	int32_t scale;       // output scale
	struct output *next; // next output
};

// Creates and returns a new output.
static struct output *output_create(struct wl_context *context, struct wl_output *wl_output) {
	struct output *output = calloc(1, sizeof(struct output));
	output->context = context;
	output->output = wl_output;
	output->scale = 1;
	return output;
}

// Keyboard state.
struct keyboard {
	struct menu *menu;
	struct wl_keyboard *keyboard;
	struct xkb_context *context;
	struct xkb_keymap *keymap;
	struct xkb_state *state;

	int repeat_timer;
	int repeat_delay;
	int repeat_period;
	enum wl_keyboard_key_state repeat_key_state;
	xkb_keysym_t repeat_sym;
};

// Creates and returns a new keyboard.
static struct keyboard *keyboard_create(struct menu *menu, struct wl_keyboard *wl_keyboard) {
	struct keyboard *keyboard = calloc(1, sizeof(struct keyboard));
	keyboard->menu = menu;
	keyboard->keyboard = wl_keyboard;
	keyboard->context = xkb_context_new(XKB_CONTEXT_NO_FLAGS);
	assert(keyboard->context != NULL);
	keyboard->repeat_timer = timerfd_create(CLOCK_MONOTONIC, 0);
	assert(keyboard->repeat_timer != -1);
	return keyboard;
}

// Frees the keyboard.
static void free_keyboard(struct keyboard *keyboard) {
	wl_keyboard_release(keyboard->keyboard);
	xkb_state_unref(keyboard->state);
	xkb_keymap_unref(keyboard->keymap);
	xkb_context_unref(keyboard->context);
	free(keyboard);
}

// Wayland context.
struct wl_context {
	struct menu *menu;

	struct wl_display *display;
	struct wl_registry *registry;
	struct wl_compositor *compositor;
	struct wl_shm *shm;
	struct wl_seat *seat;
	struct wl_data_device_manager *data_device_manager;
	struct zwlr_layer_shell_v1 *layer_shell;
	struct output *output_list;
	struct xdg_activation_v1 *activation;

	struct keyboard *keyboard;
	struct wl_data_device *data_device;
	struct wl_surface *surface;
	struct zwlr_layer_surface_v1 *layer_surface;
	struct wl_data_offer *data_offer;
	struct output *output;

	struct pool_buffer buffers[2];
	struct pool_buffer *current;
};

// Returns the current output_scale.
int context_get_scale(struct wl_context *context) {
	return context->output ? context->output->scale : 1;
}

// Returns the current buffer from the pool.
struct pool_buffer *context_get_current_buffer(struct wl_context *context) {
	return context->current;
}

// Returns the next buffer from the pool.
struct pool_buffer *context_get_next_buffer(struct wl_context *context, int scale) {
	struct menu *menu = context->menu;
	context->current = get_next_buffer(context->shm, context->buffers, menu->width, menu->height, scale);
	return context->current;
}

// Returns the Wayland surface for the context.
struct wl_surface *context_get_surface(struct wl_context *context) {
	return context->surface;
}

// Returns the XKB state for the context.
struct xkb_state *context_get_xkb_state(struct wl_context *context) {
	return context->keyboard->state;
}

// Returns the XDG activation object for the context.
struct xdg_activation_v1 *context_get_xdg_activation(struct wl_context *context) {
	return context->activation;
}

// Retrieves pasted text from a Wayland data offer.
bool context_paste(struct wl_context *context) {
	if (!context->data_offer) {
		return false;
	}

	int fds[2];
	if (pipe(fds) == -1) {
		// Pipe failed
		return false;
	}
	wl_data_offer_receive(context->data_offer, "text/plain", fds[1]);
	close(fds[1]);

	wl_display_roundtrip(context->display);

	while (true) {
		char buf[1024];
		ssize_t n = read(fds[0], buf, sizeof(buf));
		if (n <= 0) {
			break;
		}
		menu_paste(context->menu, buf, n);
	}
	close(fds[0]);

	wl_data_offer_destroy(context->data_offer);
	context->data_offer = NULL;
	return true;
}

// Adds an output to the output list.
static void context_add_output(struct wl_context *context, struct output *output) {
	output->next = context->output_list;
	context->output_list = output;
}

// Frees the outputs.
static void free_outputs(struct wl_context *context) {
	struct output *next = context->output_list;
	while (next) {
		struct output *output = next;
		next = output->next;
		wl_output_destroy(output->output);
		free(output);
	}
}

// Destroys the Wayland context, freeing memory associated with it.
static void context_destroy(struct wl_context *context) {
	wl_registry_destroy(context->registry);
	wl_compositor_destroy(context->compositor);
	wl_shm_destroy(context->shm);
	wl_seat_destroy(context->seat);
	wl_data_device_manager_destroy(context->data_device_manager);
	zwlr_layer_shell_v1_destroy(context->layer_shell);
	free_outputs(context);

	free_keyboard(context->keyboard);
	wl_data_device_destroy(context->data_device);
	wl_surface_destroy(context->surface);
	zwlr_layer_surface_v1_destroy(context->layer_surface);
	xdg_activation_v1_destroy(context->activation);

	wl_display_disconnect(context->display);
	free(context);
}

static void noop() {
	// Do nothing
}

static void surface_enter(void *data, struct wl_surface *surface, struct wl_output *wl_output) {
	struct wl_context *context = data;
	context->output = wl_output_get_user_data(wl_output);
	menu_invalidate(context->menu);
}

static const struct wl_surface_listener surface_listener = {
	.enter = surface_enter,
	.leave = noop,
};

static void layer_surface_configure(void *data,
		struct zwlr_layer_surface_v1 *surface,
		uint32_t serial, uint32_t width, uint32_t height) {
	struct wl_context *context = data;
	context->menu->width = width;
	context->menu->height = height;
	zwlr_layer_surface_v1_ack_configure(surface, serial);
}

static void layer_surface_closed(void *data, struct zwlr_layer_surface_v1 *surface) {
	struct wl_context *context = data;
	context->menu->exit = true;
}

static const struct zwlr_layer_surface_v1_listener layer_surface_listener = {
	.configure = layer_surface_configure,
	.closed = layer_surface_closed,
};

static void output_scale(void *data, struct wl_output *wl_output, int32_t factor) {
	struct output *output = data;
	output->scale = factor;
}

static void output_name(void *data, struct wl_output *wl_output, const char *name) {
	struct output *output = data;
	output->name = name;

	struct wl_context *context = output->context;
	if (context->menu->output_name && strcmp(context->menu->output_name, name) == 0) {
		context->output = output;
	}
}

static const struct wl_output_listener output_listener = {
	.geometry = noop,
	.mode = noop,
	.done = noop,
	.scale = output_scale,
	.name = output_name,
	.description = noop,
};

static void keyboard_keymap(void *data, struct wl_keyboard *wl_keyboard,
		uint32_t format, int32_t fd, uint32_t size) {
	struct keyboard *keyboard = data;
	assert(format == WL_KEYBOARD_KEYMAP_FORMAT_XKB_V1);

	char *map_shm = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
	assert(map_shm != MAP_FAILED);

	keyboard->keymap = xkb_keymap_new_from_string(keyboard->context,
		map_shm, XKB_KEYMAP_FORMAT_TEXT_V1, 0);
	munmap(map_shm, size);
	close(fd);

	keyboard->state = xkb_state_new(keyboard->keymap);
}

static void keyboard_repeat(struct keyboard *keyboard) {
	menu_keypress(keyboard->menu, keyboard->repeat_key_state, keyboard->repeat_sym);
	struct itimerspec spec = { 0 };
	spec.it_value.tv_sec = keyboard->repeat_period / 1000;
	spec.it_value.tv_nsec = (keyboard->repeat_period % 1000) * 1000000l;
	timerfd_settime(keyboard->repeat_timer, 0, &spec, NULL);
}

static void keyboard_key(void *data, struct wl_keyboard *wl_keyboard,
		uint32_t serial, uint32_t time, uint32_t key, uint32_t _key_state) {
	struct keyboard *keyboard = data;

	enum wl_keyboard_key_state key_state = _key_state;
	xkb_keysym_t sym = xkb_state_key_get_one_sym(keyboard->state, key + 8);
	menu_keypress(keyboard->menu, key_state, sym);

	if (key_state == WL_KEYBOARD_KEY_STATE_PRESSED && keyboard->repeat_period >= 0) {
		keyboard->repeat_key_state = key_state;
		keyboard->repeat_sym = sym;

		struct itimerspec spec = { 0 };
		spec.it_value.tv_sec = keyboard->repeat_delay / 1000;
		spec.it_value.tv_nsec = (keyboard->repeat_delay % 1000) * 1000000l;
		timerfd_settime(keyboard->repeat_timer, 0, &spec, NULL);
	} else if (key_state == WL_KEYBOARD_KEY_STATE_RELEASED) {
		struct itimerspec spec = { 0 };
		timerfd_settime(keyboard->repeat_timer, 0, &spec, NULL);
	}
}

static void keyboard_repeat_info(void *data, struct wl_keyboard *wl_keyboard,
		int32_t rate, int32_t delay) {
	struct keyboard *keyboard = data;
	keyboard->repeat_delay = delay;
	if (rate > 0) {
		keyboard->repeat_period = 1000 / rate;
	} else {
		keyboard->repeat_period = -1;
	}
}

static void keyboard_modifiers(void *data, struct wl_keyboard *wl_keyboard,
		uint32_t serial, uint32_t mods_depressed,
		uint32_t mods_latched, uint32_t mods_locked,
		uint32_t group) {
	struct keyboard *keyboard = data;
	xkb_state_update_mask(keyboard->state, mods_depressed, mods_latched,
			mods_locked, 0, 0, group);
}

static const struct wl_keyboard_listener keyboard_listener = {
	.keymap = keyboard_keymap,
	.enter = noop,
	.leave = noop,
	.key = keyboard_key,
	.modifiers = keyboard_modifiers,
	.repeat_info = keyboard_repeat_info,
};

static void seat_capabilities(void *data, struct wl_seat *seat,
		enum wl_seat_capability caps) {
	struct wl_context *context = data;
	if (caps & WL_SEAT_CAPABILITY_KEYBOARD) {
		struct wl_keyboard *wl_keyboard = wl_seat_get_keyboard(seat);
		struct keyboard *keyboard = keyboard_create(context->menu, wl_keyboard);
		wl_keyboard_add_listener(wl_keyboard, &keyboard_listener, keyboard);
		context->keyboard = keyboard;
	}
}

static const struct wl_seat_listener seat_listener = {
	.capabilities = seat_capabilities,
	.name = noop,
};

static void data_device_selection(void *data, struct wl_data_device *data_device,
		struct wl_data_offer *data_offer) {
	struct wl_context *context = data;
	context->data_offer = data_offer;
}

static const struct wl_data_device_listener data_device_listener = {
	.data_offer = noop,
	.enter = noop,
	.leave = noop,
	.motion = noop,
	.drop = noop,
	.selection = data_device_selection,
};

static void handle_global(void *data, struct wl_registry *registry,
		uint32_t name, const char *interface, uint32_t version) {
	struct wl_context *context = data;
	if (strcmp(interface, wl_compositor_interface.name) == 0) {
		context->compositor = wl_registry_bind(registry, name, &wl_compositor_interface, 4);
	} else if (strcmp(interface, wl_shm_interface.name) == 0) {
		context->shm = wl_registry_bind(registry, name, &wl_shm_interface, 1);
	} else if (strcmp(interface, wl_seat_interface.name) == 0) {
		context->seat = wl_registry_bind(registry, name, &wl_seat_interface, 4);
		wl_seat_add_listener(context->seat, &seat_listener, data);
	} else if (strcmp(interface, wl_data_device_manager_interface.name) == 0) {
		context->data_device_manager = wl_registry_bind(registry, name, &wl_data_device_manager_interface, 3);
	} else if (strcmp(interface, zwlr_layer_shell_v1_interface.name) == 0) {
		context->layer_shell = wl_registry_bind(registry, name, &zwlr_layer_shell_v1_interface, 1);
	} else if (strcmp(interface, wl_output_interface.name) == 0) {
		struct wl_output *wl_output = wl_registry_bind(registry, name, &wl_output_interface, 4);
		struct output *output = output_create(context, wl_output);
		wl_output_set_user_data(wl_output, output);
		wl_output_add_listener(wl_output, &output_listener, output);
		context_add_output(context, output);
	} else if (strcmp(interface, xdg_activation_v1_interface.name) == 0) {
		context->activation = wl_registry_bind(registry, name, &xdg_activation_v1_interface, 1);
	}
}

static const struct wl_registry_listener registry_listener = {
	.global = handle_global,
	.global_remove = noop,
};

// Connect to the Wayland display and run the menu.
int menu_run(struct menu *menu) {
	struct wl_context *context = calloc(1, sizeof(struct wl_context));
	context->menu = menu;
	menu->context = context;

	context->display = wl_display_connect(NULL);
	if (!context->display) {
		fprintf(stderr, "Failed to connect to display.\n");
		exit(EXIT_FAILURE);
	}

	struct wl_registry *registry = wl_display_get_registry(context->display);
	wl_registry_add_listener(registry, &registry_listener, context);
	wl_display_roundtrip(context->display);
	assert(context->compositor != NULL);
	assert(context->shm != NULL);
	assert(context->seat != NULL);
	assert(context->data_device_manager != NULL);
	assert(context->layer_shell != NULL);
	assert(context->activation != NULL);
	context->registry = registry;

	// Get data device for seat
	struct wl_data_device *data_device = wl_data_device_manager_get_data_device(
			context->data_device_manager, context->seat);
	wl_data_device_add_listener(data_device, &data_device_listener, context);
	context->data_device = data_device;

	// Second roundtrip for seat and output listeners
	wl_display_roundtrip(context->display);
	assert(context->keyboard != NULL);

	if (menu->output_name && !context->output) {
		fprintf(stderr, "Output %s not found\n", menu->output_name);
		exit(EXIT_FAILURE);
	}

	context->surface = wl_compositor_create_surface(context->compositor);
	wl_surface_add_listener(context->surface, &surface_listener, context);

	struct zwlr_layer_surface_v1 *layer_surface = zwlr_layer_shell_v1_get_layer_surface(
		context->layer_shell,
		context->surface,
		context->output ? context->output->output : NULL,
		ZWLR_LAYER_SHELL_V1_LAYER_OVERLAY,
		"menu"
	);
	assert(layer_surface != NULL);
	context->layer_surface = layer_surface;

	uint32_t anchor = ZWLR_LAYER_SURFACE_V1_ANCHOR_LEFT |
		ZWLR_LAYER_SURFACE_V1_ANCHOR_RIGHT;
	if (menu->bottom) {
		anchor |= ZWLR_LAYER_SURFACE_V1_ANCHOR_BOTTOM;
	} else {
		anchor |= ZWLR_LAYER_SURFACE_V1_ANCHOR_TOP;
	}

	zwlr_layer_surface_v1_set_anchor(layer_surface, anchor);
	zwlr_layer_surface_v1_set_size(layer_surface, 0, menu->height);
	zwlr_layer_surface_v1_set_exclusive_zone(layer_surface, -1);
	zwlr_layer_surface_v1_set_keyboard_interactivity(layer_surface, true);
	zwlr_layer_surface_v1_add_listener(layer_surface, &layer_surface_listener, context);

	wl_surface_commit(context->surface);
	wl_display_roundtrip(context->display);
	menu_render_items(menu);

	struct pollfd fds[] = {
		{ wl_display_get_fd(context->display), POLLIN },
		{ context->keyboard->repeat_timer, POLLIN },
	};
	const size_t nfds = sizeof(fds) / sizeof(*fds);

	while (!menu->exit) {
		errno = 0;
		do {
			if (wl_display_flush(context->display) == -1 && errno != EAGAIN) {
				fprintf(stderr, "wl_display_flush: %s\n", strerror(errno));
				break;
			}
		} while (errno == EAGAIN);

		if (poll(fds, nfds, -1) < 0) {
			fprintf(stderr, "poll: %s\n", strerror(errno));
			break;
		}

		if (fds[0].revents & POLLIN) {
			if (wl_display_dispatch(context->display) < 0) {
				menu->exit = true;
			}
		}

		if (fds[1].revents & POLLIN) {
			keyboard_repeat(context->keyboard);
		}

		// Render the menu if necessary
		if (!menu->rendered) {
			render_menu(menu);
		}
	}

	context_destroy(context);
	menu->context = NULL;

	if (menu->failure) {
		return EXIT_FAILURE;
	}
	return EXIT_SUCCESS;
}
