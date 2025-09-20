project(
	'wmenu',
	'c',
	version: '0.2.0',
	license: 'MIT',
	default_options: [
		'c_std=c11',
		'warning_level=2',
		'werror=true',
	]
)

cc = meson.get_compiler('c')

add_project_arguments(cc.get_supported_arguments([
	'-DVERSION="@0@"'.format(meson.project_version()),

	'-Wno-missing-field-initializers',
	'-Wno-unused-parameter',
	'-Wundef',
	'-Wvla',
]), language : 'c')

cairo           = dependency('cairo')
pango           = dependency('pango')
pangocairo      = dependency('pangocairo')
wayland_client  = dependency('wayland-client')
wayland_protos  = dependency('wayland-protocols')
xkbcommon       = dependency('xkbcommon')

rt = cc.find_library('rt')

subdir('protocols')
subdir('docs')

executable(
	'wmenu',
	files(
		'menu.c',
		'pango.c',
		'pool-buffer.c',
		'render.c',
		'wayland.c',
		'wmenu.c',
	),
	dependencies: [
		cairo,
		client_protos,
		pango,
		pangocairo,
		rt,
		wayland_client,
		wayland_protos,
		xkbcommon,
	],
	install: true,
)

executable(
	'wmenu-run',
	files(
		'menu.c',
		'pango.c',
		'pool-buffer.c',
		'render.c',
		'wayland.c',
		'wmenu-run.c',
	),
	dependencies: [
		cairo,
		client_protos,
		pango,
		pangocairo,
		rt,
		wayland_client,
		wayland_protos,
		xkbcommon,
	],
	install: true,
)
