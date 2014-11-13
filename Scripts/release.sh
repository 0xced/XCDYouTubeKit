#!/bin/bash -e

if [[ $# -ne 1 ]]; then
    echo "usage: $0 VERSION"
    exit 1
fi

VERSION=$1

git flow release start ${VERSION}

echo "Updating version"
set -v
sed -i "" "s/DYLIB_CURRENT_VERSION = .*;/DYLIB_CURRENT_VERSION = ${VERSION};/g" "XCDYouTubeKit.xcodeproj/project.pbxproj"
sed -i "" "s/CURRENT_PROJECT_VERSION = .*;/CURRENT_PROJECT_VERSION = ${VERSION};/g" "XCDYouTubeKit Demo/XCDYouTubeKit Demo.xcodeproj/project.pbxproj"
sed -i "" "s/^\(.*s.version.*=.*\)\".*\"/\1\"${VERSION}\"/" "XCDYouTubeKit.podspec"
sed -i "" "s/\"~> .*\"/\"~> ${VERSION}\"/g" "README.md"
set +v
git add "XCDYouTubeKit.xcodeproj"
git add "XCDYouTubeKit Demo/XCDYouTubeKit Demo.xcodeproj"
git add "XCDYouTubeKit.podspec"
git add "README.md"
git commit -m "Update version to ${VERSION}"

echo "Updating badges"
set -v
sed -i "" "s/develop\.svg/master.svg/g" "README.md"
sed -i "" "s/branch=develop/branch=master/g" "README.md"
set +v
git add "README.md"
git commit -m "Point badges to the master branch"
