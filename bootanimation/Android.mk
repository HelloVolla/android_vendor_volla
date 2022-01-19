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

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := bootanimation.zip
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT)/media
ifeq ($(shell test $(TARGET_SCREEN_WIDTH) -gt 720; echo $$?),0)
LOCAL_SRC_FILES := bootanimation.zip
else
LOCAL_SRC_FILES := bootanimation_720.zip
endif
include $(BUILD_PREBUILT)
