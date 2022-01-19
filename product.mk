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
$(call inherit-product, vendor/volla-prebuilt-apps/apps.mk)
$(call inherit-product, $(LOCAL_PATH)/prebuilts/product.mk)

# Overlay
PRODUCT_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += $(LOCAL_PATH)/overlay

# Packages - Apps
PRODUCT_PACKAGES += \
    F-DroidPrivilegedExtension \
    MtkCamera \
    SimpleAppsTheme

# Updater
ifneq ($(filter RELEASE,$(VOLLA_BUILDTYPE)),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    lineage.updater.uri=https://ota.volla.tech/api/v1/{device}/{type}/{incr}
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    lineage.updater.uri=https://ota-devel.volla.tech/api/v1/{device}/{type}/{incr}
endif

# F-Droid repos
PRODUCT_PACKAGES += \
    additional_repos.xml

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
