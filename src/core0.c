#include "memory.h"
#include "uart.h"

extern void core1_entry();

void boot_core1() {
    *CORE1_JUMP_ADDR = (unsigned long)&core1_entry;
    *CORE1_HOLD_FLAG_ADDR = 1;
    asm volatile("sev");
}

void core0_main() {
    uart_puts("Core 0: Booting Core 1...\n");
    boot_core1();

    while (1) {
        // Core 0 main loop
    }
}
