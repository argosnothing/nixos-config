#include <cairo/cairo.h>
#include <pango/pangocairo.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "pango.h"

int get_font_height(const char *fontstr) {
	PangoFontMap *fontmap = pango_cairo_font_map_get_default();
	PangoContext *context = pango_font_map_create_context(fontmap);
	PangoFontDescription *desc = pango_font_description_from_string(fontstr);
	PangoFont *font = pango_font_map_load_font(fontmap, context, desc);
	if (font == NULL) {
		pango_font_description_free(desc);
		g_object_unref(context);
		return -1;
	}
	PangoFontMetrics *metrics = pango_font_get_metrics(font, NULL);
	int height = pango_font_metrics_get_height(metrics) / PANGO_SCALE;
	pango_font_metrics_unref(metrics);
	g_object_unref(font);
	pango_font_description_free(desc);
	g_object_unref(context);
	return height;
}

PangoLayout *get_pango_layout(cairo_t *cairo, const char *font,
		const char *text, double scale) {
	PangoLayout *layout = pango_cairo_create_layout(cairo);
	PangoAttrList *attrs = pango_attr_list_new();
	pango_layout_set_text(layout, text, -1);
	pango_attr_list_insert(attrs, pango_attr_scale_new(scale));
	PangoFontDescription *desc = pango_font_description_from_string(font);
	pango_layout_set_font_description(layout, desc);
	pango_layout_set_single_paragraph_mode(layout, 1);
	pango_layout_set_attributes(layout, attrs);
	pango_font_description_free(desc);
	pango_attr_list_unref(attrs);
	return layout;
}

void get_text_size(cairo_t *cairo, const char *font, int *width, int *height,
		int *baseline, double scale, const char *text) {
	PangoLayout *layout = get_pango_layout(cairo, font, text, scale);
	pango_cairo_update_layout(cairo, layout);
	pango_layout_get_pixel_size(layout, width, height);
	if (baseline) {
		*baseline = pango_layout_get_baseline(layout) / PANGO_SCALE;
	}
	g_object_unref(layout);
}

int text_width(cairo_t *cairo, const char *font, const char *text) {
	int text_width;
	get_text_size(cairo, font, &text_width, NULL, NULL, 1, text);
	return text_width;
}

void pango_printf(cairo_t *cairo, const char *font, double scale,
		const char *text) {
	PangoLayout *layout = get_pango_layout(cairo, font, text, scale);
	cairo_font_options_t *fo = cairo_font_options_create();
	cairo_get_font_options(cairo, fo);
	pango_cairo_context_set_font_options(pango_layout_get_context(layout), fo);
	cairo_font_options_destroy(fo);
	pango_cairo_update_layout(cairo, layout);
	pango_cairo_show_layout(cairo, layout);
	g_object_unref(layout);
}
