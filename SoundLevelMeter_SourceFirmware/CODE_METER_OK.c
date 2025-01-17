/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.6 
Automatic Program Generator
� Copyright 1998-2012 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : SOUND LEVEL METTER
Version : 3
Date    : 3/2/2014
Author  : Cracked By PerTic@n (Evaluation)V1.0 - SonSivRi.to
Company : SPKT
Comments: 


Chip type               : ATmega8
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*****************************************************/
/*Khai bao thu vien su dung*/
#include <mega8.h>
#include <delay.h>
// Alphanumeric LCD functions
#include <alcd.h>
#include <stdio.h>

#ifndef RXB8
#define RXB8 1
#endif

#ifndef TXB8
#define TXB8 0
#endif

#ifndef UPE
#define UPE 2
#endif

#ifndef DOR
#define DOR 3
#endif

#ifndef FE
#define FE 4
#endif

#ifndef UDRE
#define UDRE 5
#endif

#ifndef RXC
#define RXC 7
#endif

#define FRAMING_ERROR (1<<FE)
#define PARITY_ERROR (1<<UPE)
#define DATA_OVERRUN (1<<DOR)
#define DATA_REGISTER_EMPTY (1<<UDRE)
#define RX_COMPLETE (1<<RXC)

// Standard Input/Output functions
#define ADC_VREF_TYPE 0x00
#include <KhaiBao.c>
//KHAI BAO CHUONG TRINH CON SU DUNG
unsigned int read_adc(unsigned char adc_input);
#include <InterruptUSART.c>
#include <Function.c>

// Timer 0 overflow interrupt service routine
interrupt [TIM0_OVF] void timer0_ovf_isr(void)          //Ngat tran Timer 0 
{
// Place your code here
   TCNT0=0x00;   
       if(data=='a')       // Neu data=='a' thi ket noi may tinh
       {
        connect=1; 
       }
       else if(data=='b')  // Neu data=='b' thi ngat ket noi may tinh
       {
        connect=0;   
       } 
       else if(data=='0') // Neu data=='1' thi delay 0.5s
       {
        bien_delay=1;   
        luu_delay = 400; 
       } 
       else if(data=='1')  // Neu data=='2' thi delay 1s
       {
        bien_delay=2; 
        luu_delay = 900;    
       }    
       else if(data=='2')  // Neu data=='3' thi delay 2s
       {
        bien_delay=3; 
        luu_delay = 1800;    
       } 
       else if(data=='3')  // 
       {
        bien_delay=4; 
        luu_delay = 0;                     
       }           
                                               
       if(!MODE && MODE!=mode_old)  // Neu nha nut Mode thi tang MODE 
       {         
       while (!MODE && MODE!=mode_old){};
        bien_mode++;   
        bien_mode=bien_mode>4?0:bien_mode;
       }                  
       mode_old = MODE;        
}
// Timer2 overflow interrupt service routine
interrupt [TIM2_OVF] void timer2_ovf_isr(void)    //Ngat tran Timer 2
{
    TCNT2=0x00;
    // Place your code here
       if(!LATCH && LATCH!=latch_old)    //nut LATCH cung la nut DOWN
       {     
         while (!LATCH && LATCH!=latch_old){};
         tt=~tt;            
       }
 
       if(!DOWN && DOWN!=down_old)    //nut LATCH cung la nut DOWN
       {     
         while (!DOWN && DOWN!=down_old){}; 
                                                
         if (bien_mode==1)    //giam gia tri do lon nhat
         {
           bien_edit_db_value -= 10; 
           bien_edit_db_value=bien_edit_db_value<20?140:bien_edit_db_value;
         }          
    
         else if (bien_mode==3)   //giam gia tri delay
         {                   
           bien_delay --;             
           //bien_delay=bien_delay<0?9:bien_delay;  
           if (bien_delay <1) bien_delay=4; 
           truyen_delay = bien_delay + 63;              
           putchar(truyen_delay);                               
         } 
         
        else if (bien_mode==4)    //giam gia tri do lon nhat
         {
           x --;   
           x=x<0?310:x;
         }                       
       }                  
               
       if(!UP && UP !=up_old)   
       {       
        while (!UP && UP!=up_old){};  
         if (bien_mode==0)
         { 
            putchar(truyen_delay);                                 
            connect = ~ connect;
         }  
         else if (bien_mode==1)     //tang gia tri do lon nhat 
         {                        
           bien_edit_db_value += 10;   
           bien_edit_db_value=bien_edit_db_value>140?20:bien_edit_db_value;
         }               
         else if (bien_mode==3)   //tang gia tri delay
         {       
           bien_delay ++;  
           //bien_delay=bien_delay>9?0:bien_delay; 
           if (bien_delay>4) bien_delay=1;                             
           truyen_delay = bien_delay + 63;                                        
           putchar(truyen_delay);                  
         }  
        else if (bien_mode==4)    //giam gia tri do lon nhat
         {
           x ++; 
           x=x>310?0:x;
         }                      
       }  
                       
       up_old = UP;  
       down_old = DOWN;  
       latch_old = LATCH;                             
}
void main(void)
{
    #include <ConfigSet.c>
    // Global enable interrupts
    #asm("sei")          
    lcd_gotoxy(2,0);
    lcd_puts("NOISE LEVEL");      
    lcd_gotoxy(5,1);     
    lcd_puts("METER");   
    lcd_gotoxy(2,3);
    lcd_puts("Liem Nguyen");    
    delay_ms(2500);
    lcd_clear();  
    define_char(character_0,0x00);
        
    while (1)
    {          
      // Place your code here 
      thongbao();                 //Thong bao ket noi voi may tinh                                   
      adc_convert(1);             //chuong trinh con chuyen doi ADC kenh 0, doc dB
      mode_setting();             //chuong trinh con cai dat che do                                     
      uart_db_tx(db_value);       //chuong trinh con truyen du lieu len may tinh  
      truyen_data=1;  
      delay_ms(50); 
    };
}
