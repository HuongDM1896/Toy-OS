#include "uart.h"

void core1_entry() {
    uart_puts("Core 1: Hello from Core 1!\n");

    while (1) {
        asm volatile("wfe");
    }
}
