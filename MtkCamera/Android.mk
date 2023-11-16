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
LOCAL_SYSTEM_EXT_MODULE := true
include $(BUILD_PREBUILT)

ifeq ($(filter %_yggdrasilx %_yggdrasilx %_gsi_arm64,$(TARGET_PRODUCT)),)
MTKCAMERA_LIBS := libnn_sample.so libimage_detect.so
MTKCAMERA_SYMLINKS := $(addprefix $(TARGET_OUT_SYSTEM_EXT_APPS_PRIVILEGED)/MtkCamera/lib/arm64/,$(notdir $(MTKCAMERA_LIBS)))
$(MTKCAMERA_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Mtk Camera lib link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /system_ext/lib64/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(MTKCAMERA_SYMLINKS)
endif
