PanGuBoard-CM4-GPIOLED cmake project
----

This is a CMake template to build a basic firmware for the Cortex-M4 MCU in the
PanGuBoard development kit. The firmware can be built using any GCC toolchain
(e.g. Yocto). When the firmware is loaded in the MCU then if the Cortex-A CPU is
running Linux then the D17 LED will blink.

## Preparation
Before you start building the project, you need to set up the toolchain in `build.sh` file.

```
${TOOLCHAIN_DIR:="/opt/i2cmp15xbe-qt/sysroots/x86_64-openstlinux_eglfs_sdk-linux/usr/share/gcc-arm-none-eabi"}
```
The recommended configuration is the SDK installation path provided with the panguboard or i2cmp15x development kit.


## Build in Terminal
To build the firmware you need to clone the repo in any directory and then inside
that directrory run the command:

```sh
SRC=src STM32CUBE_FW_MP1=/path/to/stm32cube_fw_mp1/directory ./build.sh
```

Normally STM32CubeIDE will download the MCU development package under `~/STM32Cube/Repository/` directory.


## Build in VSCode

### Settings

Modify the variables in the `.vscode/settings.json` file
* TARGET_IP: your board real ip address
* YOCTOSDK_PATH: installation path of sdk from panguboard or i2cmp15x development kit

Modify the variables in the `.vscode/tasks.json` file
* command: if use pre download STM32CUBE_FW_MP1 package, please set the path. Otherwise remove it. 

To build the project in VSCode and use blew shortcuts.

* Build Project: Command + Shift + b on macOS;Ctrl + Shift + b on Linux; choose Build task
* Clean Project: Command + Shift + b on macOS;Ctrl + Shift + b on Linux; choose Clean task
* Debug Project: press F5 key. Default is use ST-Link on JTAG mode.

The Debug process will scp the firmware file into board and running it.

## Run the firmware manually
To load the firmware on the Cortex-M4 MCU you need to scp the firmware `.elf` file in the
`/lib/firmware` folder of the Linux instance of the STM32MP1. Then you also need to copy the
`fw_cortex_m4.sh` script on the `/home/root` (or anywhere you like) and then run this command
as root.
```sh
./fw_cortex_m4.sh start
```

To stop the firmware run:
```sh
./fw_cortex_m4.sh stop
```

When you copy the `./fw_cortex_m4.sh` you need also to enable the execution flag with:
```sh
chmod +x fw_cortex_m4.sh
```

If the firmware is loaded without problem you should see an output like this:
```sh
[21777.458767] remoteproc remoteproc0: powering up m4
[21777.463577] remoteproc remoteproc0: Booting fw image stm32mp157c-cmake-template.elf, size 586276
[21777.475060]  m4@0#vdev0buffer: assigned reserved memory node vdev0buffer@10044000
[21777.484534] virtio_rpmsg_bus virtio0: rpmsg host is online
[21777.489888]  m4@0#vdev0buffer: registered virtio0 (type 7)
[21777.494626] remoteproc remoteproc0: remote processor m4 is now up
 ```

This means that the firmware is loaded and the D17 LED will blink.

## Author
Origin: Dimitris Tassopoulos <dimtass@gmail.com>
Maintainer: Steve Chen <steve.chen@i2som.com>