if [[ ${CONFIGURATION} = "Debug" || ${IS_FIREBASE_DISTRIBUTION} = "true" ]]; then
    /usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName \"LGPDjus Dev\"" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
    /usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier \"${PRODUCT_BUNDLE_IDENTIFIER}.dev\"" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
fi