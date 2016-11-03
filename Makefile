export SCAN_PROJECT = XCDYouTubeKit.xcodeproj
export SCAN_SCHEME = XCDYouTubeKit Framework
export SCAN_OUTPUT_TYPES = 

.PHONY: default test_macOS_report test_iOS_report test_tvOS_report test_macOS test_iOS test_tvOS test_iOS_9 check_scan check_slather

default: check_slather check_scan
	scan --clean --destination "platform=iOS Simulator,name=iPhone 5s" --code_coverage
	slather coverage --verbose --output-directory "${TMPDIR}/${SCAN_SCHEME} Coverage Report" --html --show --ignore "../**/Contents/Developer/**" --scheme "${SCAN_SCHEME}" "${SCAN_PROJECT}" || true

test_macOS_report: check_scan
	scan --destination "platform=OS X"                               --output_directory "${CIRCLE_TEST_REPORTS}/junit/" --output_types junit --custom_report_file_name test-results-macOS.xml

test_iOS_report: check_scan
	scan --destination "platform=iOS Simulator,name=iPhone 5s"       --output_directory "${CIRCLE_TEST_REPORTS}/junit/" --output_types junit --custom_report_file_name test-results-iOS.xml --code_coverage --xcargs "OBJROOT=build GCC_GENERATE_TEST_COVERAGE_FILES=YES GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES"

test_tvOS_report: check_scan
	scan --destination "platform=tvOS Simulator,name=Apple TV 1080p" --output_directory "${CIRCLE_TEST_REPORTS}/junit/" --output_types junit --custom_report_file_name test-results-tvOS.xml

test_macOS: check_scan
	scan --configuration Release --destination "platform=OS X"                               --xcargs "RUN_CLANG_STATIC_ANALYZER=YES CLANG_STATIC_ANALYZER_MODE=Deep MACOSX_DEPLOYMENT_TARGET=`xcrun --sdk "macosx" --show-sdk-version`"

test_iOS: check_scan
	scan --configuration Release --destination "platform=iOS Simulator,name=iPhone 5s"       --xcargs "RUN_CLANG_STATIC_ANALYZER=YES CLANG_STATIC_ANALYZER_MODE=Deep IPHONEOS_DEPLOYMENT_TARGET=`xcrun --sdk "iphonesimulator" --show-sdk-version`"

test_tvOS: check_scan
	scan --configuration Release --destination "platform=tvOS Simulator,name=Apple TV 1080p" --xcargs "RUN_CLANG_STATIC_ANALYZER=YES CLANG_STATIC_ANALYZER_MODE=Deep TVOS_DEPLOYMENT_TARGET=`xcrun --sdk "appletvsimulator" --show-sdk-version`"

test_iOS_9: check_scan
	scan --destination "platform=iOS Simulator,name=iPhone 5s,OS=9.0"

check_scan:
	@scan --version > /dev/null 2>&1 || (printf "❌  Please install \e[1;30mscan\e[0m (https://github.com/fastlane/fastlane/tree/master/scan) to run unit tests: $$ [sudo] \e[1;30mgem install scan\e[0m\n" && false)

check_slather:
	@slather version > /dev/null 2>&1 || printf "⚠️  Please install \e[1;30mslather\e[0m (https://github.com/SlatherOrg/slather) to get a code coverage report: $$ [sudo] \e[1;30mgem install slather\e[0m\n"
