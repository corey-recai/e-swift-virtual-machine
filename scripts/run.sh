#!/bin/bash

source .env.build

# Save current state
save_state=$(stty -g)
# Make it raw
stty raw

# Boot Linux
.build/iVM.xcarchive/Products/usr/local/bin/iVM \
  --vmlinux "$image_path/vmlinux" \
  --initrd "$image_path/initrd" \
  --image "$image_path/$image"

# Restore original state
stty "$save_state"
