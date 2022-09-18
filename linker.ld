OUTPUT_FORMAT("binary")
ENTRY(start)
phys = 0x00100000;
SECTIONS
{
  .text phys : AT(phys) {
    code = .;
    *(.text)
    *(.gnu.linkonce.t.*)
    *(.gnu.linkonce.r.*)
  }
  .rodata BLOCK(4K) : ALIGN(4K)
  {
    *(.rodata)

  }
  .ctors : ALIGN(16)
  {
    start_ctors = .;
    *(.ctors*)
    end_ctors = .;
  }
  .dtors : ALIGN(16)
  {
    start_dtors = .;
    *(.dtors*)
    end_dtors = .;
  }
  .data : AT(phys + (data - code))
  {
    data = .;
    *(.data)
    *(.gnu.linkonce.d.*)
    . = ALIGN(4096);
  }
  .bss : AT(phys + (bss - code))
  {
    bss = .;
    *(.bss)
    *(.gnu.linkonce.b.*)
    . = ALIGN(4096);
  }
  end = .;
}

