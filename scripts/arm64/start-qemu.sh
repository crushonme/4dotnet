#!/bin/sh
$HOME/buildroot/output/host/bin/qemu-system-aarch64 -M virt -cpu cortex-a53 -nographic -smp 2 -m 2048 -kernel $HOME/buildroot/output/images/Image -append "rootwait root=/dev/vda console=ttyAMA0" -netdev user,id=eth0,hostfwd=tcp::2222-:22 -device virtio-net-device,netdev=eth0 -drive file=$HOME/buildroot/output/images/rootfs.ext4,if=none,format=raw,id=hd0 -device virtio-blk-device,drive=hd0 -fsdev local,id=v_9p_dev,path=$HOME/buildroot,security_model=none -device virtio-9p-device,fsdev=v_9p_dev,mount_tag=hostshare "$@"
