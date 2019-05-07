#!/usr/bin/python

import glob, os, plistlib, sys

run_clang_static_analyzer = os.environ.get('RUN_CLANG_STATIC_ANALYZER', '0').strip(' ')
if not run_clang_static_analyzer[:1] in 'YyTt123456789':
	sys.exit(0)

base_dir = os.path.join(os.environ['TARGET_TEMP_DIR'], 'StaticAnalyzer', os.environ['PROJECT_NAME'], os.environ['TARGET_NAME'], os.environ['CURRENT_VARIANT'])
analyzer_results_dirs = map(lambda arch : os.path.join(base_dir, arch), os.environ['ARCHS'].split(' '))
results = []
for analyzer_results_dir in analyzer_results_dirs:
	results.extend(glob.iglob(os.path.join(analyzer_results_dir, "*.plist")))
if len(results) == 0:
	sys.exit("error: Static Anaylzer plist results not found, searched inside <%s>" % '> and <'.join(analyzer_results_dirs))

exit_code = 0
for result in results:
	with open(result) as f:
		plist = plistlib.readPlist(f)
		for diagnostic in plist['diagnostics']:
			location = diagnostic['location']
			path = plist['files'][location['file']]
			print "%s:%s:%s: error: Static Anaylzer Issue: %s" % (path, location['line'], location['col'], diagnostic['description'])
			exit_code = 1

sys.exit(exit_code)
