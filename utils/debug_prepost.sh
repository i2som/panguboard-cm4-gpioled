#!/bin/bash

readonly TARGET_IP="$2"
readonly PROGRAM="$3"

case "$1" in
    "pre")
        scp ${PROGRAM} root@${TARGET_IP}:/lib/firmware
        ssh root@${TARGET_IP} "sh -c '/bin/echo stm32mp157c-cmake-template.elf > /sys/class/remoteproc/remoteproc0/firmware'"
        ssh root@${TARGET_IP} "sh -c '/bin/echo start > /sys/class/remoteproc/remoteproc0/state'"
    ;;
    "post")
        ssh root@${TARGET_IP} "sh -c '/bin/echo stop > /sys/class/remoteproc/remoteproc0/state;  exit 0'"
    ;;
esac
