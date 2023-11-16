LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

VOLLA_PRODUCT_FONTS := \
    IBMPlexSans-Bold.ttf \
    IBMPlexSans-BoldItalic.ttf \
    IBMPlexSans-ExtraLight.ttf \
    IBMPlexSans-ExtraLightItalic.ttf \
    IBMPlexSans-Italic.ttf \
    IBMPlexSans-Light.ttf \
    IBMPlexSans-LightItalic.ttf \
    IBMPlexSans-Medium.ttf \
    IBMPlexSans-MediumItalic.ttf \
    IBMPlexSans-Regular.ttf \
    IBMPlexSans-SemiBold.ttf \
    IBMPlexSans-SemiBoldItalic.ttf \
    IBMPlexSans-Thin.ttf \
    IBMPlexSans-ThinItalic.ttf \
    Poppins-Black.ttf \
    Poppins-BlackItalic.ttf \
    Poppins-Bold.ttf \
    Poppins-BoldItalic.ttf \
    Poppins-ExtraBold.ttf \
    Poppins-ExtraBoldItalic.ttf \
    Poppins-ExtraLight.ttf \
    Poppins-ExtraLightItalic.ttf \
    Poppins-Italic.ttf \
    Poppins-Light.ttf \
    Poppins-LightItalic.ttf \
    Poppins-Medium.ttf \
    Poppins-MediumItalic.ttf \
    Poppins-Regular.ttf \
    Poppins-SemiBold.ttf \
    Poppins-SemiBoldItalic.ttf \
    Poppins-Thin.ttf \
    Poppins-ThinItalic.ttf \
    selawk.ttf \
    selawkb.ttf \
    selawkl.ttf \
    selawksb.ttf \
    selawksl.ttf

VOLLA_SYSTEM_FONTS := \
    NotoSans-Black.ttf \
    NotoSans-BlackItalic.ttf \
    NotoSans-Bold.ttf \
    NotoSans-BoldItalic.ttf \
    NotoSans-ExtraBold.ttf \
    NotoSans-ExtraBoldItalic.ttf \
    NotoSans-ExtraLight.ttf \
    NotoSans-ExtraLightItalic.ttf \
    NotoSans-Italic.ttf \
    NotoSans-Light.ttf \
    NotoSans-LightItalic.ttf \
    NotoSans-Medium.ttf \
    NotoSans-MediumItalic.ttf \
    NotoSans-Regular.ttf \
    NotoSans-SemiBold.ttf \
    NotoSans-SemiBoldItalic.ttf \
    NotoSans-Thin.ttf \
    NotoSans-ThinItalic.ttf

define define-volla-product-font
include $$(CLEAR_VARS)
LOCAL_MODULE := $1
LOCAL_MODULE_OWNER := volla
LOCAL_SRC_FILES := fonts/$1
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_PRODUCT)/fonts
LOCAL_PRODUCT_MODULE := true
include $$(BUILD_PREBUILT)
endef

$(foreach font,$(VOLLA_PRODUCT_FONTS),\
    $(eval $(call define-volla-product-font,$(font))))

define define-volla-system-font
include $$(CLEAR_VARS)
LOCAL_MODULE := $1
LOCAL_MODULE_OWNER := volla
LOCAL_SRC_FILES := fonts/$1
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT)/fonts
LOCAL_PRODUCT_MODULE := true
include $$(BUILD_PREBUILT)
endef

$(foreach font,$(VOLLA_SYSTEM_FONTS),\
    $(eval $(call define-volla-system-font,$(font))))

include $(CLEAR_VARS)
LOCAL_MODULE := VollaFonts
LOCAL_MODULE_OWNER := volla
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES := $(VOLLA_SYSTEM_FONTS) $(VOLLA_PRODUCT_FONTS)
include $(BUILD_PHONY_PACKAGE)
