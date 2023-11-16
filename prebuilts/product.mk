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

# Default permissions
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/etc/default-permissions/default_permissions_at.bitfire.davdroid.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/default-permissions/default_permissions_at.bitfire.davdroid.xml \
    $(LOCAL_PATH)/etc/default-permissions/default_permissions_com.aurora.store.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/default-permissions/default_permissions_com.aurora.store.xml \
    $(LOCAL_PATH)/etc/default-permissions/default_permissions_com.android.vending.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/default-permissions/default_permissions_com.android.vending.xml \
    $(LOCAL_PATH)/etc/default-permissions/default_permissions_com.google.android.gms.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/default-permissions/default_permissions_com.google.android.gms.xml \
    $(LOCAL_PATH)/etc/default-permissions/default_permissions_com.maxfour.music.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/default-permissions/default_permissions_com.maxfour.music.xml \
    $(LOCAL_PATH)/etc/default-permissions/default_permissions_com.simplemobiletools.calendar.pro.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/default-permissions/default_permissions_com.simplemobiletools.calendar.pro.xml \
    $(LOCAL_PATH)/etc/default-permissions/default_permissions_com.simplemobiletools.contacts.pro.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/default-permissions/default_permissions_com.simplemobiletools.contacts.pro.xml \
    $(LOCAL_PATH)/etc/default-permissions/default_permissions_com.simplemobiletools.dialer.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/default-permissions/default_permissions_com.simplemobiletools.dialer.xml \
    $(LOCAL_PATH)/etc/default-permissions/default_permissions_com.simplemobiletools.filemanager.pro.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/default-permissions/default_permissions_com.simplemobiletools.filemanager.pro.xml \
    $(LOCAL_PATH)/etc/default-permissions/default_permissions_com.simplemobiletools.gallery.pro.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/default-permissions/default_permissions_com.simplemobiletools.gallery.pro.xml \
    $(LOCAL_PATH)/etc/default-permissions/default_permissions_com.volla.launcher.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/default-permissions/default_permissions_com.volla.launcher.xml \
    $(LOCAL_PATH)/etc/default-permissions/default_permissions_net.osmand.plus.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/default-permissions/default_permissions_net.osmand.plus.xml \
    $(LOCAL_PATH)/etc/default-permissions/default_permissions_org.fdroid.fdroid.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/default-permissions/default_permissions_org.fdroid.fdroid.xml \
    $(LOCAL_PATH)/etc/default-permissions/default_permissions_com.volla.gsmnlp.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/default-permissions/default_permissions_com.volla.gsmnlp.xml

# Permissions
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/etc/permissions/whitelist_com.volla.launcher.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/whitelist_com.volla.launcher.xml \
    $(LOCAL_PATH)/etc/permissions/whitelist_com.google.android.gms.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/whitelist_com.google.android.gms.xml \
    $(LOCAL_PATH)/etc/permissions/whitelist_com.android.vending.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/whitelist_com.android.vending.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/etc/permissions/whitelist_com.mediatek.camera.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/whitelist_com.mediatek.camera.xml

# sysconfigs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/etc/sysconfig/whitelist_com.google.android.gms.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/whitelist_com.google.android.gms.xml

# GSM NLP database
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/etc/com.volla.gsmnlp/lacells.db:$(TARGET_COPY_OUT_SYSTEM)/etc/com.volla.gsmnlp/lacells.db

# Localhost SSL key
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/etc/localhost.bks:$(TARGET_COPY_OUT_SYSTEM)/etc/localhost.bks

# APNs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/etc/apns-conf.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/apns-conf.xml

# MtkCamera libs
ifeq ($(filter %_yggdrasilx %_yggdrasilx %_gsi_arm64,$(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/lib64/libimage_detect.so:$(TARGET_COPY_OUT_SYSTEM_EXT)/lib64/libimage_detect.so \
    $(LOCAL_PATH)/lib64/libnn_sample.so:$(TARGET_COPY_OUT_SYSTEM_EXT)/lib64/libnn_sample.so
endif
