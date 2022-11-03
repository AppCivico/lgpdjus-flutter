#!/bin/bash

if [[ ${CONFIGURATION} = "Debug" || ${IS_FIREBASE_DISTRIBUTION} = "true" ]]; then
    /usr/libexec/PlistBuddy -c "Set :CFBundleName \"LGPDjus Dev\"" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
fi
