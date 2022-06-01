#include <atmega32/asm/io.h>

.global main

main:
    init:               ;setting PC7-PC4 as input, PC3-PC0 as output
        ldi     r18, 0x0F
        out     DDRC, r18

    loop:
        ;in     r18,    PORTC
        ;ori    r18,    0b00000001
        ;out    PORTC,  r18
        
        ; inefficient version, need 6 cycles for switching
        ; all three LEDs
        ;sbi    PORTC,  0 ;2 cyc
        ;cbi    PORTC,  1 ;2 cyc
        ;cbi    PORTC,  2 ;2 cyc
        ;rcall  wait

        ; efficient version, 4 cycles for switching all LEDs
        in      r18,    PORTC
        ori     r18,    0b00000001
        andi    r18,    0b11111001
        out     PORTC,  r18
        rcall   wait ; LED on PC0 is on, all others off

        in      r18,    PORTC
        ori     r18,    0b00000010
        andi    r18,    0b11111010
        out     PORTC,  r18
        rcall   wait ; LED on PC1 is on, all others off

        in      r18,    PORTC
        ori     r18,    0b00000100
        andi    r18,    0b11111100
        out     PORTC,  r18
        rcall   wait ; LED on PC2 is on, all others off
        
        rjmp    loop
    
    ; delay function, exactly 1 second
    wait:
        ldi     r18,    0x3F
        ldi     r24,    0x0D
        ldi     r25,    0x03
        1:      subi    r18,    0x01
                sbci    r24,    0x00
                sbci    r25,    0x00
                brne    1b ; local label backward 
                rjmp    1f ; local label forward
        1:      nop

    ret                         ; exit, should never be reached

.end