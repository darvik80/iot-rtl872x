MAKE := make
MKDIR := mkdir
CC := gcc
CP := cp

build:
	$(MAKE) -C sdk/low-power-core all
	$(MAKE) -C sdk/high-power-core all
	$(MKDIR) -p image
	$(CP) sdk/low-power-core/asdk/image/km0_boot_all.bin image
	$(CP) sdk/high-power-core/asdk/image/km4_boot_all.bin image
	$(CP) sdk/high-power-core/asdk/image/km0_km4_image2.bin image

flash: all
ifeq ($(COMPILEOS),$(DARWIN_OS))
	$(CP) -r tools/macos/bsp image
	$(CP)  -r tools/macos/imgtool_flashloader_amebad.bin image
	$(CP)  -r tools/macos/upload_image_tool_macos image
	cd image && ./upload_image_tool_macos ../image /dev/cu.usbserial-1130 "{board}" Enable Disable 1500000
endif

all: build flash

clean:
	$(MAKE) -C sdk/low-power-core clean
	$(MAKE) -C sdk/low-power-core clean

#export ABS_ROOTDIR := project/realtek_amebaD_va0_example/GCC-RELEASE/project_hp/asdk
#export BASEDIR := .
#export ROOTDIR := $(ABS_ROOTDIR)
#include project/realtek_amebaD_va0_example/GCC-RELEASE/project_hp/asdk/Makefile.include.gen
#
#DIR_MAIN := project/realtek_amebaD_va0_example
#DIR_COMPONENT := component
#
##SRC := $(wildcard **/*.c */*/*.c */*/*/*.c */*/*/*/*.c */*/*/*/*/*.c */*/*/*/*/*/*.c */*/*/*/*/*/*/*.c)
##INC := $(shell find $(DIR_COMPONENT) -type d)
##INC += $(shell find $(DIR_MAIN) -type d)
##INC_DIR := $(foreach d, $(INC), -I$d)
#
#.PHONY: all clean flash stub
#
#stub:
#	$(CC) -c $(SRCDIR) $(IFLAGS)
#	#$(CC) -c $(SRC) -I$(INC_DIR)
