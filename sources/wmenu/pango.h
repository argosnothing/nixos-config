#ifndef WMENU_PANGO_H
#define WMENU_PANGO_H
#include <stdbool.h>
#include <cairo/cairo.h>
#include <pango/pangocairo.h>

int get_font_height(const char *font);
PangoLayout *get_pango_layout(cairo_t *cairo, const char *font,
		const char *text, double scale);
void get_text_size(cairo_t *cairo, const char *font, int *width, int *height,
		int *baseline, double scale, const char *text);
int text_width(cairo_t *cairo, const char *font, const char *text);
void pango_printf(cairo_t *cairo, const char *font, double scale,
		const char *text);

#endif
