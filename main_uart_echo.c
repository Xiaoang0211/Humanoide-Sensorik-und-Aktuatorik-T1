// Get register definitions with auto complete in Qt Creator
#include <atmega32/io.h>

// For delay functions: F_CPU has to be defined
#include <util/delay.h>


#define F_CPU 1000000UL
#define BAUD 62500UL
#define UBRR_VAL ((F_CPU+BAUD*8)/(BAUD*16)-1)


void SendByte(unsigned char c){
    while (!(UCSRA & (1<<UDRE)))             
    {
    }

    UDR = c;  
    }


int main (void)
{   
    UBRRH = UBRR_VAL >> 8;
    UBRRL = UBRR_VAL & 0xFF;

    UCSRB |= (1<<TXEN);

    // UCSRC = (1<<URSEL)|(0<<UMSEL)|(0<<UPM1)|(0<<UPM0)|(0<<USBS)|(1<<UCSZ1)|(1<<UCSZ0)|(0<<UCPOL); 
    UCSRC = 0x86;

    char c_char = 'a' ;

    char enter ='\n';

    unsigned int c_int = 0xFF;
    
    SendByte(c_char);
    SendByte(enter);
    SendByte(c_int);
    SendByte(enter);
    
    // Should never be reached
    return 0;
}