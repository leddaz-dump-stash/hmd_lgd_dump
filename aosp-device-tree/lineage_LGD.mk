#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from LGD device
$(call inherit-product, device/hmd/LGD/device.mk)

PRODUCT_DEVICE := LGD
PRODUCT_NAME := lineage_LGD
PRODUCT_BRAND := HMD
PRODUCT_MODEL := Legend
PRODUCT_MANUFACTURER := hmd

PRODUCT_GMS_CLIENTID_BASE := android-hmd

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="Legend_00EEA-user 14 UP1A.231005.007 V1.520_B01 release-keys"

BUILD_FINGERPRINT := HMD/Legend_00EEA/LGD:14/UP1A.231005.007/00WW_1_520:user/release-keys
