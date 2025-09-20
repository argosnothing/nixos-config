#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <string.h>

#include "menu.h"
#include "wayland.h"

static void read_items(struct menu *menu) {
	char buf[sizeof menu->input];
	while (fgets(buf, sizeof buf, stdin)) {
		char *p = strchr(buf, '\n');
		if (p) {
			*p = '\0';
		}
		menu_add_item(menu, strdup(buf));
	}
}

static void print_item(struct menu *menu, char *text, bool exit) {
	puts(text);
	fflush(stdout);
	if (exit) {
		menu->exit = true;
	}
}

int main(int argc, char *argv[]) {
	struct menu *menu = menu_create(print_item);
	menu_getopts(menu, argc, argv);
	read_items(menu);
	int status = menu_run(menu);
	menu_destroy(menu);
	return status;
}
