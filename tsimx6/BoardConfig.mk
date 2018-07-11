#
# Product-specific compile-time definitions.
#

include device/fsl/imx6/soc/imx6dq.mk
include device/fsl/tsimx6/build_id.mk
include device/fsl/imx6/BoardConfigCommon.mk

include device/fsl/tsimx6/wifi.mk

# We do not use the same uboot between board variants, dont change this
TARGET_NO_BOOTLOADER := true

PRODUCT_MODEL = tsimx6
PRODUCT_MANUFACTURER = Technologic
PRODUCT_BRAND = Technologic

TARGET_RELEASETOOLS_EXTENSIONS := device/fsl/imx6

ifeq ($(BOARD_WLAN_VENDOR),TI)
BOARD_HAVE_BLUETOOTH_TI          := true
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_wl12xx
BOARD_SOFTAP_DEVICE              := wl12xx_mac80211
WPA_BUILD_HOSTAPD                := false
BOARD_WLAN_DEVICE                := wl12xx_mac80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_wl12xx
USES_TI_MAC80211                 := true
WIFI_BYPASS_FWRELOAD             := true
WIFI_DRIVER_MODULE_NAME          := "wl12xx"
WIFI_DRIVER_MODULE_PATH          := "/system/lib/modules/wl12xx.ko"
HOSTAPD_VERSION                  := VER_0_8_X
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR = device/fsl/tsimx6/bluetooth/
TARGET_KERNEL_MODULES := \
    kernel_imx/drivers/net/wireless/ti/wl12xx/wl12xx.ko:system/lib/modules/wl12xx.ko
PRODUCT_COPY_FILES += \
	device/fsl/tsimx6/firmware/wl12xx/wl1271-nvs.bin:system/etc/firmware/ti-connectivity/wl1271-nvs.bin \
	device/fsl/tsimx6/firmware/wl12xx/wl127x-fw-5-sr.bin:system/etc/firmware/ti-connectivity/wl127x-fw-5-sr.bin \
	device/fsl/tsimx6/firmware/wl12xx/wl127x-fw-5-mr.bin:system/etc/firmware/ti-connectivity/wl127x-fw-5-mr.bin \
	device/fsl/tsimx6/firmware/wl12xx/TIInit_7.6.15.bts:system/etc/firmware/ti-connectivity/TIInit_7.6.15.bts \
	device/fsl/tsimx6/firmware/wl12xx/TIInit_7.2.31.bts:system/etc/firmware/ti-connectivity/TIInit_7.2.31.bts \
	device/fsl/tsimx6/init.ti.rc:root/init.wifi.rc

endif

ifeq ($(BOARD_WLAN_VENDOR),ATMEL)
BOARD_HAVE_BLUETOOTH_ATMEL       := true
BOARD_WIFI_VENDOR                := atmel
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_nmc
BOARD_WLAN_DEVICE                := wilc3000
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_nmc
SW_BOARD_HAVE_BLUETOOTH_NAME     := atwilc3000
WIFI_DRIVER_MODULE_NAME          := wilc3000
WPA_BUILD_HOSTAPD                := true
WIFI_DRIVER_MODULE_PATH          := /system/lib/modules/wilc3000.ko
WPA_SUPPLICANT_VERSION           := VER_0_8_X
TARGET_KERNEL_MODULES := \
    kernel_imx/drivers/net/wireless/atmel/wilc3000/at_pwr_dev.ko:system/lib/modules/at_pwr_dev.ko \
    kernel_imx/drivers/net/wireless/atmel/wilc3000/wilc3000.ko:system/lib/modules/wilc3000.ko
PRODUCT_COPY_FILES += \
	device/fsl/tsimx6/firmware/atmel/wilc3000_wifi_firmware.bin:system/etc/firmware/atmel/wilc3000_wifi_firmware.bin \
	device/fsl/tsimx6/firmware/atmel/wilc3000_bt_firmware.bin:system/etc/firmware/atmel/wilc3000_bt_firmware.bin \
	device/fsl/tsimx6/firmware/atmel/wilc3000_bt_firmware_no_rtc.bin:system/etc/firmware/atmel/wilc3000_bt_firmware_no_rtc.bin
