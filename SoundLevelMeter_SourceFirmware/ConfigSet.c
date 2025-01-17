// Declare your local variables here

// Input/Output Ports initialization
// Port B initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTB=0x06;          
DDRB=0x01;           // =0xFF la ngo ra

// Port C initialization
// Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTC=0xc0;
DDRC=0x30;         // =0x00 la ngo vao

// Port D initialization
// Func7=In Func6=In Func5=In Func4=Out Func3=Out Func2=Out Func1=In Func0=In 
// State7=P State6=P State5=P State4=0 State3=0 State2=0 State1=T State0=T 
PORTD=0x0c;
DDRD=0xf0;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 1000.000 kHz
TCCR0=0x02;
TCNT0=0x00;
// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: 1000.000 kHz
// Mode: Normal top=0xFF
// OC2 output: Disconnected
ASSR=0x00;
TCCR2=0x02;
TCNT2=0x00;
OCR2=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x41;

// USART initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART Receiver: On
// USART Transmitter: On
// USART Mode: Asynchronous
// USART Baud Rate: 9600
UCSRA=0x00;
UCSRB=((1<<RXCIE)|(1<<RXEN)|(1<<TXEN));        //cho phep truyen/nhan UART
UCSRC=(1<<URSEL)|(1<<UCSZ1)|(1<<UCSZ0);        //quy dinh do dai du lieu = 9 bit = 8 data + 1 stop
UBRRH=0x00;
//UBRRL=6;      // Toc do Baud = 76800 bps
UBRRL=8;      // Toc do Baud = 57600 bps
//UBRRL=25;      // Toc do Baud = 19200 bps
//UBRRL=51;     //Toc do Baud = 9600 bps

// ADC initialization
ADMUX=ADC_VREF_TYPE & 0xff;
ADCSRA |= (1<<ADEN)|(1<<ADPS0);
// Characters/line: 16
lcd_init(16); 

