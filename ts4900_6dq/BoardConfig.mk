#
# Product-specific compile-time definitions.
#

include device/fsl/imx6/soc/imx6dq.mk
include device/fsl/ts4900_6dq/build_id.mk
include device/fsl/imx6/BoardConfigCommon.mk
include device/fsl-proprietary/gpu-viv/fsl-gpu.mk

# TS-4900 default target for EXT4
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true
BUILD_TARGET_FS ?= ext4
include device/fsl/imx6/imx6_target_fs.mk

TARGET_RECOVERY_FSTAB = device/fsl/ts4900_6dq/fstab.freescale
PRODUCT_MODEL := TS4900-MX6DQ

PRODUCT_COPY_FILES += \
	device/fsl/ts4900_6dq/fstab.freescale:root/fstab.freescale \
	device/fsl/ts4900_6dq/firmware/wl12xx/wl1271-nvs.bin:system/etc/firmware/ti-connectivity/wl1271-nvs.bin \
	device/fsl/ts4900_6dq/firmware/wl12xx//wl127x-fw-5-sr.bin:system/etc/firmware/ti-connectivity/wl127x-fw-5-sr.bin \
	device/fsl/ts4900_6dq/firmware/wl12xx/wl127x-fw-5-mr.bin:system/etc/firmware/ti-connectivity/wl127x-fw-5-mr.bin \
	device/fsl/ts4900_6dq/firmware/wl12xx/TIInit_7.6.15.bts:system/etc/firmware/ti-connectivity/TIInit_7.6.15.bts \
	device/fsl/ts4900_6dq/firmware/wl12xx/TIInit_7.2.31.bts:system/etc/firmware/ti-connectivity/TIInit_7.2.31.bts

TARGET_KERNEL_MODULES := \
    kernel_imx/drivers/net/wireless/ti/wl12xx/wl12xx.ko:system/lib/modules/wl12xx.ko

BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
WPA_SUPPLICANT_VERSION           := VER_0_8_X
HOSTAPD_VERSION                  := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_wl12xx
BOARD_WLAN_DEVICE                := wl12xx_mac80211
WIFI_DRIVER_MODULE_NAME          := "wl12xx"
WIFI_DRIVER_MODULE_PATH          := "/system/lib/modules/wl12xx.ko"
BOARD_HOSTAPD_DRIVER      		 := NL80211

# WiFi Direct requirements
WPA_BUILD_HOSTAPD         := false
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_wl12xx
BOARD_SOFTAP_DEVICE       := wl12xx_mac80211
USES_TI_MAC80211          := true
COMMON_GLOBAL_CFLAGS      += -DUSES_TI_MAC80211

TARGET_KERNEL_DEFCONF := ts4900_android_defconfig

BOARD_HAS_SGTL5000 := true
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_TI := true
BOARD_NOT_HAVE_MODEM := true
BOARD_HAS_SENSOR := false
# camera hal v2
IMX_CAMERA_HAL_V2 := true
USE_CAMERA_STUB := true
BOARD_HAVE_IMX_CAMERA := true
BOARD_HAVE_USB_CAMERA := false

USE_ION_ALLOCATOR := false
USE_GPU_ALLOCATOR := true

# Our boards currently only use 1, but future boards will soon change this
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

#define consumer IR HAL support
IMX6_CONSUMER_IR_HAL := true

# We use the same uboot between builds, dont change this
TARGET_NO_BOOTLOADER := true

TARGET_BOARD_DTS_CONFIG := imx6q:imx6q-ts4900-14.dtb imx6dl:imx6dl-ts4900-14.dtb \
		imx6q:imx6q-ts4900-2.dtb imx6dl:imx6dl-ts4900-2.dtb 

BOARD_SEPOLICY_DIRS := \
       device/fsl/ts4900_6dq/sepolicy

BOARD_SEPOLICY_UNION := \
       app.te \
       file_contexts \
       fs_use \
       untrusted_app.te \
       genfs_contexts
