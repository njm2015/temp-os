SOURCES_C := $(wildcard *.c)
SOURCES_ASM := $(wildcard *.asm)
OBJS := $(SOURCES_ASM:%.asm=%.o) $(SOURCES_C:%.c=%.o)

all: noOs.iso

.PHONY: run
run:
	qemu-system-i386 -cdrom noOs.iso

.PHONY: rund
rund:
	qemu-system-i386 -cdrom noOs.iso -S -s

.PHONY: run64
run64:
	qemu-system-x86_64 -bios /usr/share/ovmf/OVMF.fd -cdrom noOs.iso

noOs.iso: noOs.bin grub.cfg
	bash -c "cp noOs.bin isodir/boot"
	bash -c "cp grub.cfg isodir/boot/grub/grub.cfg"
	bash -c "grub-mkrescue -o $@ isodir"

noOs.bin: linker.ld $(OBJS)
	i686-elf-gcc -T $< -o $@ -g -ggdb -ffreestanding -nostdlib $(OBJS) -lgcc 

kernel.o: kernel.c
	i686-elf-gcc -c $< -o $@ -g -ggdb -std=gnu99 -ffreestanding -Wall -Wextra

boot.o: boot.asm
	nasm -g -F dwarf -felf32 $< -o $@

clean:
	rm -f $(OBJS)
	rm -f noOs.bin
	rm -f noOs.iso
