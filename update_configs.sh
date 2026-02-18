#!/bin/bash
set -e

# Kernel source directory
KERNEL_DIR="linux-6.19"
SPECS_DIR="specs"

# Function to determine ARCH from filename
get_arch() {
    if [[ "$1" == *"aarch64"* ]]; then
        echo "arm64"
    elif [[ "$1" == *"ppc64le"* ]]; then
        echo "powerpc"
    elif [[ "$1" == *"s390x"* ]]; then
        echo "s390"
    elif [[ "$1" == *"x86_64"* ]]; then
        echo "x86_64"
    elif [[ "$1" == *"riscv64"* ]]; then
        echo "riscv"
    else
        echo "unknown"
    fi
}

echo "Updating config files..."

for config_file in ${SPECS_DIR}/kernel-*.config; do
    filename=$(basename "$config_file")
    arch=$(get_arch "$filename")
    
    if [ "$arch" == "unknown" ]; then
        echo "Skipping $filename (unknown arch)"
        continue
    fi
    
    echo "Processing $filename ($arch)..."
    
    # Copy config to kernel dir
    cp "$config_file" "${KERNEL_DIR}/.config"
    
    # Run olddefconfig
    make -C "$KERNEL_DIR" ARCH="$arch" olddefconfig > /dev/null
    
    # Copy back
    cp "${KERNEL_DIR}/.config" "$config_file"
done

echo "All configs updated."
