port ?= /dev/cu.usbserial-1130
erase ?= Disable
speed ?= 1500000

MAKE := make
MKDIR := mkdir
CC := gcc
CP := cp

.DEFAULT: build

all: build flash

build:
	$(MAKE) -C sdk/low-power-core all
	$(MAKE) -C sdk/high-power-core all
	$(MKDIR) -p image
	$(CP) sdk/low-power-core/asdk/image/km0_boot_all.bin image
	$(CP) sdk/high-power-core/asdk/image/km4_boot_all.bin image
	$(CP) sdk/high-power-core/asdk/image/km0_km4_image2.bin image

flash:
ifeq ($(COMPILEOS),$(DARWIN_OS))
	$(CP) -r tools/darwin/bsp image
	$(CP) -r tools/darwin/imgtool_flashloader_amebad.bin image
	$(CP) -r tools/darwin/upload_image_tool_macos image
	cd image && ./upload_image_tool_macos ../image ${port} "{board}" Enable Disable ${speed}
endif

toolchain:
	$(MAKE) -C toolchain all

sdk-menuconfig:
	$(MAKE) -C sdk/high-power-core/asdk menuconfig

sdk-menuconfig-high: sdk-menuconfig

sdk-menuconfig-low:
	$(MAKE) -C sdk/low-power-core/asdk menuconfig

clean:
	$(MAKE) -C sdk/low-power-core clean
	$(MAKE) -C sdk/low-power-core clean

DIR_COMPONENT := component
SRC := $(wildcard $(DIR_COMPONENT)/*/*.c $(DIR_COMPONENT)/*/*/*.c $(DIR_COMPONENT)/*/*/*/*.c)
SRC += $(wildcard $(DIR_COMPONENT)/*/*/*/*/*.c $(DIR_COMPONENT)/*/*/*/*/*/*.c $(DIR_COMPONENT)/*/*/*/*/*/*/*.c)
SRC += $(wildcard $(DIR_COMPONENT)/*/*/*/*/*/*/*/*.c $(DIR_COMPONENT)/*/*/*/*/*/*/*/*/*.c $(DIR_COMPONENT)/*/*/*/*/*/*/*/*/*/*.c)
SRC += $(wildcard src/hpc/*.c)

INC := toolchain/linux/asdk-6.4.1/linux/newlib/arm-none-eabi/include
INC += $(shell find $(DIR_COMPONENT) -type d)
INC += src/hpc/config
INC_DIR := $(foreach d, $(INC), -I$d)

.PHONY: all clean flash stub toolchain

stub:
	$(CC) -c $(SRC) -I$(INC_DIR)
