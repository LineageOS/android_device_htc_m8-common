#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
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

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi

export CM_ROOT="$MY_DIR"/../../..

HELPER="$CM_ROOT"/vendor/cm/build/tools/extract_utils.sh
if [ ! -f "$HELPER" ]; then
    echo "Unable to find helper script at $HELPER"
    exit 1
fi
. "$HELPER"

if [ -z "$PRODUCTMK" ]; then
    echo "Product makefile is not set!"
    exit 1
fi

if [ -z "$ANDROIDMK" ]; then
    echo "Android makefile is not set!"
    exit 1
fi

if [ -z "$BOARDMK" ]; then
    echo "Board makefile is not set!"
    exit 1
fi

# Copyright headers
write_header "$PRODUCTMK"
write_header "$ANDROIDMK"
write_header "$BOARDMK"

# Add device barrier
cat << EOF >> "$ANDROIDMK"
LOCAL_PATH := \$(call my-dir)

ifeq (\$(TARGET_DEVICE),$DEVICE)

EOF

write_copy_list "$MY_DIR"/../$DEVICE/device-proprietary-files.txt
write_module_list "$MY_DIR"/../$DEVICE/device-proprietary-files.txt
write_copy_list "$MY_DIR"/proprietary-files.txt
write_module_list "$MY_DIR"/proprietary-files.txt

cat << EOF >> "$ANDROIDMK"
endif
EOF

# Setup makefiles for common device
export DEVICE=m8-common

. "$HELPER"

if [ -z "$PRODUCTMK" ]; then
    echo "Common Product makefile is not set!"
    exit 1
fi

if [ -z "$ANDROIDMK" ]; then
    echo "Common Android makefile is not set!"
    exit 1
fi

if [ -z "$BOARDMK" ]; then
    echo "Common Board makefile is not set!"
    exit 1
fi

# Copyright headers
write_header "$PRODUCTMK"
write_header "$ANDROIDMK"
write_header "$BOARDMK"

# Add device (common) barrier
cat << EOF >> "$ANDROIDMK"
LOCAL_PATH := \$(call my-dir)

ifneq (\$(filter m8 m8d,\$(TARGET_DEVICE)),)

EOF

write_copy_list "$MY_DIR"/common-proprietary-files.txt
write_module_list "$MY_DIR"/common-proprietary-files.txt

cat << EOF >> "$ANDROIDMK"
endif
EOF
