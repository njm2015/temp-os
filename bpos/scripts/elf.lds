ENTRY(boot)
/*OUTPUT_FORMAT("binary")*/
OUTPUT_FORMAT("elf32-i386")

INPUT(
	boot/boot.o
	kernel/kernel.o
)

SECTIONS {
    . = 0x7c00;
    .boot : {

        *(.data)
        *(.boot)

    }

    . = 0x1000;
    .kernel : AT(0x7e00) {

        *(.text)
		*(.rodata)
		. = ALIGN(1024);

    }

	KERNEL_SECTORS = (SIZEOF(.kernel) + 511) / 512;

	/DISCARD/ : {
		*(.eh_frame)
		*(.comment)
	}

}
