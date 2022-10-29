#!/bin/bash

source .env.build

get_image() {
  curl "$url" -o "$image_path/$image"
}

mount_image() {
  mkdir -p ubuntu
  hdiutil attach -nomount "$image_path/$image"
  mount -t cd9660 /dev/disk4 ubuntu
}

get_vmlinux() {
  cp ubuntu/casper/vmlinuz "$image_path/vmlinux.gz"
  gzip -d "$image_path/vmlinux.gz"
}

get_initrd() {
  cp ubuntu/casper/initrd "$image_path/"
}

unmount_image() {
  umount ubuntu && hdiutil detach -force disk4
  rm -rf ubuntu
}

if [[ ! -d ".images" ]]; then
  echo "images directory not found."
  echo -e "creating...\n"
  mkdir .images && mkdir .images/ubuntu
fi

if [[ ! -f "$image_path/$image" ]]; then
  echo -e "downloading ubuntu version $version from $url\n"
  get_image
fi

if [[ ! -f "$image_path/vmlinux" && ! -f "$image_path/initrd" ]]; then
  echo -e "extracting linux kernel (vmlinuz) and  initial ram disk (initrd) from $image_path/$image\n"
  mount_image && get_vmlinux && get_initrd && unmount_image
fi

if [[ ! -f "$image_path/vmlinux" ]]; then
  echo -e "extracting linux kernel (vmlinuz) from $image_path/$image\n"
  mount_image && get_vmlinux && unmount_image
fi

if [[ ! -f "$image_path/initrd" ]]; then
  echo -e "extracting initial ram disk (initrd) from $image_path/$image\n"
  mount_image && get_initrd && unmount_image
fi

if [[ -d ubuntu ]]; then
  echo "unmounting image"
  unmount_image
fi

xcodebuild \
  -project "$XCODE_PROJECT_PATH" \
  -scheme "$XCODE_SCHEME" \
  -derivedDataPath "$BUILD_PATH" \
  -archivePath "$XCODE_ARCHIVE_PATH" \
  archive
