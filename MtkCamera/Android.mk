LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := MtkCamera
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_TAGS := optional
LOCAL_OVERRIDES_PACKAGES := Snap Camera2 Aperture
LOCAL_CERTIFICATE := platform
LOCAL_SRC_FILES := MtkCamera.apk
LOCAL_SYSTEM_EXT_MODULE := true
include $(BUILD_PREBUILT)

MTKCAMERA_LIBS := libnn_sample.so libimage_detect.so
MTKCAMERA_SYMLINKS := $(addprefix $(TARGET_OUT_SYSTEM_EXT_APPS)/MtkCamera/lib/arm64/,$(notdir $(MTKCAMERA_LIBS)))
$(MTKCAMERA_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Mtk Camera lib link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /system_ext/lib64/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(MTKCAMERA_SYMLINKS)
