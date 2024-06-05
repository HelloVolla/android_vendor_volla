# SELinux
ifneq ($(filter generic_%, $(TARGET_DEVICE)),)
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += vendor/extra/sepolicy/gsi_public
BUILD_WITHOUT_VENDOR := true
endif

ifeq ($(BUILD_WITHOUT_VENDOR), true)
    SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += vendor/extra/sepolicy/private_no_vendor
else
    BOARD_VENDOR_SEPOLICY_DIRS += vendor/extra/sepolicy/vendor
endif
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += vendor/extra/sepolicy/private
SELINUX_IGNORE_NEVERALLOWS := true
BUILD_BROKEN_DUP_RULES := true
