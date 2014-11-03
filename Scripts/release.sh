#!/bin/bash -e

if [[ $# -ne 1 ]]; then
    echo "usage: $0 VERSION"
    exit 1
fi

VERSION=$1

git flow release start ${VERSION}

echo "Updating version"
set -v
xcproj -p "XCDYouTubeKit.xcodeproj" write-build-setting DYLIB_CURRENT_VERSION "${VERSION}"
xcproj -p "XCDYouTubeKit Demo/XCDYouTubeKit Demo.xcodeproj" write-build-setting CURRENT_PROJECT_VERSION "${VERSION}"
sed -i "" "s/^\(.*s.version.*=.*\)\".*\"/\1\"${VERSION}\"/" "XCDYouTubeKit.podspec"
set +v
git add "XCDYouTubeKit.xcodeproj"
git add "XCDYouTubeKit Demo/XCDYouTubeKit Demo.xcodeproj"
git add "XCDYouTubeKit.podspec"
git commit -m "Update version to ${VERSION}"

echo "Updating badges"
set -v
sed -i "" "s/develop\.svg/master.svg/g" "README.md"
sed -i "" "s/branch=develop/branch=master/g" "README.md"
set +v
git add "README.md"
git commit -m "Point badges to the master branch"
