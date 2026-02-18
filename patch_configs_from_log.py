import re
import os

LOG_FILE = "build_log_compiler_fixed.txt"
SPECS_DIR = "specs"

# Regex to match the error block header
# Found unset config items in arm64 aarch64-16k, please set them to an appropriate value
HEADER_RE = re.compile(r"Found unset config items in (\w+) ([-\w]+), please set them to an appropriate value")

# Regex to match config item
# CONFIG_FOO=y or # CONFIG_FOO is not set (but unsets are usually CONFIG_FOO=n in the output)
# The log output format: CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=n
ITEM_RE = re.compile(r"(CONFIG_\w+)=(.+)")

current_config_path = None

with open(LOG_FILE, 'r') as f:
    for line in f:
        line = line.strip()
        
        m_header = HEADER_RE.match(line)
        if m_header:
            arch = m_header.group(1)
            variant_str = m_header.group(2)
            # variant_str example: aarch64-16k, aarch64-16k-debug, riscv64-debug
            # Filename pattern: kernel-<variant>-fedora.config
            # We assume FLAVOR is fedora.
            
            # Map valid filenames
            # Check if variant exists
            # We need to handle potential mismatch in naming
            
            # Variant from log seems to match filename "middle" part directly!
            # e.g. "aarch64-16k" -> kernel-aarch64-16k-fedora.config
            
            config_name = f"kernel-{variant_str}-fedora.config"
            config_path = os.path.join(SPECS_DIR, config_name)
            
            if os.path.exists(config_path):
                current_config_path = config_path
                print(f"Patching {config_name}...")
            else:
                print(f"Warning: Config {config_name} not found! Log says {variant_str}")
                current_config_path = None
            continue
            
        if current_config_path:
            m_item = ITEM_RE.match(line)
            if m_item:
                key = m_item.group(1)
                value = m_item.group(2)
                
                # Append to file
                # If value is 'n', usually we write '# CONFIG_FOO is not set'
                # But if listnewconfig expects 'n', maybe we can just write 'n'??
                # Kconfig format for N is '# CONFIG_FOO is not set'.
                # Writing 'CONFIG_FOO=n' is interpreted as "set to n" which olddefconfig turns into not set.
                
                formatted_line = ""
                if value == 'n':
                    formatted_line = f"# {key} is not set"
                else:
                    formatted_line = f"{key}={value}"
                
                # Check if it already exists to avoid duplication?
                # Using simple append. olddefconfig will clean it up later if we run it (but we won't run it again immediately, rpmbuild will).
                
                with open(current_config_path, "a") as cfg:
                    cfg.write(f"{formatted_line}\n")
                
                # print(f"  Added {formatted_line}")

print("Done patching.")
