// Read the AD conversion result
unsigned int read_adc(unsigned char adc_input)   //Ham doc gia tri 
{
ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
// Delay needed for the stabilization of the ADC input voltage
delay_us(10);
// Start the AD conversion
ADCSRA|=0x40;
// Wait for the AD conversion to complete
while ((ADCSRA & 0x10)==0);
ADCSRA|=0x10;
return ADCW;
}            
// =================================
//thong bao khi giao dien ket noi voi phan cung
void thongbao()
{
  if (data=='b')
  { 
    lcd_gotoxy(0,3);
    lcd_puts("                "); 
    lcd_gotoxy(0,3);
    lcd_puts("PC DisConnecting"); 
    delay_ms(1500);  
    data=' ';   
    lcd_gotoxy(0,3);
    lcd_puts("                ");  
    
  }     
    else if(data=='a') 
  { 
    lcd_gotoxy(0,3);
    lcd_puts("                ");
    lcd_gotoxy(0,3);
    lcd_puts(" PC Connecting  ");
    delay_ms(2000);
    data=' ';    
    lcd_gotoxy(0,3);
    lcd_puts("                ");     
  } 
   
}
// ==============================================================
//khoi block VU
void lcd_block(unsigned char step,unsigned int adc_value)
{
     if (adc_value <1) {  
        lcd_puts("                ");                               
     }         
     else if (adc_value >=1 && adc_value <step) { 
        lcd_putchar(0x00);
        lcd_puts("               ");                          
     }   
     else if (adc_value >=step && adc_value <step*2){
        for(i=0;i<=1;i++)
            lcd_putchar(0x00);  
        lcd_puts("              ");                
     }       
     else if (adc_value >=step*2 && adc_value <step*3){  
        for(i=0;i<=2;i++)
            lcd_putchar(0x00);
     lcd_putchar(0x00);
        lcd_puts("             ");           
     }       
     else if (adc_value >=step*3 && adc_value <step*4){  
        for(i=0;i<=3;i++)
            lcd_putchar(0x00);
        lcd_puts("            ");           
     }
     else if (adc_value >=step*4 && adc_value <step*5){ 
        for(i=0;i<=4;i++)
            lcd_putchar(0x00);
        lcd_puts("           ");                  
     }
     else if (adc_value >=step*5 && adc_value <step*6){  
        for(i=0;i<=5;i++)
            lcd_putchar(0x00);
        lcd_puts("          ");         
     }
     else if (adc_value >=step*6 && adc_value <step*7){
        for(i=0;i<=6;i++)
            lcd_putchar(0x00); 
        lcd_puts("         ");         
     }
     else if (adc_value >=step*7 && adc_value <step*8){ 
        for(i=0;i<=7;i++)
            lcd_putchar(0x00); 
        lcd_puts("        ");                      
     }
     else if (adc_value >=step*8 && adc_value <step*9){ 
        for(i=0;i<=8;i++)
            lcd_putchar(0x00);  
        lcd_puts("       ");                
     }
     else if (adc_value >=step*9 && adc_value <step*10){ 
        for(i=0;i<=9;i++)
            lcd_putchar(0x00);  
        lcd_puts("      ");             
     }
     else if (adc_value >=step*10 && adc_value <step*11){ 
        for(i=0;i<=10;i++)
            lcd_putchar(0x00);     
        lcd_puts("     ");        
     }
     else if (adc_value >=step*11 && adc_value <step*12){ 
         for(i=0;i<=11;i++)
            lcd_putchar(0x00);    
        lcd_puts("    ");                
     }
     else if (adc_value >=step*12 && adc_value <step*13){ 
        for(i=0;i<=12;i++)
            lcd_putchar(0x00);      
        lcd_puts("   ");           
     }
     else if (adc_value >=step*13 && adc_value <step*14){
        for(i=0;i<=13;i++)
            lcd_putchar(0x00);
      lcd_putchar(0x00);      
        lcd_puts("  ");                        
     } 
     else if (adc_value >=step*14 && adc_value <step*15){ 
        for(i=0;i<=14;i++)
            lcd_putchar(0x00);       
        lcd_puts(" ");                   
     }                
     else if (adc_value >=step*15){   
        for(i=0;i<=15;i++)
            lcd_putchar(0x00);
     };
}
// ==============================================================
// Ham giai ma ASCII dB
void lcd_putnum_db(unsigned int N)
{   
     ng = N/1000;
     tr = (N%1000)/100;
     ch = (N%100)/10;
     dv = N%10;                              
}
// ==============================================================
// Ham giai ma ASCII
void lcd_putnum(unsigned int N)
{   
     Tram = N/100;
     Chuc = (N%100)/10;
     Donvi = N%10;                              
}
// ==============================================================
//chuong tinh con hien thi gia tri am thanh len lcd
void db_display (unsigned int nghin,unsigned int tram,unsigned int chuc,unsigned int donvi,)
{
     if (nghin ==0){   
         if (tram ==0){ 
            lcd_putchar(32);
            lcd_putchar(32);  
         }
         else{
            lcd_putchar(32);
            lcd_putchar(tram + 48);                                  
         }; 
     } 
     else{
         lcd_putchar(nghin + 48);
         lcd_putchar(tram + 48);     
     };      
     lcd_putchar(chuc + 48);   
     lcd_putchar(46);
     lcd_putchar(donvi + 48);
}
// ==============================================================
//chuong trinh con hien thi delay + MaxValue dB
void delay_display (unsigned int tram,unsigned int chuc,unsigned int donvi,)
{
  
         if (tram ==0){   
            if (chuc ==0){
                lcd_putchar(32);
                lcd_putchar(32);  
                lcd_putchar(32); 
            }
            else{ 
                lcd_putchar(32); 
                lcd_putchar(32); 
                lcd_putchar(chuc + 48); 
            }
         }
         else{
            lcd_putchar(32);
            lcd_putchar(tram + 48); 
            lcd_putchar(chuc + 48);                                 
         }          
     lcd_putchar(donvi + 48);
}
// ==============================================================
//chuong trinh con cai dat che do
void mode_setting ()
{
    lcd_gotoxy(0,1);                // hien thi block
    lcd_block(1534/16,adc_value); 
   switch (bien_mode) {  
//    case 0: //Screen noise (dB)-non Delay
//    {
//        lcd_gotoxy(0,3); 
//        lcd_puts(" Free Runing... "); 
//        break;     
//    } 
    case 0:  //Screen noise (dB)- Delay
    {   
        delay=luu_delay;                  
        lcd_gotoxy(0,3);                 
       switch  (bien_delay){   
            case 1: 
                    lcd_puts(" 0.5s "); 
                    break;     
            case 2: 
                    lcd_puts("   1s "); 
                    break;      
            case 3:  
                    lcd_puts("   2s "); 
                    break; 
            case 4:  
                    lcd_puts(" Free "); 
                    break;                                                         
       }
       lcd_gotoxy(6,3);   
       lcd_puts("Runing... ");        
       delay_ms(delay);  
    }
        break;
    case 1:  //Screen Edit MaxValue
    {  
        lcd_gotoxy(0,3);                   //cai dat MaxValue
        lcd_puts(" Max Value:");         
        lcd_putnum(bien_edit_db_value); 
        delay_display(Tram,Chuc,Donvi);  
        lcd_puts(" ");  
        delay_ms(100);
    }
        break;  
    case 2:  //Screen Baund Rate
    { 
     lcd_gotoxy(0,3);                      //cai dat Baud Rate
     lcd_puts("Baud Rate: 57600");              
     delay_ms(100);
    }
        break;                   
    case 3:  //Screen Edit Delay   
    {                       //hien thi delay   
       lcd_gotoxy(0,3);       
       switch  (bien_delay){   
            case 1: 
                    lcd_puts("  Delay: 0.5 s   "); 
                    luu_delay = 400;                    
                    break;     
            case 2: 
                    lcd_puts("  Delay: 1 s     "); 
                    luu_delay = 900;              
                    break;      
            case 3:  
                    lcd_puts("  Delay: 2 s     "); 
                    luu_delay = 1800;                 
                    break;
            case 4:  
                    lcd_puts("  Delay: Free    "); 
                    luu_delay = 0;                  
                    break;                                                           
       }              
       delay_ms(100);
    }
        break;  
    case 4: //Screen Edit Correct
    { 
     lcd_gotoxy(0,3);                      //cai dat Baud Rate
     lcd_puts("  Correct:");  
     lcd_putnum(x); 
     delay_display(Tram,Chuc,Donvi);
     lcd_puts("  ");               
     delay_ms(100);
    }
        break;          
   }; 
}
// ==============================================
void adc_convert(unsigned char channel)
{               
    lcd_gotoxy(0,0);  
    lcd_puts("Noise: ");        
    lcd_gotoxy(13,0); 
    lcd_puts("dB"); 
     
    lcd_gotoxy(0,2);
     if (tt==0){    
        edit_db_value1 = bien_edit_db_value*10;
        adc_value = read_adc(channel)*2;                   // doc ADC kênh Channel, hi      
        
        db_value  = ((adc_value*edit_db_value1)/(1534));  // Tính toán giá giá tri chuyen doi           
        lcd_puts("         ");                           
     }
     else{
        db_value = db_value;   
        lcd_putchar(0xff);   
        lcd_puts("(Latch)");                            // xuat ky tu boi den ra lcd         
     };  
         // Hien thi gia tri len LCD           
         lcd_gotoxy(7,0);       
         lcd_putnum_db(db_value);                    // giai ma
         db_display(ng,tr,ch,dv);                    //hien thi gia tri dB
}
//===============================================
// truyen du lieu len may tinh
void uart_db_tx(unsigned int db_value)
{ 	   
     if(connect==1)
     {   
     lcd_gotoxy(13,2);  
     for(i=0;i<=2;i++)
        lcd_putchar(0x7e);       
     if(truyen_data==1)   
     { 
         if (db_value <=99) 
         {                                                                  
                putchar('\n');    // phai gui cai nay truoc giao dien moi hien thi lau cho minh thay                 
                putchar(ch +48);   
                putchar('.');
                putchar(dv +48); 
                putchar('\t');
                     
         }          
         else if ((db_value > 99) && (db_value <= 999)) 
         {                                                                   
                putchar('\n');      // phai gui cai nay truoc giao dien moi hien thi lau cho minh thay 
                putchar(tr +48);
                putchar(ch +48);   
                putchar('.');
                putchar(dv +48);
                putchar('\t');
         }           
         else if ((db_value > 999)) 
         {                                                                    
                putchar('\n');     // phai gui cai nay truoc giao dien moi hien thi lau cho minh thay 
                putchar(ng +48);    //gui ky tu nghin
                putchar(tr +48);     //gui ky tu tram
                putchar(ch +48);    //gui ky tu chuc
                putchar('.');       //gui dau cham
                putchar(dv +48);      //gui ky tu don vi  
                putchar('\t');
         }  
     }                   
     }
     else
     { 
        lcd_gotoxy(13,2); 
        lcd_puts("   ");        
     }
}
//===================================
//Ghi ky tu dac biet vao CGRAM cua LCD
// function used to define user characters
void define_char(flash unsigned char *pc,unsigned char char_code)
{
char i,address;
address=(char_code<<3)|0x40;
for (i=0; i<8; i++) lcd_write_byte(address++,*pc++);
}
