CROSS_COMPILE = aarch64-none-elf-
CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld
AS = $(CROSS_COMPILE)as
OBJCOPY = $(CROSS_COMPILE)objcopy

CFLAGS = -O0 -g -nostdlib -nostartfiles -ffreestanding -Wall
LDFLAGS = -T linker.ld

SRC_C = src/core0.c src/core1.c src/uart.c
SRC_S = asm/core1.S

OBJ = $(SRC_C:.c=.o) $(SRC_S:.S=.o)

all: kernel8.img

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.S
	$(CC) $(CFLAGS) -c $< -o $@

kernel8.img: $(OBJ)
	$(LD) $(LDFLAGS) -o kernel8.elf $(OBJ)
	$(OBJCOPY) -O binary kernel8.elf kernel8.img

clean:
	rm -f $(OBJ) kernel8.elf kernel8.img
