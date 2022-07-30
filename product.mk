#
# Copyright (C) 2021 Hallo Welt Systeme UG
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Project inherits
ifneq ($(strip $(VOLLA_BUILD_FLAVOR)),)
-include vendor/$(VOLLA_BUILD_FLAVOR)/product.mk
endif
$(call inherit-product, vendor/volla-prebuilt-apps/apps.mk)
$(call inherit-product, $(LOCAL_PATH)/prebuilts/product.mk)

# Overlay
PRODUCT_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += $(LOCAL_PATH)/overlay

ifeq ($(filter %_yggdrasil %_yggdrasilx,$(TARGET_PRODUCT)),)
PRODUCT_PACKAGE_OVERLAYS += $(LOCAL_PATH)/wallpaper-new
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += $(LOCAL_PATH)/wallpaper-new
else
PRODUCT_PACKAGE_OVERLAYS += $(LOCAL_PATH)/wallpaper-yggdrasil
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += $(LOCAL_PATH)/wallpaper-yggdrasil
endif

# Packages - Apps
PRODUCT_PACKAGES += \
    BootloaderManager \
    ChildModeSettings \
    F-DroidPrivilegedExtension \
    MtkCamera \
    SimpleAppsTheme

# Email
ifneq ($(filter %_yggdrasilx,$(TARGET_PRODUCT)),)
PRODUCT_PACKAGES += \
    Email \
    Exchange2 \
    K9Remover
endif
ifneq ($(filter %_yggdrasil,$(TARGET_PRODUCT)),)
PRODUCT_PACKAGES += \
    MtkEmail \
    K9Remover
endif
ifeq ($(filter %_yggdrasil %_yggdrasilx,$(TARGET_PRODUCT)),)
PRODUCT_PACKAGES += AOSPEmailRemover
endif

# Updater
ifeq ($(strip $(VOLLA_BUILD_FLAVOR)),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    lineage.updater.uri=https://ota.volla.tech/api/v1/{device}/{type}/{incr} \
    volla.updater.devel.uri=https://ota-devel.volla.tech/api/v1/{device}/{type}/{incr}
endif

# F-Droid repos
ifeq ($(strip $(VOLLA_BUILD_FLAVOR)),)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/FDroidRepos/additional_repos.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/org.fdroid.fdroid/additional_repos.xml
endif

# Fonts
PRODUCT_PACKAGES += \
    AOSPRobotoFont \
    VollaFonts \
    VollaPlexFont

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/volla_alarm.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/alarms/volla_alarm.ogg \
    $(LOCAL_PATH)/audio/volla_notification.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/notifications/volla_notification.ogg \
    $(LOCAL_PATH)/audio/volla_mail_incoming.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/notifications/volla_mail_incoming.ogg \
    $(LOCAL_PATH)/audio/volla_mail_outgoing.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/notifications/volla_mail_outgoing.ogg \
    $(LOCAL_PATH)/audio/volla_sms_incoming.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/notifications/volla_sms_incoming.ogg \
    $(LOCAL_PATH)/audio/volla_sms_outgoing.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/notifications/volla_sms_outgoing.ogg \
    $(LOCAL_PATH)/audio/volla_ringtone.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ringtones/volla_ringtone.ogg

PRODUCT_PRODUCT_PROPERTIES += \
    ro.config.ringtone=volla_ringtone.ogg \
    ro.config.notification_sound=volla_notification.ogg \
    ro.config.alarm_alert=volla_alarm.ogg

# Remove unwanted packages
PRODUCT_PACKAGES += \
    RemovePackages

# Color
PRODUCT_PACKAGES += \
    AccentColorTealOverlay

# NLP
PRODUCT_PACKAGES += \
    VollaNlp \
    VollaGSMNlp \
    VollaNlpRRO

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.boot.vendor.overlay.theme=com.volla.overlay.nlp

# DNS
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/dnsmasq/dnsmasq.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/dnsmasq.rc \
    $(LOCAL_PATH)/dnsmasq/volladns.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/volladns.conf
