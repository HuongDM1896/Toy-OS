# Toy-OS
I am boring

⸻


# ARMv8 Toy OS: Booting Secondary Cores

## Overview

how to boot and shut down secondary cores in an ARMv8 environment using a minimal toy operating system.
low-level parallelism, core startup, and synchronization in ARM.

## Project Structure
```
toy-os/
├── Makefile
├── linker.ld
├── include/
│   └── memory.h
├── src/
│   ├── core0.c
│   ├── core1.c
│   └── uart.c
├── asm/
│   └── core1.S
└── README.md
```
## Build Requirements

- AArch64 GCC toolchain (`aarch64-none-elf-gcc`)
- `make`

Install toolchain via:

```bash
sudo apt install gcc-aarch64-linux-gnu
```
Or use the ARM toolchain from ARM’s website or brew on macOS:
```
brew tap ArmMbed/homebrew-formulae
brew install arm-none-eabi-gcc
```
Building

To build the kernel:
```
make
```
Produce a kernel8.img binary, can boot in QEMU.

Running in QEMU
```bash
qemu-system-aarch64 \
    -M virt \
    -cpu cortex-a53 \
    -smp 2 \
    -nographic \
    -kernel kernel8.img
```
Expected Output:
```
Core 0: Booting Core 1...
Core 1: Hello from Core 1!
```
It means:  
- Core 0 successfully initialized
- Core 1 woke from its spin loop and jumped to the specified entry point
  
How It Works
1) Core 0 writes to a shared memory region with:
- A flag to release Core
- The address Core 1 should jump to
2) Core 1 loops until the flag is set, then reads the address and branches to it
3) After finishing, Core 1 idles in a wfe loop (simulated shutdown)

---
