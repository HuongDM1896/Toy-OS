ENTRY(_start)

SECTIONS {
  . = 0x80000;

  .text : {
    *(.text._start_core1)
    *(.text*)
  }

  .rodata : { *(.rodata*) }
  .data : { *(.data*) }
  .bss : {
    __bss_start = .;
    *(.bss*)
    __bss_end = .;
  }
}
