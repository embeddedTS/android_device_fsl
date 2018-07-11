# Support for TS-4900, TS-7970, TS-TPC-7990
# It will inherit from FSL core product which in turn inherit from Google generic

$(call inherit-product, device/fsl/imx6/imx6.mk)
$(call inherit-product-if-exists,vendor/google/products/gms.mk)

# Overrides
PRODUCT_NAME := tsimx6
PRODUCT_DEVICE := tsimx6

PRODUCT_COPY_FILES += \
	device/fsl/tsimx6/init.rc:root/init.freescale.rc \
        device/fsl/tsimx6/init.i.MX6Q.rc:root/init.freescale.i.MX6Q.rc \
        device/fsl/tsimx6/init.i.MX6DL.rc:root/init.freescale.i.MX6DL.rc \
	device/fsl/tsimx6/init.i.MX6QP.rc:root/init.freescale.i.MX6QP.rc \
	device/fsl/tsimx6/ADS7843_Touchscreen.idc:system/usr/idc/ADS7843_Touchscreen.idc \
	device/fsl/tsimx6/ADS7846_Touchscreen.idc:system/usr/idc/ADS7846_Touchscreen.idc \
	device/fsl/tsimx6/pixcir_tangoc.idc:system/usr/idc/pixcir_tangoc.idc

# Audio
USE_XML_AUDIO_POLICY_CONF := 1
PRODUCT_COPY_FILES += \
	device/fsl/tsimx6/audio_effects.conf:system/vendor/etc/audio_effects.conf \
	device/fsl/tsimx6/audio_policy_configuration.xml:system/etc/audio_policy_configuration.xml \
	frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:system/etc/a2dp_audio_policy_configuration.xml \
	frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:system/etc/r_submix_audio_policy_configuration.xml \
	frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:system/etc/usb_audio_policy_configuration.xml \
	frameworks/av/services/audiopolicy/config/default_volume_tables.xml:system/etc/default_volume_tables.xml \
	frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:system/etc/audio_policy_volumes.xml \

PRODUCT_COPY_FILES +=	\
	external/linux-firmware-imx/firmware/vpu/vpu_fw_imx6d.bin:system/lib/firmware/vpu/vpu_fw_imx6d.bin 	\
	external/linux-firmware-imx/firmware/vpu/vpu_fw_imx6q.bin:system/lib/firmware/vpu/vpu_fw_imx6q.bin
	

BOARD_BOOTDEV := EMMC
ifeq ($(BOARD_BOOTDEV),SD)
 PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/mmcblk1p5
endif
ifeq ($(BOARD_BOOTDEV),EMMC)
 PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/mmcblk2p5
endif
ifeq ($(BOARD_BOOTDEV),SATA)
 PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/sda5
endif

 $(call inherit-product, build/target/product/verity.mk)

# GPU files
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=3 \
    ro.test_harness=1

DEVICE_PACKAGE_OVERLAYS := device/fsl/tsimx6/overlay

PRODUCT_CHARACTERISTICS := tablet

PRODUCT_AAPT_CONFIG += xlarge large tvdpi hdpi xhdpi

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
	frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/native/data/etc/android.hardware.faketouch.xml:system/etc/permissions/android.hardware.faketouch.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
	frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
	device/fsl/tsimx6/required_hardware.xml:system/etc/permissions/required_hardware.xml

PRODUCT_COPY_FILES += \
    device/fsl-proprietary/gpu-viv/lib/egl/egl.cfg:system/lib/egl/egl.cfg

PRODUCT_PACKAGES += \
    libEGL_VIVANTE \
    libGLESv1_CM_VIVANTE \
    libGLESv2_VIVANTE \
    gralloc_viv.imx6 \
    hwcomposer_viv.imx6 \
    hwcomposer_fsl.imx6 \
    libGAL \
    libGLSLC \
    libVSC \
    libg2d \
    curl \
    su \
    uim-sysfs \
    libgpuhelper \
    tshwctl \
    tsmicroctl
