#!/usr/bin/python

import os, plistlib, sys

run_clang_static_analyzer = os.environ.get('RUN_CLANG_STATIC_ANALYZER', '0').strip(' ')
if not run_clang_static_analyzer[:1] in 'YyTt123456789':
	sys.exit(0)

analyzer_results_dir = os.path.join(os.environ['TARGET_TEMP_DIR'], 'StaticAnalyzer', os.environ['PROJECT_NAME'], os.environ['TARGET_NAME'], os.environ['CURRENT_VARIANT'], os.environ['CURRENT_ARCH'])
if not os.path.exists(analyzer_results_dir):
	sys.exit("error: Static Anaylzer results not found, expected in %s" % analyzer_results_dir)

exit_code = 0
for result in os.listdir(analyzer_results_dir):
	with open(os.path.join(analyzer_results_dir, result)) as f:
		plist = plistlib.readPlist(f)
		for diagnostic in plist['diagnostics']:
			location = diagnostic['location']
			path = plist['files'][location['file']]
			print "%s:%s:%s: error: Static Anaylzer Issue: %s" % (path, location['line'], location['col'], diagnostic['description'])
			exit_code = 1

sys.exit(exit_code)
