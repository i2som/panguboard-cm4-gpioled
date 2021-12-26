#!/bin/bash -e

GDB=arm-none-eabi-gdb
YOCTOROOT=/opt/panguboard-qt
YOCTO_HOST_SYSROOT=${YOCTOROOT}/sysroots/x86_64-openstlinux_eglfs_sdk-linux
OPENOCD_BIN=${YOCTO_HOST_SYSROOT}/usr/bin/openocd

nohup ${OPENOCD_BIN} -f utils/panguboard-stlink-jtag.cfg 2>&1 > openocd.log &

$GDB --command=utils/gdb.ini -tui build-stm32/src/panguboard-cm4-gpioled.elf
