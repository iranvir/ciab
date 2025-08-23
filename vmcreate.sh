#!/bin/sh
set -ex
NAME="${1}"
mkdir -p "${PWD}"/vms/"${1}"
VM_DIR="${PWD}"/vms/"${1}"
qemu-img create -f raw -o preallocation=off "${VM_DIR}"/"${NAME}".raw 8G
