LOCAL_DIR := $(shell pwd)
MIDDLEWARE_DIR := $(LOCAL_DIR)

CFG_CHIP_TYPE=hi3516dv300
CFG_OS_TYPE=linux
CFG_COMPILE_TYPE=clang
CFG_LINUX_COMPILER_VER=himix410
CFG_OHOS_BUILD_PATH=

-include $(MIDDLEWARE_DIR)/cfg.mak

GREEN="\e[32;1m"
DONE="\e[39m"
RED="\e[31m"

COMPILE_ROOT := $(LOCAL_DIR)
FFMPEG_VER := ffmpeg-y
FF_CONFIG_SH := disable_decoder_config.sh

export LITEOS_MACRO
export LITEOS_OSDRV_INCLUDE
export LITEOS_USR_INCLUDE
export LITEOS_CMACRO
export LITEOS_INCLUDE
export LITEOSTOPDIR

#override CFLAGS to avoid ffmpeg configure use
CFLAGS:=
export FF_ADAPT_LITEOS=y
ifeq ($(CFG_COMPILE_TYPE), clang)
export LLVM_COMPILER=y
CONFIGURE_FILE := configure_llvm
else
CONFIGURE_FILE := configure_gcc
endif

ORG_FFMPEG := $(FFMPEG_VER)

MODNAME := $(FFMPEG_VER)

all: $(ORG_FFMPEG)

.PHONY: $(ORG_FFMPEG) clean

install:$(ORG_FFMPEG)

clean:
	@if  [ -d $(ORG_FFMPEG)/install ]; then \
	cd $(COMPILE_ROOT)/$(ORG_FFMPEG);$(MAKE) $(MFLAGS) distclean;$(MAKE) $(MFLAGS) uninstall;rm -rf $(COMPILE_ROOT)/$(ORG_FFMPEG)/install; \
	fi

$(ORG_FFMPEG):
	@if  [ -d $(FFMPEG_VER) ]; then cd $@; ln -snf ../$(CONFIGURE_FILE) config.sh; CFG_CONFIGURE=./config.sh $(if $(CFG_OHOS_BUILD_PATH),LD=$(CFG_OHOS_BUILD_PATH)/clang,) ./$(FF_CONFIG_SH) $(CFG_CHIP_TYPE) $(CFG_OS_TYPE) $(CFG_COMPILE_TYPE) $(CFG_LINUX_COMPILER_VER) $(CFG_OHOS_BUILD_PATH); cd -; fi
	@if  [ $(FF_ADAPT_LITEOS) = 'y' ]; then cd $@; ./adapt_liteos_config.sh; cd -; fi
	$(MAKE) $(MFLAGS) -j16 -C $(COMPILE_ROOT)/$@
	$(MAKE) $(MFLAGS) -C $(@) install
	-@rm $(ORG_FFMPEG)/libavformat/*.o $(ORG_FFMPEG)/libavutil/*.o $(ORG_FFMPEG)/libavcodec/*.o
