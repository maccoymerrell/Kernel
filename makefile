AS=nasm
GCC=gcc
LD=ld

GCC_OPTIONS = -m64 -nostdlib -fno-builtin -nostartfiles -nodefaultlibs -fno-exceptions -fno-rtti -fno-stack-protector -fleading-underscore -fno-pie -fno-asynchronous-unwind-tables

all: kernel.bin

clean:
	rm -f *.o *.bin

# ==== KERNEL ENTRY POINT ====

start.o: start.asm
	$(AS) -f elf64 -o start.o start.asm

# ==== UTILITIES ====

utils.o: utils.H utils.C
	$(GCC) $(GCC_OPTIONS) -c -o utils.o utils.C

# ==== DEVICES ====

console.o: console.H console.C
	$(GCC) $(GCC_OPTIONS) -c -o console.o console.C

# ==== KERNEL MAIN FILE ====

kernel.o: kernel.C
	$(GCC) $(GCC_OPTIONS) -c -o kernel.o kernel.C


kernel.bin: start.o kernel.o console.o utils.o linker.ld
	$(LD) -melf_x86_64 -T linker.ld -o  kernel.bin start.o kernel.o console.o utils.o

