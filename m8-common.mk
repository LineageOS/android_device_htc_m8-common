#
# Copyright (C) 2015 The CyanogenMod Project
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

$(call inherit-product-if-exists, vendor/htc/m8-common/m8-common-vendor.mk)

# Inherit from msm8974-common
$(call inherit-product, device/htc/msm8974-common/msm8974-common.mk)

# System properties
-include $(LOCAL_PATH)/system_prop.mk

# Overlay
DEVICE_PACKAGE_OVERLAYS += device/htc/m8-common/overlay

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.consumerir.xml:system/etc/permissions/android.hardware.consumerir.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    $(LOCAL_PATH)/configs/com.htc.software.market.xml:system/etc/permissions/com.htc.software.market.xml

# Camera
PRODUCT_PACKAGES += \
    camera.msm8974 \
    Snap

# Init
PRODUCT_PACKAGES += \
    init.target.rc

# IRDA
PRODUCT_BOOT_JARS += \
    htcirlibs

# NFC
PRODUCT_PACKAGES += \
    nfc.msm8974 \
    libnfc \
    libnfc_ndef \
    libnfc_jni \
    Nfc

# Variant linking script
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/releasetools/variant_script.sh:install/bin/variant_script.sh
