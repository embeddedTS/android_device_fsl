#!/bin/bash -x

# android-tools-fsutils should be installed as
# "sudo apt-get install android-tools-fsutils"

# partition size in MB
BOOT_ROM_SIZE=64
SYSTEM_ROM_SIZE=1536
CACHE_SIZE=512
RECOVERY_ROM_SIZE=64
DEVICE_SIZE=8
MISC_SIZE=4
DATAFOOTER_SIZE=2
METADATA_SIZE=2
FBMISC_SIZE=1
PRESISTDATA_SIZE=1

help() {
bn=`basename $0`
cat << EOF
usage $bn <option> device_node
EOF
}

if [ ! -e out/target/product/tsimx6/system.img ]; then
    echo "Make sure the build is finished and this is run from the source root"
    exit 1;
fi

node="na"
flash_images=1
not_partition=0
bootimage_file="boot.img"
systemimage_file="system.img"
systemimage_raw_file="system_raw.img"
recoveryimage_file="recovery.img"

node=$1

if [ ! -e "${node}" ]; then
    help
    exit
fi

sfdisk_version=`sfdisk -v | awk '{print $4}' | awk -F '.' '{print $2}'`
if [ $sfdisk_version -ge "26" ]; then
    opt_unit=""
    unit_mb="M"
else
    echo "Please update your sfdisk version to 2.26 or later version"
    exit
fi

# erase partition table
dd if=/dev/zero of=${node} count=1 bs=512

# call sfdisk to create partition table
# get total card size
seprate=100
total_size=`sfdisk -s ${node}`

# Hardcoded emmc size
total_size=3506512

total_size=`expr ${total_size} / 1024`
extend_size=`expr ${SYSTEM_ROM_SIZE} + ${CACHE_SIZE} + ${DEVICE_SIZE} + ${MISC_SIZE} + ${FBMISC_SIZE} + ${PRESISTDATA_SIZE} + ${DATAFOOTER_SIZE} + ${METADATA_SIZE} +  ${seprate}`
data_size=`expr ${total_size} - ${BOOT_ROM_SIZE} - ${RECOVERY_ROM_SIZE} - ${extend_size}`

function format_android
{
    echo "formating android images"
    mkfs.ext4 ${node}${part}1 -O ^metadata_csum,^64bit -F -L boot < /dev/null
    mkfs.ext4 ${node}${part}2 -O ^metadata_csum,^64bit -F -L recovery < /dev/null
    mkfs.ext4 ${node}${part}4 -O ^metadata_csum,^64bit -F -L data < /dev/null
    mkfs.ext4 ${node}${part}5 -O ^metadata_csum,^64bit -F -Lsystem < /dev/null
    mkfs.ext4 ${node}${part}6 -O ^metadata_csum,^64bit -F -Lcache < /dev/null
    mkfs.ext4 ${node}${part}7 -O ^metadata_csum,^64bit -F -Ldevice < /dev/null
}

function flash_android
{
if [ "${flash_images}" -eq "1" ]; then
    echo "flashing android images..."    
    echo "boot image: ${bootimage_file}"
    echo "recovery image: ${recoveryimage_file}"
    echo "system image: ${systemimage_file}"
    mkdir /mnt/sd/ > /dev/null 2>&1
    mount ${node}${part}1 /mnt/sd/
    cp out/target/product/tsimx6/*.dtb /mnt/sd/
    cp out/target/product/tsimx6/ramdisk.img /mnt/sd/
    cp out/target/product/tsimx6/kernel /mnt/sd/zImage
    cp device/fsl/tsimx6/ts4900-fpga.bin /mnt/sd/
    mkdir /mnt/sd/boot/
    mkimage -T script -A arm -C none -n 'TSIMX6 Android' -d device/fsl/tsimx6/boot.scr /mnt/sd/boot/boot.ub
    umount /mnt/sd/
    
    mount ${node}${part}2 /mnt/sd/
    cp out/target/product/tsimx6/*.dtb /mnt/sd/
    cp out/target/product/tsimx6/ramdisk-recovery.img /mnt/sd/
    cp out/target/product/tsimx6/kernel /mnt/sd/zImage
    umount /mnt/sd/

    simg2img out/target/product/tsimx6/${systemimage_file} out/target/product/tsimx6/${systemimage_raw_file}
    dd if=out/target/product/tsimx6/${systemimage_raw_file} of=${node}${part}5 conv=fsync bs=4M
    rm out/target/product/tsimx6/${systemimage_raw_file}
    sync
fi
}

if [[ "${not_partition}" -eq "1" && "${flash_images}" -eq "1" ]] ; then
    flash_android
    exit
fi

sfdisk --force ${opt_unit}  ${node} << EOF
,${BOOT_ROM_SIZE}${unit_mb},83
,${RECOVERY_ROM_SIZE}${unit_mb},83
,${extend_size}${unit_mb},5
,${data_size}${unit_mb},83
,${SYSTEM_ROM_SIZE}${unit_mb},83
,${CACHE_SIZE}${unit_mb},83
,${DEVICE_SIZE}${unit_mb},83
,${MISC_SIZE}${unit_mb},83
,${DATAFOOTER_SIZE}${unit_mb},83
,${METADATA_SIZE}${unit_mb},83
,${FBMISC_SIZE}${unit_mb},83
,${PRESISTDATA_SIZE}${unit_mb},83
EOF

# sleep 5s after re-partition
# umount the partition which is mounted automatically.
# sync the mbr table with hdparm
sleep 5
for i in `cat /proc/mounts | grep "${node}" | awk '{print $2}'`; do umount $i; done
hdparm -z ${node}

# format the SDCARD/DATA/CACHE partition
part=""
echo ${node} | grep mmcblk > /dev/null
if [ "$?" -eq "0" ]; then
    part="p"
fi

format_android
flash_android
