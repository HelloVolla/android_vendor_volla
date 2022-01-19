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
    IBMPlexSans-ThinItalic.ttf

VOLLA_SYSTEM_FONTS := \
    selawk.ttf \
    selawkb.ttf \
    selawkl.ttf \
    selawksb.ttf \
    selawksl.ttf

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
