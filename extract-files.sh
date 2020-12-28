#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

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

"./../../${VENDOR}/${BOARD_COMMON}/extract-files.sh" "$@"
