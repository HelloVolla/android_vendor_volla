LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := MtkCamera
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_TAGS := optional
LOCAL_OVERRIDES_PACKAGES := Snap Camera2
LOCAL_CERTIFICATE := platform
ifeq ($(filter %_yggdrasilx %_yggdrasilx,$(TARGET_PRODUCT)),)
LOCAL_SRC_FILES := MtkCamera.apk
else
LOCAL_SRC_FILES := MtkCamera_10.apk
endif
LOCAL_PRODUCT_MODULE := true
include $(BUILD_PREBUILT)
