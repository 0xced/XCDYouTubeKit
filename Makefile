CIRCLE_ARTIFACTS ?= artifacts
CIRCLE_TEST_REPORTS ?= test_reports

export SCAN_PROJECT = XCDYouTubeKit.xcodeproj
export SCAN_SCHEME = XCDYouTubeKit Framework
export SCAN_BUILDLOG_PATH = ${CIRCLE_ARTIFACTS}/$@
export SCAN_OUTPUT_TYPES = 

# Trying to workaround "Exit status: 74" error on CircleCI, see https://github.com/fastlane/fastlane/issues/8909#issuecomment-295788554
export SCAN_INCLUDE_SIMULATOR_LOGS = false

.PHONY: default test_macOS_report test_iOS_report test_tvOS_report test_macOS test_iOS test_tvOS test_iOS_9 check_scan check_slather

default: check_slather check_scan
	fastlane scan --clean --device "iPhone 5s" --code_coverage --buildlog_path "~/Library/Logs/scan"
	slather coverage --verbose --output-directory "${TMPDIR}/${SCAN_SCHEME} Coverage Report" --html --show --ignore "../**/Contents/Developer/**" --scheme "${SCAN_SCHEME}" "${SCAN_PROJECT}" || true

test_macOS_report: check_scan
	fastlane scan --output_directory "${CIRCLE_TEST_REPORTS}" --output_types junit --output_files $@.xml

test_iOS_report: check_scan
	fastlane scan --output_directory "${CIRCLE_TEST_REPORTS}" --output_types junit --output_files $@.xml --device "iPhone 5s" --code_coverage --xcargs "OBJROOT=build GCC_GENERATE_TEST_COVERAGE_FILES=YES GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES"

test_tvOS_report: check_scan
	fastlane scan --output_directory "${CIRCLE_TEST_REPORTS}" --output_types junit --output_files $@.xml --device "Apple TV"

test_macOS: check_scan
	fastlane scan --configuration Release                           --xcargs "RUN_CLANG_STATIC_ANALYZER=YES CLANG_STATIC_ANALYZER_MODE=Deep MACOSX_DEPLOYMENT_TARGET=`xcrun --sdk "macosx" --show-sdk-version`"

test_iOS: check_scan
	fastlane scan --configuration Release --device "iPhone 5s"      --xcargs "RUN_CLANG_STATIC_ANALYZER=YES CLANG_STATIC_ANALYZER_MODE=Deep IPHONEOS_DEPLOYMENT_TARGET=`xcrun --sdk "iphonesimulator" --show-sdk-version`"

test_tvOS: check_scan
	fastlane scan --configuration Release --device "Apple TV" --xcargs "RUN_CLANG_STATIC_ANALYZER=YES CLANG_STATIC_ANALYZER_MODE=Deep TVOS_DEPLOYMENT_TARGET=`xcrun --sdk "appletvsimulator" --show-sdk-version`"

test_iOS_9: check_scan
	fastlane scan --device "iPhone 5s (9.0)"

check_scan:
	@fastlane scan --version > /dev/null 2>&1 || (printf "❌  Please install \e[1;30mfastlane scan\e[0m (https://docs.fastlane.tools/actions/scan/) to run unit tests: $$ [sudo] \e[1;30mgem install fastlane\e[0m\n" && false)

check_slather:
	@slather version > /dev/null 2>&1 || printf "⚠️  Please install \e[1;30mslather\e[0m (https://github.com/SlatherOrg/slather) to get a code coverage report: $$ [sudo] \e[1;30mgem install slather\e[0m\n"
