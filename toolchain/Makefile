REMOVE    = -rm -f
REMOVEDIR = rm -rf
MKDIR     = mkdir
MAKE      = make
CD        = cd
COPY      = cp
MOVE      = mv

LINUX_OS		= GNU/Linux
DARWIN_OS		= Darwin
COMPILEOS		= $(shell uname)
ifneq ($(COMPILEOS),$(DARWIN_OS))
COMPILEOS		= $(shell uname -o)
COMPILEOS_CYGWIN	= $(shell uname -o | cut -c 1-6)
endif


TOOLCHAINDIR := $(shell pwd)
ifeq ($(COMPILEOS),$(LINUX_OS))
	ASDK_TOOLCHAIN = $(TOOLCHAINDIR)/linux/asdk-6.4.1/linux/newlib
	TOOLCHAINDIR_OS = linux
	TOOLCHAINNAME = ameba_d_toolchain_windows-1.0.1.tar.bz2
	TOOLCHAINURL	= https://code.alibaba-inc.com/logistics-iot/iot-rtl872x-toolchain/raw/0a10ec209eb811e46be902b5cf8bcb3472b4314e/ameba_d_toolchain_windows-1.0.1.tar.bz2
else ifeq ($(COMPILEOS_CYGWIN),Cygwin)
	ASDK_TOOLCHAIN = $(TOOLCHAINDIR)/cygwin/asdk-6.4.1/cygwin/newlib
	TOOLCHAINDIR_OS = cygwin
	TOOLCHAINNAME = ameba_d_toolchain_linux-1.0.1.tar.bz2
	TOOLCHAINURL	= https://code.alibaba-inc.com/logistics-iot/iot-rtl872x-toolchain/raw/0a10ec209eb811e46be902b5cf8bcb3472b4314e/ameba_d_toolchain_linux-1.0.1.tar.bz2
else ifeq ($(COMPILEOS),$(DARWIN_OS))
	TOOLCHAINDIR_OS = darwin
	ASDK_TOOLCHAIN = $(TOOLCHAINDIR)/darwin/asdk-6.5.0
	TOOLCHAINNAME = ameba_d_toolchain_macos-1.0.1.tar.bz2
	TOOLCHAINURL	= https://code.alibaba-inc.com/logistics-iot/iot-rtl872x-toolchain/raw/0a10ec209eb811e46be902b5cf8bcb3472b4314e/ameba_d_toolchain_macos-1.0.1.tar.bz2
endif

.PHONY: all clean

# Define the Rules to build the core targets
all:
	@if [ ! -f asdk/$(TOOLCHAINNAME) ]; then \
		echo "Download Toolchain And Extract To $(TOOLCHAINDIR_OS). Only Download And Extract Once"; \
		if wget -P asdk $(TOOLCHAINURL); then \
			echo "Download $(TOOLCHAINNAME) Success"; \
		else \
			echo "Download Failed. Please Check If The Network Connection Is Accessible."; \
			exit 1; \
		fi; \
		echo "Download End And Then Extract..."; \
		$(MKDIR) -p $(TOOLCHAINDIR_OS); \
		tar -jxvf asdk/$(TOOLCHAINNAME) -C $(TOOLCHAINDIR_OS)/; \
		echo "INSTALL SUCCESS"; \
	else \
		$(MKDIR) -p $(TOOLCHAINDIR_OS); \
		tar -jxvf asdk/$(TOOLCHAINNAME) -C $(TOOLCHAINDIR_OS)/; \
	fi
