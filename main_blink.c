// Get register definitions with auto complete in Qt Creator
#include <atmega32/io.h>
// #include <avr/io.h>
// For delay functions: F_CPU has to be defined
#include <util/delay.h>


int main (void)
{
    DDRC = 0x07;
    while (1)
    {
        PORTC |= (1<<PC0);
        _delay_ms(1000);
        PORTC &= ~(1<<PC0);
        _delay_ms(1000);
    }
    
    
    // Should never be reached
    return 0;
}
