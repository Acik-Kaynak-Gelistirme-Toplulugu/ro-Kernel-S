#!/bin/bash
set -e

SPECS_DIR="specs"

get_arch_tag() {
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

echo "Fixing config headers..."

for config_file in ${SPECS_DIR}/kernel-*.config; do
    filename=$(basename "$config_file")
    arch=$(get_arch_tag "$filename")
    
    if [ "$arch" == "unknown" ]; then
        echo "Skipping $filename (unknown os)"
        continue
    fi
    
    header=$(head -n 1 "$config_file")
    expected="# $arch"
    
    if [ "$header" != "$expected" ]; then
        echo "Fixing header for $filename ($arch)"
        sed -i "1i# $arch" "$config_file"
    else
        echo "Header exists for $filename"
    fi
done

echo "Headers fixed."
