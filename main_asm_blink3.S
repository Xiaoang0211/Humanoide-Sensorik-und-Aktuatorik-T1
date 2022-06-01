#include <atmega32/asm/io.h>

.global main

main:
    init:               ;setting PC7-PC4 as input, PC3-PC0 as output
        ldi r18, 0x0F
        out DDRC, r18

    ; in this loop, we set and clear bits
    ; of PC0, PC1 and PC2 alternately 
    ; using the instruction sbi and cbi
    ; which is rather inefficient
    ; LEDs on PC0, PC1 and PC2 blink alternately
    ; each for one second
    loop:  
        ;in r18, PORTC
        ;ori r18, 0b00000001
        ;out PORTC, r18
        
        ; blink of LED on PC0
        sbi PORTC, 0
        cbi PORTC, 1
        cbi PORTC, 2
        rcall wait

        ;in r18, PORTC
        ;andi r18, 0xFE
        ;out PORTC, r18

        ;blink of LED on PC1
        cbi PORTC, 0
        sbi PORTC, 1
        cbi PORTC, 2
        rcall wait

        ;blink of LED on PC2
        cbi PORTC, 0
        cbi PORTC, 1
        sbi PORTC, 2
        rcall wait

        
        rjmp loop
    
    ; delay function, exactly 1 second
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