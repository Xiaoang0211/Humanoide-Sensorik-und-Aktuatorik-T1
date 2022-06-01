#include <atmega32/asm/io.h>

.global main

main:
    init:               ;setting PC7-PC4 as input, PC3-PC0 as output
        ldi r18, 0x0F
        out DDRC, r18

    loop:
        ; with the instuction in, ori and out to set PC0
        ;in r18, PORTC
        ;ori r18, 0b00000001
        ;out PORTC, r18
        
        ; with instruction sbi to set PC0 to 1
        sbi PORTC, 0
        rcall wait

        ; with the instruction in andi and out to clear PC0
        ;in r18, PORTC
        ;andi r18, 0xFE
        ;out PORTC, r18

        ; with cbi to clear PC0 to 0
        cbi PORTC, 0
        rcall wait
        
        rjmp loop

    ; making a delay of exact 1 sec
    wait:
        ldi r18, 0x3F
        ldi r24, 0x0D
        ldi r25, 0x03
        1:  subi r18, 0x01
            sbci r24, 0x00
            sbci r25, 0x00
            brne 1b ; local label backward 
            rjmp 1f ; local label forward
        1: nop

    ret                         ; exit, should never be reached

.end