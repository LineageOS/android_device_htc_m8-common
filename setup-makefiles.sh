#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Initialize the helper for common device
setup_vendor "$DEVICE_COMMON" "$VENDOR" "$ANDROID_ROOT" true

# Warning headers and common guards
write_headers "m8 m8d"

write_makefiles "$MY_DIR"/common-proprietary-files.txt

write_footers

# Reinitialize the helper for device
setup_vendor "$DEVICE" "$VENDOR" "$ANDROID_ROOT"

# Warning headers and guards
write_headers

write_makefiles "$MY_DIR"/../$DEVICE/device-proprietary-files.txt
write_makefiles "$MY_DIR"/proprietary-files.txt

write_footers

./../msm8974-common/setup-makefiles.sh $@
