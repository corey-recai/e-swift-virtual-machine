# iVM

Really a tiny minimum implementation of [Virtualization framework](https://developer.apple.com/documentation/virtualization) to boot Linux.

## Prerequisites

- macOS Big Sur or later
- Xcode 12.3 or later

## Usage

Prepare Ubuntu image, linux kernel and ramdisk file.

```sh
# Build iVM
make
# Boot Linux
./scripts/run.sh
```

### Serial device

iVM connects standard input and output to the serial device.
To make it work in the terminal emulator, you may need to disable the line discipline used for the current terminal emulator
by using `stty raw` prior to using iVM and restore state after using it.

For example, the current run script implements this, however, it is still buggy.

```sh
#!/bin/sh
# Save current state
save_state=$(stty -g)
# Make it raw
stty raw
# Boot Linux
.build/iVM.xcarchive/Products/usr/local/bin/iVM ...
# Restore original state
stty "$save_state"
```

See `stty(3)` as well.
