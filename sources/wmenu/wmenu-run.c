#define _POSIX_C_SOURCE 200809L
#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "menu.h"
#include "wayland.h"
#include "xdg-activation-v1-client-protocol.h"

static void read_items(struct menu *menu) {
	char *path = strdup(getenv("PATH"));
	for (char *p = strtok(path, ":"); p != NULL; p = strtok(NULL, ":")) {
		DIR *dir = opendir(p);
		if (dir == NULL) {
			continue;
		}
		for (struct dirent *ent = readdir(dir); ent != NULL; ent = readdir(dir)) {
			if (ent->d_name[0] == '.') {
				continue;
			}
			menu_add_item(menu, strdup(ent->d_name));
		}
		closedir(dir);
	}
	menu_sort_and_deduplicate(menu);
	free(path);
}

struct command {
	struct menu *menu;
	char *text;
	bool exit;
};

static void activation_token_done(void *data, struct xdg_activation_token_v1 *activation_token,
	const char *token) {
	struct command *cmd = data;
	xdg_activation_token_v1_destroy(activation_token);

	int pid = fork();
	if (pid == 0) {
		setenv("XDG_ACTIVATION_TOKEN", token, true);
		char *argv[] = {"/bin/sh", "-c", cmd->text, NULL};
		execvp(argv[0], (char**)argv);
	} else {
		if (cmd->exit) {
			cmd->menu->exit = true;
		}
	}
}

static const struct xdg_activation_token_v1_listener activation_token_listener = {
	.done = activation_token_done,
};

static void exec_item(struct menu *menu, char *text, bool exit) {
	struct command *cmd = calloc(1, sizeof(struct command));
	cmd->menu = menu;
	cmd->text = strdup(text);
	cmd->exit = exit;

	struct xdg_activation_v1 *activation = context_get_xdg_activation(menu->context);
	struct xdg_activation_token_v1 *activation_token = xdg_activation_v1_get_activation_token(activation);
	xdg_activation_token_v1_set_surface(activation_token, context_get_surface(menu->context));
	xdg_activation_token_v1_add_listener(activation_token, &activation_token_listener, cmd);
	xdg_activation_token_v1_commit(activation_token);
}

int main(int argc, char *argv[]) {
	struct menu *menu = menu_create(exec_item);
	menu_getopts(menu, argc, argv);
	read_items(menu);
	int status = menu_run(menu);
	menu_destroy(menu);
	return status;
}
