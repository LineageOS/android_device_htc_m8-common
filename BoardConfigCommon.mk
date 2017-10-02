#
# Copyright (C) 2015-2016 The CyanogenMod Project
#               2017 The LineageOS Project
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

#
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

# WARNING: This line must come *before* including the proprietary
# variant, so that it gets overwritten by the parent (which goes
# against the traditional rules of inheritance).

# Inherit from common msm8974-common
-include device/htc/msm8974-common/BoardConfigCommon.mk

# Assertions
#TARGET_BOARD_INFO_FILE ?= device/htc/m8-common/board-info.txt

# Includes
TARGET_SPECIFIC_HEADER_PATH += device/htc/m8-common/include

# Camera
TARGET_NEEDS_PLATFORM_TEXT_RELOCATIONS := true
TARGET_SPECIFIC_CAMERA_PARAMETER_LIBRARY := libcamera_parameters_ext
USE_DEVICE_SPECIFIC_CAMERA := true

# NFC
BOARD_NFC_HAL_SUFFIX := msm8974

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := device/htc/m8-common/releasetools

# Inherit from the proprietary version
-include vendor/htc/m8-common/BoardConfigVendor.mk
