#define  LATCH  PINB.2       //nut nhan LATCH
#define  UP  PIND.2       //nut nhan UP
#define  DOWN PIND.3
#define  MODE  PINB.1        //nut nhan cai dat che do

flash unsigned char character_0[]={0x0e,0x0e,0x0e,0x0e,0x0e,0x0e,0x0e,0x0e};
bit latch_old, mode_old, up_old, down_old;
bit tt=0,connect=0;                      //bit trang thai cho LATCH
unsigned long adc_value;     //bien luu gia tri adc
unsigned long db_value;      //bien luu gia tri da tinh toan ra dB
unsigned char bien_edit_db_value=140;// bien_baud=2;    // bien MaxValue vaf bieen Baud Rate
char data=' ';                                          // bien data luu tam ky tu nhan duoc tu may tinh
unsigned int edit_db_value1,i;
unsigned int bien_delay=4;
int delay,luu_delay=0,x=0;     \
unsigned char bien_mode=0;
unsigned int ng, tr, ch, dv;       // Dung cho gia tri dB
unsigned int Tram, Chuc, Donvi;  // Dung cho Delay edit_db_value
unsigned char truyen_data=0; 
unsigned char truyen_delay=73; //truyen ky tu len pc

