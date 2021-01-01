#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017 The LineageOS Project
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

set -e

function blob_fixup() {
    case "${1}" in
    vendor/lib/hw/camera.vendor.msm8974.so)
        "${PATCHELF}" --replace-needed "libcamera_client.so" "libcamera_client_htc.so" "${2}"
        ;;
    esac
}

export BOARD_COMMON=msm8974-common
export DEVICE_COMMON=m8-common
export DEVICE_SPECIFIED_COMMON_DEVICE="m8 m8d"

./../$BOARD_COMMON/extract-files.sh $@
