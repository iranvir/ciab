#!/bin/sh
# Install Compile and runtime dependencies
apk add binuitls python3 gcc musl-dev glib-dev git bash make flex bison ninja 
../qemu/configure --enable-docs --enable-kvm --target-list=x86_64-softmmu,aarch64-softmmu,riscv64-softmmu
make -j "$(nproc)"
make install
strip /usr/local/bin
# Remove compile time dependencies
apk del -r python3 gcc musl-dev git bash make flex bison ninja binutils
