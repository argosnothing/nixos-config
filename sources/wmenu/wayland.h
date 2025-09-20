#ifndef WMENU_WAYLAND_H
#define WMENU_WAYLAND_H

#include "menu.h"
#include <wayland-client-protocol.h>

struct wl_context;

int menu_run(struct menu *menu);

int context_get_scale(struct wl_context *context);
struct pool_buffer *context_get_current_buffer(struct wl_context *context);
struct pool_buffer *context_get_next_buffer(struct wl_context *context, int scale);
struct wl_surface *context_get_surface(struct wl_context *context);
struct xkb_state *context_get_xkb_state(struct wl_context *context);
struct xdg_activation_v1 *context_get_xdg_activation(struct wl_context *context);
bool context_paste(struct wl_context *context);

#endif
