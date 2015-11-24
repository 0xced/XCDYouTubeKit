#!/bin/bash

set -o pipefail

: ${SCHEME:="XCDYouTubeKit iOS Static Library"}
: ${CONFIGURATION:="Release"}
: ${DESTINATION:="platform=iOS Simulator,name=iPhone 5s"}

COMMAND="env NSUnbufferedIO=YES xcodebuild clean test -project XCDYouTubeKit.xcodeproj -scheme '${SCHEME}' -configuration '${CONFIGURATION}' -destination '${DESTINATION}'"

for BUILD_SETTING in OBJROOT RUN_CLANG_STATIC_ANALYZER IPHONEOS_DEPLOYMENT_TARGET MACOSX_DEPLOYMENT_TARGET; do
    VALUE=`eval echo \\$"${BUILD_SETTING}"`
    if [ ! -z "${VALUE}" ]; then
        COMMAND+=" ${BUILD_SETTING}='${VALUE}'"
        unset ${BUILD_SETTING}
    fi
done

COMMAND+=" | tee xcodebuild.log"

xcpretty --version > /dev/null 2>&1 && COMMAND+=" | xcpretty -c" && xcpretty-travis-formatter > /dev/null 2>&1 && COMMAND+=" -f `xcpretty-travis-formatter`"

set -x
eval "${COMMAND}" && rm xcodebuild.log
