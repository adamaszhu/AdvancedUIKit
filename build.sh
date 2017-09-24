PROJECT_NAME="AdvancedUIKit"
PRODUCT_DIR="Product"
TEMP_DIR="Temp"
BUILD_DIR="build"

rm -rf "${PRODUCT_DIR}"
rm -rf "${TEMP_DIR}"
rm -rf "${BUILD_DIR}"
mkdir "${PRODUCT_DIR}"
mkdir "${TEMP_DIR}"

xcodebuild -target "${PROJECT_NAME}" -configuration Release -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO BUILD_DIR="${TEMP_DIR}" clean build
xcodebuild -target "${PROJECT_NAME}" -configuration Release -sdk iphoneos ONLY_ACTIVE_ARCH=NO BUILD_DIR="${TEMP_DIR}" clean build

cp -R "${TEMP_DIR}/Release-iphoneos/${PROJECT_NAME}.framework" "${PRODUCT_DIR}"
cp -R "${TEMP_DIR}/Release-iphonesimulator/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule/." "${PRODUCT_DIR}/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule"
lipo -create -output "${PRODUCT_DIR}/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${TEMP_DIR}/Release-iphoneos/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${TEMP_DIR}/Release-iphonesimulator/${PROJECT_NAME}.framework/${PROJECT_NAME}"

rm -rf "${BUILD_DIR}"
rm -rf "${TEMP_DIR}"

open "${PRODUCT_DIR}"
