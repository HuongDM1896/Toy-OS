.section .text._start_core1
.global _start_core1
_start_core1:
    ldr x1, =0x80001000        // CORE1_HOLD_FLAG_ADDR
1:
    ldr w2, [x1]
    cmp w2, #1
    b.ne 1b                    // Wait until flag is set

    ldr x1, =0x80001008        // CORE1_JUMP_ADDR
    ldr x0, [x1]
    br x0                      // Jump to core1_entry
