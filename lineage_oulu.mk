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

# Inherit from oulu device
$(call inherit-product, device/motorola/oulu/device.mk)

PRODUCT_DEVICE := oulu
PRODUCT_NAME := lineage_oulu
PRODUCT_BRAND := motorola
PRODUCT_MODEL := motorola edge 2025
PRODUCT_MANUFACTURER := motorola

PRODUCT_GMS_CLIENTID_BASE := android-motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="oulu_g_sys-user 15 V2VDS35M.63-38-4-1-2 63d8c release-keys"

BUILD_FINGERPRINT := motorola/oulu_g_sys/oulu:15/V2VDS35M.63-38-4-1-2/63d8c:user/release-keys
