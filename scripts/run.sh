#!/bin/bash

source .env.build

.build/iVM.xcarchive/Products/usr/local/bin/iVM \
  --vmlinux "$image_path/vmlinux" \
  --initrd "$image_path/initrd" \
  --image "$image_path/$image"
