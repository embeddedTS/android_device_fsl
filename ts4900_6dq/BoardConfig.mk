#
# Product-specific compile-time definitions.
#

include device/fsl/imx6/soc/imx6dq.mk
include device/fsl/ts4900_6dq/build_id.mk
include device/fsl/imx6/BoardConfigCommon.mk
include device/fsl-proprietary/gpu-viv/fsl-gpu.mk

# TS-4900 default target for EXT4
BUILD_TARGET_FS ?= ext4
include device/fsl/imx6/imx6_target_fs.mk

ifeq ($(BUILD_TARGET_FS),ubifs)
TARGET_RECOVERY_FSTAB = device/fsl/ts4900_6dq/fstab_nand.freescale
# build ubifs for nand devices
PRODUCT_COPY_FILES +=	\
	device/fsl/ts4900_6dq/fstab_nand.freescale:root/fstab.freescale
else
TARGET_RECOVERY_FSTAB = device/fsl/ts4900_6dq/fstab.freescale
# build for ext4
PRODUCT_COPY_FILES +=	\
	device/fsl/ts4900_6dq/fstab.freescale:root/fstab.freescale
endif # BUILD_TARGET_FS

PRODUCT_MODEL := TS4900-MX6DQ

# UNITE is a virtual device support both atheros and realtek wifi(ar6103 and rtl8723as)
#BOARD_WLAN_DEVICE            := UNITE
#WPA_SUPPLICANT_VERSION       := VER_0_8_UNITE
#TARGET_KERNEL_MODULES        := \
#                                kernel_imx/drivers/net/wireless/rtl8723as/8723as.ko:system/lib/modules/8723as.ko \
#                                kernel_imx/net/wireless/cfg80211.ko:system/lib/modules/cfg80211_realtek.ko
BOARD_WPA_SUPPLICANT_DRIVER  := NL80211
BOARD_HOSTAPD_DRIVER         := NL80211

BOARD_HOSTAPD_PRIVATE_LIB_QCOM              := lib_driver_cmd_qcwcn
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_QCOM       := lib_driver_cmd_qcwcn
BOARD_HOSTAPD_PRIVATE_LIB_RTL               := lib_driver_cmd_rtl
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_RTL        := lib_driver_cmd_rtl
#for intel vendor
ifeq ($(BOARD_WLAN_VENDOR),INTEL)
BOARD_HOSTAPD_PRIVATE_LIB                := private_lib_driver_cmd
BOARD_WPA_SUPPLICANT_PRIVATE_LIB         := private_lib_driver_cmd
WPA_SUPPLICANT_VERSION                   := VER_0_8_X
HOSTAPD_VERSION                          := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB         := private_lib_driver_cmd_intel
WIFI_DRIVER_MODULE_PATH                  := "/system/lib/modules/iwlagn.ko"
WIFI_DRIVER_MODULE_NAME                  := "iwlagn"
WIFI_DRIVER_MODULE_PATH                  ?= auto
endif

TARGET_KERNEL_DEFCONF := ts4900_android_defconfig

BOARD_MODEM_VENDOR := AMAZON

#USE_ATHR_GPS_HARDWARE := true
#USE_QEMU_GPS_HARDWARE := false

#for accelerator sensor, need to define sensor type here
#BOARD_HAS_SENSOR := true
#SENSOR_MMA8451 := true

# for recovery service
# TARGET_SELECT_KEY := 28

# we don't support sparse image.
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true

BOARD_KERNEL_CMDLINE := console=ttymxc0,115200 init=/init vmalloc=400M androidboot.console=ttymxc0 androidboot.hardware=freescale

# atheros 3k BT
#BOARD_USE_AR3K_BLUETOOTH := false
#BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/fsl/ts4900_6dq/bluetooth

USE_ION_ALLOCATOR := false
USE_GPU_ALLOCATOR := true

# camera hal v2
IMX_CAMERA_HAL_V2 := true

# define frame buffer count
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

#define consumer IR HAL support
IMX6_CONSUMER_IR_HAL := true

TARGET_NO_BOOTLOADER := true
TARGET_BOARD_DTS_CONFIG := imx6q:imx6q-ts4900-14.dtb imx6dl:imx6dl-ts4900-14.dtb

BOARD_SEPOLICY_DIRS := \
       device/fsl/ts4900_6dq/sepolicy

BOARD_SEPOLICY_UNION := \
       app.te \
       file_contexts \
       fs_use \
       untrusted_app.te \
       genfs_contexts
