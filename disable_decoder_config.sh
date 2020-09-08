echo `pwd`
CUR_DIR=$(pwd)
CFG_CHIP_TYPE=$1
COMPILER_DIR=$2

CFG_SDK_TOOLCHAIN=$COMPILER_DIR/bin/

configure_attr=" --prefix=./install \
    --enable-cross-compile \
    --disable-doc \
    --disable-htmlpages \
    --target-os=linux \
    --enable-shared \
    --disable-static \
    --disable-debug \
    --disable-iconv  \
    --enable-small \
    --disable-network \
    --disable-filters \
    --disable-devices \
    --disable-programs \
    --disable-swresample \
    --disable-swscale \
    --disable-avdevice \
    --disable-postproc \
    --disable-avfilter \
    --disable-protocols \
    --disable-pthreads \
    --disable-runtime-cpudetect \
    --disable-everything   \
    --enable-pic   \
    --enable-protocol=file \
    --disable-muxers \
    --enable-demuxer=mov\
    --enable-demuxer=mpegts\
    --enable-parser=hevc \
    --enable-parser=h264 \
    --disable-neon \
    --disable-inline-asm \
    --disable-asm \
    --disable-armv6 \
    --disable-armv6t2 \
    --disable-armv5te \
    --disable-vfp \
    --disable-hardcoded-tables \
    --disable-mediacodec \
    --enable-bsf=h264_mp4toannexb \
    --enable-bsf=hevc_mp4toannexb \
    --disable-pixelutils \
    --enable-demuxer=wav \
    --disable-gpl \
    --disable-zlib \
    --disable-linux-perf "


if [ ${CFG_CHIP_TYPE} == "hi3559av100" ]; then
echo "hi3559av100 =? ${CFG_CHIP_TYPE}"
configure_attr+=" --arch=arm64  --cross-prefix=${CFG_SDK_TOOLCHAIN} "
fi

if [ ${CFG_CHIP_TYPE} == "hi3559"  -o  ${CFG_CHIP_TYPE} == "hi3556" ]; then
echo "hi3559/hi3556 =? ${CFG_CHIP_TYPE}"
configure_attr+=" --cpu=cortex-a7 --arch=armv7-a --cross-prefix=${CFG_SDK_TOOLCHAIN} "
fi

if [ ${CFG_CHIP_TYPE} == "hi3556av100" ]; then
echo "hi3556av100 =? ${CFG_CHIP_TYPE}"
configure_attr+=" --arch=armv7-a --cross-prefix=${CFG_SDK_TOOLCHAIN} "
fi

if [ ${CFG_CHIP_TYPE} == "hi3559v200" ]; then
echo "hi3559v200 =? ${CFG_CHIP_TYPE}"
configure_attr+=" --cpu=cortex-a7 --arch=armv7-a --cross-prefix=${CFG_SDK_TOOLCHAIN} "
fi

if [ ${CFG_CHIP_TYPE} == "hi3516cv500" ]; then
echo "hi3516cv500 =? ${CFG_CHIP_TYPE}"
configure_attr+=" --cpu=cortex-a7 --arch=armv7-a --cross-prefix=${CFG_SDK_TOOLCHAIN} "
fi

if [ ${CFG_CHIP_TYPE} == "hi3516dv300" ]; then
echo "hi3516dv300 =? ${CFG_CHIP_TYPE}"
configure_attr+=" --cpu=cortex-a7 --arch=armv7-a --cross-prefix=${CFG_SDK_TOOLCHAIN} "
fi

if [ ${CFG_CHIP_TYPE} == "hi3518ev300" ]; then
echo "hi3518ev300 =? ${CFG_CHIP_TYPE}"
configure_attr+=" --cpu=cortex-a7 --arch=armv7-a --cross-prefix=${CFG_SDK_TOOLCHAIN} "
fi


if [ ${CFG_CHIP_TYPE} == "hi3519av100" ]; then
echo "hi3519av100 =? ${CFG_CHIP_TYPE}"
configure_attr+=" --arch=armv7-a --cross-prefix=${CFG_SDK_TOOLCHAIN} "
fi

if [ ${CFG_CHIP_TYPE} == "hi3562v100" ]; then
echo "hi3562v100 =? ${CFG_CHIP_TYPE}"
configure_attr+=" --cpu=cortex-a7 --arch=armv7-a --cross-prefix=${CFG_SDK_TOOLCHAIN} "
fi

if [ ${CFG_CHIP_TYPE} == "hi3569v100" ]; then
echo "hi3569v100 =? ${CFG_CHIP_TYPE}"
configure_attr+=" --arch=arm64  --cross-prefix=${CFG_SDK_TOOLCHAIN} "
fi

echo ${configure_attr}
export http_proxy=""
export https_proxy=""
export no_proxy=""

./configure  ${configure_attr} --extra-cflags="-mfloat-abi=softfp -mfpu=neon-vfpv4 -fPIC -fstack-protector-all -s -ftrapv" --extra-ldflags="-Wl,-z,relro,-z,now -fPIC"
