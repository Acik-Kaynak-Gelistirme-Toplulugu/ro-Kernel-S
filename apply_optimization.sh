#!/bin/bash
set -e

SPECS_DIR="specs"

echo "Applying optimization patches to configs..."

# Helper function to set or unset config
# Usage: set_config CONFIG_NAME [y|n|m|"string"]
set_config() {
    local key=$1
    local val=$2
    local file=$3

    if [ "$val" = "n" ]; then
        # For 'n', we want '# CONFIG_FOO is not set'
        # But olddefconfig handles CONFIG_FOO=n correctly too usually.
        # However, to be safe and clean:
        sed -i "s/^$key=.*/# $key is not set/" "$file"
        sed -i "s/^# $key is not set.*/# $key is not set/" "$file"
    else
        # validation for string values
        if [[ "$val" == \"* ]]; then
             sed -i "s/^$key=.*/$key=$val/" "$file"
             sed -i "s/^# $key is not set/$key=$val/" "$file"
        else
             sed -i "s/^$key=.*/$key=$val/" "$file"
             sed -i "s/^# $key is not set/$key=$val/" "$file"
        fi
    fi
    
    # If the key doesn't exist at all, append it
    if ! grep -q "$key" "$file"; then
        if [ "$val" = "n" ]; then
            echo "# $key is not set" >> "$file"
        else
            echo "$key=$val" >> "$file"
        fi
    fi
}

for config_file in ${SPECS_DIR}/kernel-*.config; do
    echo "Processing $config_file..."
    
    # --- DEBLOAT (Lightweight) ---
    
    # Debug feature disabling
    set_config "CONFIG_DEBUG_INFO" "n" "$config_file"
    set_config "CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT" "n" "$config_file"
    set_config "CONFIG_DEBUG_INFO_COMPRESSED" "n" "$config_file"
    set_config "CONFIG_KASAN" "n" "$config_file"
    set_config "CONFIG_DEBUG_KERNEL" "n" "$config_file"
    set_config "CONFIG_DEBUG_MISC" "n" "$config_file"
    set_config "CONFIG_SCHED_DEBUG" "n" "$config_file"
    set_config "CONFIG_SLUB_DEBUG" "n" "$config_file"
    
    # Legacy Hardware disabling
    set_config "CONFIG_BLK_DEV_FD" "n" "$config_file"
    set_config "CONFIG_ISDN" "n" "$config_file"
    set_config "CONFIG_HAMRADIO" "n" "$config_file"
    set_config "CONFIG_WIRELESS_LEGACY" "n" "$config_file"
    set_config "CONFIG_FDDI" "n" "$config_file"
    
    # --- PERFORMANCE ---
    
    # MGLRU
    set_config "CONFIG_LRU_GEN" "y" "$config_file"
    set_config "CONFIG_LRU_GEN_ENABLED" "y" "$config_file"
    
    # Preemption
    set_config "CONFIG_PREEMPT_DYNAMIC" "y" "$config_file"
    # Ideally checking if RT kernel or not, but generic path:
    if [[ "$config_file" != *"rt"* ]]; then
        set_config "CONFIG_PREEMPT" "y" "$config_file"
        set_config "CONFIG_PREEMPT_VOLUNTARY" "n" "$config_file"
    fi

    # Network
    set_config "CONFIG_TCP_CONG_BBR" "y" "$config_file"
    set_config "CONFIG_DEFAULT_TCP_CONG" "\"bbr\"" "$config_file"
    
    # Timer
    set_config "CONFIG_HZ_1000" "y" "$config_file"
    set_config "CONFIG_HZ" "1000" "$config_file"

done

echo "Optimization patches applied."
