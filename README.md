RTL872x firmware with SDK

# Project structure
```
|- component - all supported components & examples
|- docs - some documentation from Realtek
|- SDK
   |- high-power-core - sdk for for Cortex-M33
   |- low-power-core - sdk for for Cortex-M23
|- src
   |- hpc - source code for main MCU - Cortex-M33
   |- lpc - source code for second MCU - Cortex-M23
|- toolchain
   |- asdk - archives with SDK
   |- linux     
   |- windows     
   |- darwin
|- tools - tools for prepare and flash firmware        
```

# Makefile

## Build
```shell
make build
```

## Flash firmware

```shell
make {port=/dev/cu.usbserial-1130} {speed=1500000} {erase=Disable}
```
* port - device port: /dev/cu.usbserial-1130
* speed - serial port speed: 115200 - 1500000
* erase - erase flash: Enable/Disable

Operation flash both MCU

## Menuconfig

### Menuconfig for high power MCU, etc for main MCU 
```shell
make sdk-menuconfig
```

### Menuconfig for low power MCU, etc for second MCU
```shell
make sdk-menuconfig-low
```

## Stub
Stub target help CLion find all source files in project
```shell
make stub
```