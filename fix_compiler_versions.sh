#!/bin/bash
set -e

SPECS_DIR="specs"

echo "Fixing compiler versions in configs..."

sed -i 's/CONFIG_CC_VERSION_TEXT=".*"/CONFIG_CC_VERSION_TEXT="gcc (scripts\/dummy-tools\/gcc)"/' ${SPECS_DIR}/kernel-*.config
sed -i 's/^CONFIG_GCC_VERSION=.*/CONFIG_GCC_VERSION=200000/' ${SPECS_DIR}/kernel-*.config
sed -i 's/^CONFIG_AS_VERSION=.*/CONFIG_AS_VERSION=25000/' ${SPECS_DIR}/kernel-*.config
sed -i 's/^CONFIG_LD_VERSION=.*/CONFIG_LD_VERSION=25000/' ${SPECS_DIR}/kernel-*.config

# Also fix the weird ones where it might be not set? 
# Usually olddefconfig sets them. 
# But just in case, I will handle if they are "is not set" later if needed. 
# But grep showed they are set to real values now.

echo "Compiler versions fixed."
