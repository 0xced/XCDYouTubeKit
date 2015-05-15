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

git flow release start ${VERSION}

echo "Updating version"
set -v
sed -i "" "s/DYLIB_CURRENT_VERSION = .*;/DYLIB_CURRENT_VERSION = ${VERSION};/g" "XCDYouTubeKit.xcodeproj/project.pbxproj"
sed -i "" "s/CURRENT_PROJECT_VERSION = .*;/CURRENT_PROJECT_VERSION = ${VERSION};/g" "XCDYouTubeKit Demo/XCDYouTubeKit Demo.xcodeproj/project.pbxproj"
sed -i "" "s/^\(.*s.version.*=.*\)\".*\"/\1\"${VERSION}\"/" "XCDYouTubeKit.podspec"
sed -E -i "" "s/~> [0-9\.]+/~> ${VERSION}/g" "README.md"
set +v
git add "XCDYouTubeKit.xcodeproj"
git add "XCDYouTubeKit Demo/XCDYouTubeKit Demo.xcodeproj"
git add "XCDYouTubeKit.podspec"
git add "README.md"
git commit -m "Update version to ${VERSION}"

update_badges "develop" "master"

git flow release finish ${VERSION}

update_badges "master" "develop"

echo "Things remaining to do"
echo "  * git push with tags (master and develop)"
echo "  * check that build is passing on travis: https://travis-ci.org/0xced/XCDYouTubeKit/"
echo "  * pod spec lint --verbose XCDYouTubeKit.podspec"
echo "  * pod trunk push XCDYouTubeKit.podspec --verbose"
echo "  * create a new release on GitHub: https://github.com/0xced/XCDYouTubeKit/releases/new"
echo "  * close milestone on GitHub if applicable: https://github.com/0xced/XCDYouTubeKit/milestones"
