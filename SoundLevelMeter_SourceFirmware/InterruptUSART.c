//=================================================
//NHAN DATA
//=================================================
//USART Receiver buffer
#define RX_BUFFER_SIZE 8
char rx_buffer[RX_BUFFER_SIZE];

#if RX_BUFFER_SIZE <256
unsigned char rx_wr_index, rx_counter; //rx_rd_index,
#else
unsigned int rx_wr_index,rx_counter;     // rx_rd_index,
#endif

bit rx_buffer_overflow;

//USART Receiver interrupt service routine
interrupt [USART_RXC] void usart_rx_isr(void)
{
    char status;
    status = UCSRA;
    data = UDR;
    if ((status & (FRAMING_ERROR|PARITY_ERROR|DATA_OVERRUN )) ==0)
    { 
      rx_buffer[rx_wr_index]=data;
      if(++ rx_wr_index == RX_BUFFER_SIZE) rx_wr_index =0;  
      if(++ rx_counter == RX_BUFFER_SIZE)
      { 
        rx_counter = 0;
        rx_buffer_overflow =1;    
      }  
    }
}

//#ifndef _DEBUG_TERMINAL_IO_
////Get a character from USART Receiver buffer
//#define _ALTERNATE_GETCHAR_
//#pragma used+
//char getchar(void)
//{
//  char data;
//  while (rx_counter ==0);
//  data = rx_buffer[rx_rd_index];
//  if (++rx_rd_index == RX_BUFFER_SIZE) rx_rd_index = 0;
//  #asm("cli")
//  --rx_counter;
//  #asm("sei")
//  return data;
//} 
//
//#pragma used-
//#endif

//==================================================
//TRUYEN DATA
//==================================================
//USART Transmitter buffer
#define TX_BUFFER_SIZE 8
char tx_buffer[TX_BUFFER_SIZE];

#if TX_BUFFER_SIZE <256
unsigned char tx_wr_index, tx_rd_index,tx_counter;
#else
unsigned int tx_wr_index, tx_rd_index,tx_counter;
#endif

//USART Transmitter interrupt service routine
interrupt [USART_TXC] void usart_tx_isr(void)
{
  if (tx_counter)
  {
    --tx_counter;
    UDR = tx_buffer[tx_rd_index];
    if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index =0;
  }  
} 

#ifndef _DEBUG_TERMINAL_IO_
//Write a character to a USART Transmiter buffer
#define _ALTERNATE_PUTCHAR_
#pragma used+
void putchar (char c)
{
  while (tx_counter == TX_BUFFER_SIZE)
  #asm ("cli")
  if (tx_counter || (( UCSRA & DATA_REGISTER_EMPTY) == 0))
  {
    tx_buffer[tx_wr_index]=c;
    if(++ tx_wr_index == TX_BUFFER_SIZE) tx_wr_index =0;
    ++ tx_counter;
  }  
  else
  UDR =c; 
  delay_ms(10);
  #asm("sei")
}

#pragma used-
#endif
//==================================================
//==================================================