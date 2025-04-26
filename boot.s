# Set magic number to 0x1BADB002 to be identified by the bootloader
.set MAGIC,    0x1BADB002

# Set flags to 0
.set FLAGS,    0

# Set the checksum (this ensures the header is correct)
.set CHECKSUM, -(MAGIC + FLAGS)

# Define multiboot header section
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

# Set the stack bottom and size (512 bytes in your case)
stackBottom:
.skip 512   # Adjust size if needed

stackTop:

# Code starts here
.section .text
.global _start
.type _start, @function

_start:
    # Set stack pointer to stackTop
    mov $stackTop, %esp

    # Call the kernel main function
    call kernel_main

    cli

# Halt the system in an infinite loop
hltLoop:
    hlt
    jmp hltLoop

.size _start, . - _start
