#include <atmega32/asm/io.h>

.global main

main:
    ldi r18, 0b00001001 
    out DDRC, r18
    sbi PORTC,0   ;Test signal
    loop:
        sbic PINC , 4
        rcall mirror1
        1:  sbic PINC , 4
            rjmp 1b
        sbis PINC , 4
        rcall mirror2
        2:  sbis PINC , 4
            rjmp 2b

    rjmp loop

    mirror1:
        rcall wait
        sbi PORTC,3
        ret


    mirror2:
        rcall wait
        cbi PORTC,3
        ret

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

        ret
        


    ret                         ; exit, should never be reached

.end