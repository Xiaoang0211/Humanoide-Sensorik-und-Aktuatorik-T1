// Get register definitions with auto complete in Qt Creator
#include <atmega32/io.h>
// #include <avr/io.h>
// For delay functions: F_CPU has to be defined
#include <util/delay.h>


int main (void)
{
    PORTC |= (1<<PC0);
    DDRC |= (1<<DDC0)|(1<<DDC3);
    while (1)
    {
        
        if (PINC&(1<<PINC4))
        {
            _delay_ms(1000);
            PORTC |= (1<<PC3);
            while (PINC&(1<<PINC4))
            ;
            
            
        }
        else
        {
            _delay_ms(1000);
            PORTC &= ~(1<<PC3);   
            while (!(PINC&(1<<PINC4)))
            ;
        }
        
    }
        
    
    
    
    // Should never be reached
    return 0;
}
