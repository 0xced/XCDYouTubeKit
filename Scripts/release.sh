#!/bin/bash -e

function update_badges()
{
    echo "Updating badges"
    set -v
    sed -i "" "s/$1\.svg/$2.svg/g" "README.md"
    sed -i "" "s/branch=$1/branch=$2/g" "README.md"
    set +v
    git add "README.md"
    git commit -m "Point badges to the $2 branch"
}

if [[ $# -ne 1 ]]; then
    echo "usage: $0 VERSION"
    exit 1
fi

VERSION=$1
VERSION_PARTS=(${VERSION//./ })

grep "#### Version ${VERSION}" RELEASE_NOTES.md > /dev/null || (echo "RELEASE_NOTES.md must contain release notes for version ${VERSION}" && exit 1)

git flow release start ${VERSION}

echo "Updating CHANGELOG"
echo -e "$(cat RELEASE_NOTES.md)\n\n$(cat CHANGELOG.md)" > CHANGELOG.md
git add CHANGELOG.md
git commit -m "Update CHANGELOG for version ${VERSION}"

echo "Updating version"
CURRENT_PROJECT_VERSION=$(xcodebuild -project XCDYouTubeKit.xcodeproj -showBuildSettings | awk '/CURRENT_PROJECT_VERSION/{print $3}')
CURRENT_PROJECT_VERSION=$(expr ${CURRENT_PROJECT_VERSION} + 1)
set -v
sed -i "" "s/DYLIB_CURRENT_VERSION = .*;/DYLIB_CURRENT_VERSION = ${VERSION};/g" "XCDYouTubeKit.xcodeproj/project.pbxproj"
sed -i "" "s/CURRENT_PROJECT_VERSION = .*;/CURRENT_PROJECT_VERSION = ${CURRENT_PROJECT_VERSION};/g" "XCDYouTubeKit.xcodeproj/project.pbxproj"
sed -i "" "s/CURRENT_PROJECT_VERSION = .*;/CURRENT_PROJECT_VERSION = ${VERSION};/g" "XCDYouTubeKit Demo/XCDYouTubeKit Demo.xcodeproj/project.pbxproj"
sed -i "" "s/^\(.*s.version.*=.*\)\".*\"/\1\"${VERSION}\"/" "XCDYouTubeKit.podspec"
sed -E -i "" "s/~> [0-9\.]+/~> ${VERSION_PARTS[0]}.${VERSION_PARTS[1]}/g" "README.md"
set +v
git add "XCDYouTubeKit.xcodeproj"
git add "XCDYouTubeKit Demo/XCDYouTubeKit Demo.xcodeproj"
git add "XCDYouTubeKit.podspec"
git add "README.md"
git commit -m "Update version to ${VERSION}"

update_badges "develop" "master"

pod lib lint --verbose XCDYouTubeKit.podspec

git flow release finish -s -f RELEASE_NOTES.md ${VERSION}

echo -e "#### Version X.Y.Z\n\n* " > RELEASE_NOTES.md

update_badges "master" "develop"

echo "Things remaining to do"
echo "  * git push with tags (master and develop)"
echo "  * check that build is passing on travis: https://travis-ci.org/0xced/XCDYouTubeKit/"
echo "  * pod trunk push --verbose XCDYouTubeKit.podspec"
echo "  * pod spec lint --verbose XCDYouTubeKit.podspec"
echo "  * create a new release on GitHub: https://github.com/0xced/XCDYouTubeKit/releases/new"
echo "  * close milestone on GitHub if applicable: https://github.com/0xced/XCDYouTubeKit/milestones"