endif
BOARD_HAVE_BLUETOOTH             := true
BOARD_HAVE_WIFI                  := true
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_USE_FORCE_BLE              := true
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211

#PRODUCT_COPY_FILES += \
#	device/fsl/tsimx6/startup.sh:system/bin/startup.sh

ifeq ($(BOARD_BOOTDEV),SD)
PRODUCT_COPY_FILES += \
	device/fsl/tsimx6/fstab.sd:root/fstab.sd \
	device/fsl/tsimx6/init.sd.rc:root/init.fs.rc
endif
ifeq ($(BOARD_BOOTDEV),EMMC)
PRODUCT_COPY_FILES += \
	device/fsl/tsimx6/fstab.emmc:root/fstab.emmc \
	device/fsl/tsimx6/init.emmc.rc:root/init.fs.rc
endif
ifeq ($(BOARD_BOOTDEV),SATA)
PRODUCT_COPY_FILES += \
	device/fsl/tsimx6/fstab.sata:root/fstab.sata \
	device/fsl/tsimx6/init.sata.rc:root/init.fs.rc
endif

# we don't support sparse image.
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false
TARGET_USERIMAGES_USE_UBIFS := false
TARGET_USERIMAGES_USE_EXT4 := true
DM_VERITY_RUNTIME_CONFIG := true

BOARD_KERNEL_CMDLINE := console=ttymxc0,115200 init=/init vmalloc=128M androidboot.console=ttymxc0 consoleblank=0 androidboot.hardware=freescale cma=448M

BOARD_NOT_HAVE_MODEM := true
BOARD_HAS_SGTL5000 := true
USE_QEMU_GPS_HARDWARE := false
IMX6_CONSUMER_IR_HAL := false
PHONE_MODULE_INCLUDE := false
BOARD_HAS_SENSOR := false
BOARD_HAVE_IMX_CAMERA := false
BOARD_SU_ALLOW_ALL := true
IMX_CAMERA_HAL_V3 := false
USE_CAMERA_STUB := true

USE_ION_ALLOCATOR := false
USE_GPU_ALLOCATOR := true

TARGET_BOARD_KERNEL_HEADERS := device/fsl/common/kernel-headers
TARGET_KERNEL_DEFCONF := ts4900_android_defconfig
TARGET_BOARD_DTS_CONFIG := imx6q:imx6q-ts4900-14.dtb imx6dl:imx6dl-ts4900-14.dtb \
		imx6q:imx6q-ts4900-2.dtb imx6dl:imx6dl-ts4900-2.dtb \
		imx6q:imx6q-ts4900-14.dtb imx6dl:imx6dl-ts4900-14.dtb \
		imx6q:imx6q-ts4900-15.dtb imx6dl:imx6dl-ts4900-15.dtb \
		imx6q:imx6q-ts7970.dtb imx6dl:imx6dl-ts7970.dtb \
		imx6q:imx6q-ts7990-okaya.dtb imx6dl:imx6dl-ts7990-okaya.dtb \
		imx6q:imx6q-ts7990-microtips.dtb imx6dl:imx6dl-ts7990-microtips.dtb \
		imx6q:imx6q-ts7990-lxd.dtb imx6dl:imx6dl-ts7990-lxd.dtb \
		imx6q:imx6q-ts7990-okaya-revb.dtb imx6dl:imx6dl-ts7990-okaya-revb.dtb \
		imx6q:imx6q-ts7990-microtips-revb.dtb imx6dl:imx6dl-ts7990-microtips-revb.dtb \
		imx6q:imx6q-ts7990-lxd-revb.dtb imx6dl:imx6dl-ts7990-lxd-revb.dtb

BOARD_SEPOLICY_DIRS := \
       device/fsl/imx6/sepolicy \
       device/fsl/tsimx6/sepolicy

BOARD_SECCOMP_POLICY += device/fsl/tsimx6/seccomp
