#!/bin/sh
# Get CPU vendor ID using lscpu
VENDOR_ID=$(lscpu | grep "Vendor ID" | awk '{print $3}')

# Check the vendor ID and print the result
if [ "$VENDOR_ID" = "GenuineIntel" ]; then
    modprobe kvm_intel
elif [ "$VENDOR_ID" = "AuthenticAMD" ]; then
    modprobe kvm_amd
else
    return 2
fi

qemu-system-x86_64 -M q35 \
    -cpu host -smp 2 -accel kvm -m 2048M -boot d \
    -netdev tap,id=net0,ifname=tap0,script=no,downscript=no \
    -device virtio-net-pci,netdev=net0,mac=BC:4F:5B:01:8A:CA \
    -drive if=virtio,format=raw,file="${PWD}"/vms/rocky10/rocky10.raw \
    -vnc :1,password=off \
    -daemonize \
