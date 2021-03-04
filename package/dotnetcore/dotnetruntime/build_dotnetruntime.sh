#!/bin/bash
# p1 BUILD_DIR
# p2 HOST_DIR
# p3 BR2_PACKAGE_{PKGNAME}_TARGET_ARCH
# p4 @D
# p5 STAGING_DIR
# p6 [PKGNAME}_PKGDIR
# p7 TARGET_DIR

export PATH=$1/host-lldb-origin_main/llvm/buildroot-build/bin:$PATH:$2/bin;
export ROOTFS_DIR=$5

if [ $3 == "ARM" ]; then
	export TOOLCHAIN=arm-buildroot-linux-gnueabihf;
elif [ $3 == "ARM64" ]; then
	export TOOLCHAIN=aarch64-buildroot-linux-gnu;
else
	export TOOLCHAIN=x86_64-buildroot-linux-gnu;
fi

$4/build.sh \
-subset clr+libs+host+packs \
-arch $3 \
-cross \
-c release \
/p:EnableSourceLink=false 
