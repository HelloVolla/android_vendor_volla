LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := SimpleAppsTheme
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_TAGS := optional
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_SRC_FILES := SimpleAppsTheme.apk
LOCAL_PRODUCT_MODULE := true
include $(BUILD_PREBUILT)
