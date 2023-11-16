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
else
$(call inherit-product, vendor/volla-prebuilt-apps/apps.mk)
endif
$(call inherit-product, $(LOCAL_PATH)/prebuilts/product.mk)

# PicoTTS
$(call inherit-product, external/svox/svox_tts.mk)

# Overlay
PRODUCT_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += $(LOCAL_PATH)/overlay

ifeq ($(strip $(VOLLA_BUILD_FLAVOR)),)
PRODUCT_PACKAGE_OVERLAYS += $(LOCAL_PATH)/wallpaper
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += $(LOCAL_PATH)/wallpaper
endif

PRODUCT_BROKEN_VERIFY_USES_LIBRARIES := true

# Packages - Apps
PRODUCT_PACKAGES += \
    ChildModeSettings \
    F-DroidPrivilegedExtension
    
ifeq ($(filter %_gsi_arm64,$(TARGET_PRODUCT)),)
PRODUCT_PACKAGES += \
    MtkCamera
endif

ifeq ($(filter %_yggdrasil,$(TARGET_PRODUCT)),)
PRODUCT_PACKAGES += BootloaderManager
endif

ifneq ($(filter %_vidofnir,$(TARGET_PRODUCT)),)
PRODUCT_PACKAGES += \
    OpenEUICC
endif

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
    VollaPlexFont \
    VollaPoppinsFont \
    VollaSelawikFont

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/VollaFonts/fonts.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/fonts.xml \
    $(LOCAL_PATH)/VollaFonts/fonts_customization.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/fonts_customization.xml

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

# imei_restore
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/imei_restore/imei_restore.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/imei_restore.rc

# Wireguard
PRODUCT_PACKAGES += \
    wg-service \
    wg

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/app/VollaNlpRRO/VollaNlpRRO.apk \
    system/app/at.bitfire.davdroid/at.bitfire.davdroid.apk \
    system/app/com.aurora.store/com.aurora.store.apk \
    system/app/com.fsck.k9/com.fsck.k9.apk \
    system/app/com.google.android.gsf/com.google.android.gsf.apk \
    system/app/com.maxfour.music/com.maxfour.music.apk \
    system/app/com.simplemobiletools.calendar.pro/com.simplemobiletools.calendar.pro.apk \
    system/app/com.simplemobiletools.clock/com.simplemobiletools.clock.apk \
    system/app/com.simplemobiletools.contacts.pro/com.simplemobiletools.contacts.pro.apk \
    system/app/com.simplemobiletools.dialer/com.simplemobiletools.dialer.apk \
    system/app/com.simplemobiletools.filemanager.pro/com.simplemobiletools.filemanager.pro.apk \
    system/app/com.simplemobiletools.gallery.pro/com.simplemobiletools.gallery.pro.apk \
    system/app/hideme.android.vpn.noPlayStore-Stub/hideme.android.vpn.noPlayStore-Stub.apk \
    system/app/net.osmand.plus/net.osmand.plus.apk \
    system/app/org.fdroid.fdroid/org.fdroid.fdroid.apk \
    system/app/org.mozilla.fennec_fdroid-Stub/org.mozilla.fennec_fdroid-Stub.apk \
    system/etc/com.volla.gsmnlp/lacells.db \
    system/etc/init/abm.rc \
    system/etc/init/dnsmasq.rc \
    system/etc/init/imei_restore.rc \
    system/etc/localhost.bks \
    system/etc/org.fdroid.fdroid/additional_repos.xml \
    system/etc/permissions/permissions_org.fdroid.fdroid.privileged.xml \
    system/etc/permissions/whitelist_com.android.vending.xml \
    system/etc/permissions/whitelist_com.google.android.gms.xml \
    system/etc/permissions/whitelist_com.volla.launcher.xml \
    system/etc/sysconfig/whitelist_com.google.android.gms.xml \
    system/etc/volladns.conf \
    system/fonts/NotoSans-Black.ttf \
    system/fonts/NotoSans-BlackItalic.ttf \
    system/fonts/NotoSans-Bold.ttf \
    system/fonts/NotoSans-BoldItalic.ttf \
    system/fonts/NotoSans-ExtraBold.ttf \
    system/fonts/NotoSans-ExtraBoldItalic.ttf \
    system/fonts/NotoSans-ExtraLight.ttf \
    system/fonts/NotoSans-ExtraLightItalic.ttf \
    system/fonts/NotoSans-Italic.ttf \
    system/fonts/NotoSans-Light.ttf \
    system/fonts/NotoSans-LightItalic.ttf \
    system/fonts/NotoSans-Medium.ttf \
    system/fonts/NotoSans-MediumItalic.ttf \
    system/fonts/NotoSans-Regular.ttf \
    system/fonts/NotoSans-SemiBold.ttf \
    system/fonts/NotoSans-SemiBoldItalic.ttf \
    system/fonts/NotoSans-Thin.ttf \
    system/fonts/NotoSans-ThinItalic.ttf \
    system/media/bootanimation.zip \
    system/priv-app/BootloaderManager/BootloaderManager.apk \
    system/priv-app/F-DroidPrivilegedExtension/F-DroidPrivilegedExtension.apk \
    system/priv-app/com.android.vending/com.android.vending.apk \
    system/priv-app/com.google.android.gms/com.google.android.gms.apk \
    system/priv-app/com.volla.launcher-Stub/com.volla.launcher-Stub.apk
