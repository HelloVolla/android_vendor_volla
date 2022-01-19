#!/bin/bash
set -e
LOCALDIR=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`
mkdir -p $LOCALDIR/../volla-prebuilt-apps
cd $LOCALDIR/../volla-prebuilt-apps/

repo="https://f-droid.org/repo/"

addCopy() {

if [ "$2"  == "YES" ] || [ "$3"  == "YES" ];then
cp apk/$1.apk apk/$1-Stub.apk
gzip apk/$1.apk
cat >> Android.mk <<EOF
include \$(CLEAR_VARS)
LOCAL_MODULE := $1-Stub
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := apk/$1-Stub.apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := \$(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_OVERRIDES_PACKAGES := $2
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_DEX_PREOPT := nostripping
LOCAL_POST_INSTALL_CMD = mkdir -p \$(TARGET_OUT)/app/$1 && cp \$(LOCAL_PATH)/apk/$1.apk.gz \$(TARGET_OUT)/app/$1/
include \$(BUILD_PREBUILT)
EOF
echo -e "\t$1-Stub \\" >> apps.mk
else
cat >> Android.mk <<EOF
include \$(CLEAR_VARS)
LOCAL_MODULE := $1
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := apk/$1.apk
LOCAL_MODULE_CLASS := APPS
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_OVERRIDES_PACKAGES := $2
include \$(BUILD_PREBUILT)
EOF
echo -e "\t$1 \\" >> apps.mk
fi
}

rm -Rf apps.mk lib apk
cat > Android.mk <<EOF
LOCAL_PATH := \$(my-dir)

EOF
echo -e 'PRODUCT_PACKAGES += \\' > apps.mk

mkdir -p apk

#downloadFromFdroid packageName overrides extract_jnis
downloadFromFdroid() {
	mkdir -p tmp
    [ "$oldRepo" != "$repo" ] && rm -f tmp/index.xml
    oldRepo="$repo"
	if [ ! -f tmp/index.xml ]; then
		wget --connect-timeout=10 $repo/index.xml -O tmp/index.xml
	fi
	marketvercode="$(xmlstarlet sel -t -m '//application[id="'"$1"'"]' -v ./marketvercode tmp/index.xml || true)"
	apk="$(xmlstarlet sel -t -m '//application[id="'"$1"'"]/package[versioncode="'"$marketvercode"'"]' -v ./apkname tmp/index.xml || xmlstarlet sel -t -m '//application[id="'"$1"'"]/package[1]' -v ./apkname tmp/index.xml)"
    while ! wget --connect-timeout=10 $repo/$apk -O apk/$1.apk;do sleep 1;done
	addCopy $1 "$2" $3
}

downloadFromFdroid org.fdroid.fdroid
downloadFromFdroid at.bitfire.davdroid
downloadFromFdroid com.aurora.store
downloadFromFdroid com.simplemobiletools.calendar.pro "Etar Calendar"
downloadFromFdroid com.simplemobiletools.clock "DeskClock"
downloadFromFdroid com.simplemobiletools.contacts.pro "Contacts"
downloadFromFdroid com.simplemobiletools.dialer
downloadFromFdroid com.simplemobiletools.filemanager.pro
downloadFromFdroid com.simplemobiletools.gallery.pro "Gallery2 Gallery Gallery3D GalleryNew3D"
downloadFromFdroid com.simplemobiletools.notes.pro
downloadFromFdroid com.simplemobiletools.thankyou
downloadFromFdroid net.osmand.plus
downloadFromFdroid org.mozilla.fennec_fdroid "Jelly" YES
downloadFromFdroid com.maxfour.music "Eleven"


repo=https://fdroid.volla.tech/fdroid/repo/

downloadFromFdroid com.volla.launcher "" YES
downloadFromFdroid hideme.android.vpn.noPlayStore "" YES

echo >> apps.mk

rm -Rf tmp
