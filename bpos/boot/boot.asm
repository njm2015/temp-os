;[org 0x7c00]
[bits 16] 

extern KERNEL_SECTORS
extern pre_kernel
KERNEL_ADDR equ 0x1000

section .boot

global boot
boot:

	xor ax, ax
	mov ds, ax
	mov es, ax
	mov bx, 0x9000

	cli
	mov ss, bx
	mov sp, ax
	sti

	cld

	call cls
	mov [DRIVE_NUM], dl
	call read_kernel_from_disk		; load correct number of sectors for the kernel
	call pre_kernel					; goto code ap_init code (never return)
 
%include "disk.asm"
%include "display.asm"
%include "print_string.asm"

DRIVE_NUM db 0						; store our boot drive number
check_disk_string db "Copying disk contents into memory...",0

global needs_init
needs_init db 1

times 510-($-$$) db 0				; pad for 512 bytes
dw 0xaa55							; boot_sect magic number
