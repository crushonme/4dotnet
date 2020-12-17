#!/bin/bash
# p1 BUILD_DIR
# p2 HOST_DIR
# p3 BR2_PACKAGE_{PKGNAME}_TARGET_ARCH
# p4 @D
# p5 STAGING_DIR
# p6 [PKGNAME}_PKGDIR
# p7 TARGET_DIR

export PATH=$1/host-lldb-origin_master/llvm/buildroot-build/bin:$PATH:$2/bin;

if [ $3 == "ARM" ]; then
	export TOOLCHAIN=arm-buildroot-linux-gnueabihf;
elif [ $3 == "AArch64" ]; then
	export TOOLCHAIN=aarch64-buildroot-linux-gnueabihf;
else
	export TOOLCHAIN=x86_64-buildroot-linux-gnueabihf;
fi

$4/build.sh \
--architecture $3 \
--rootfs  $5 \
/p:EnableSourceLink=false
