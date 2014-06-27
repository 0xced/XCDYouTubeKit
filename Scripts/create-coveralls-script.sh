#!/bin/bash -e

if [[ -z "${TRAVIS_JOB_ID}" ]]; then
    exit 0
fi

COVERALLS_SCRIPT_PATH="${SRCROOT}/Scripts/coveralls.sh"
cat > "${COVERALLS_SCRIPT_PATH}" <<EOF
#!/bin/bash -e

cd "${OBJECT_FILE_DIR_normal}/${CURRENT_ARCH}"
for file in *.gcda; do
    gcov "\${file}"
done

coveralls --root "${SRCROOT}/XCDYouTubeKit" --no-gcov --extension ".m"
EOF

chmod +x "${COVERALLS_SCRIPT_PATH}"
