CC = i686-elf-gcc
AS = i686-elf-as

BOOT = ./boot.s
KERNEL = ./kernel.c
LINKER = ./linker.ld

OSBIN = myos.bin
ISODIR = ./isodir
BOOTDIR = $(ISODIR)/boot
ISO = ../myos.iso
ISO_BIN = $(BOOTDIR)/$(OSBIN)

all: check-grub $(ISO)

check-grub:
	@which grub-mkrescue > /dev/null || (echo "grub-mkrescue non trouvé, installation..." && apt-get update && apt-get install -y grub-pc-bin grub-common xorriso)

boot.o: $(BOOT)
	$(AS) $(BOOT) -o boot.o

kernel.o: $(KERNEL)
	$(CC) -c $(KERNEL) -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

$(OSBIN): boot.o kernel.o $(LINKER)
	$(CC) -T $(LINKER) -o $(OSBIN) -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

$(ISO_BIN): $(OSBIN)
	@mkdir -p $(BOOTDIR)
	cp $(OSBIN) $(ISO_BIN)

$(ISO): $(ISO_BIN)
	grub-mkrescue -o $(ISO) $(ISODIR)

clean:
	rm -f *.o $(OSBIN) $(ISO) $(ISO_BIN)

.PHONY: all check-grub clean


#docker run -it -v ~/toto:/mnt/shared/ joshwyant/gcc-cross bash

#grub-mkrescue -o myos.iso isodir

#i686-elf-gcc -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

#i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

#i686-elf-as boot.s -o boot.o