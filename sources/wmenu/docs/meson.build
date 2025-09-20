scdoc_dep = dependency('scdoc', version: '>=1.9.2', native: true, required: false)

if scdoc_dep.found()
	scdoc = find_program(
		scdoc_dep.get_pkgconfig_variable('scdoc'),
		native: true,
	)
	mandir = get_option('mandir')

	docs = [
		'wmenu.1',
	]

	foreach path : docs
		custom_target(
			path,
			output: path,
			input: '@0@.scd'.format(path),
			capture: true,
			feed: true,
			command: [scdoc],
			install: true,
			install_dir: '@0@/man1'.format(mandir)
		)
	endforeach
endif
