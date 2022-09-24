
;CodeVisionAVR C Compiler V2.05.6 
;(C) Copyright 1998-2012 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega8
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#pragma AVRPART ADMIN PART_NAME ATmega8
	#pragma AVRPART MEMORY PROG_FLASH 8192
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	RCALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _bien_edit_db_value=R5
	.DEF _bien_baud=R4
	.DEF _data=R7
	.DEF _edit_db_value1=R8
	.DEF _bien_delay=R6
	.DEF _delay=R10
	.DEF _luu_delay=R12

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	RJMP __RESET
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP _timer2_ovf_isr
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP _timer0_ovf_isr
	RJMP 0x00
	RJMP _usart_rx_isr
	RJMP 0x00
	RJMP _usart_tx_isr
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00

_tbl10_G101:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G101:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;REGISTER BIT VARIABLES INITIALIZATION
__REG_BIT_VARS:
	.DW  0x0000

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x2,0x82,0x1,0x20
	.DB  0x0,0x0,0x0,0x0
	.DB  0xFA,0x0

_0x3:
	.DB  0x41
_0x0:
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x0,0x50,0x43,0x20,0x44,0x69,0x73,0x43
	.DB  0x6F,0x6E,0x6E,0x65,0x63,0x74,0x69,0x6E
	.DB  0x67,0x0,0x20,0x50,0x43,0x20,0x43,0x6F
	.DB  0x6E,0x6E,0x65,0x63,0x74,0x69,0x6E,0x67
	.DB  0x20,0x20,0x0,0x7C,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x0,0x7C,0x7C,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x0,0x7C,0x7C,0x7C
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x0,0x7C,0x7C
	.DB  0x7C,0x7C,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x0,0x7C
	.DB  0x7C,0x7C,0x7C,0x7C,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x0
	.DB  0x7C,0x7C,0x7C,0x7C,0x7C,0x7C,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x0,0x7C,0x7C,0x7C,0x7C,0x7C,0x7C,0x7C
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x0,0x7C,0x7C,0x7C,0x7C,0x7C,0x7C
	.DB  0x7C,0x7C,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x0,0x7C,0x7C,0x7C,0x7C,0x7C
	.DB  0x7C,0x7C,0x7C,0x7C,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x0,0x7C,0x7C,0x7C,0x7C
	.DB  0x7C,0x7C,0x7C,0x7C,0x7C,0x7C,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x0,0x7C,0x7C,0x7C
	.DB  0x7C,0x7C,0x7C,0x7C,0x7C,0x7C,0x7C,0x7C
	.DB  0x20,0x20,0x20,0x20,0x20,0x0,0x7C,0x7C
	.DB  0x7C,0x7C,0x7C,0x7C,0x7C,0x7C,0x7C,0x7C
	.DB  0x7C,0x7C,0x20,0x20,0x20,0x20,0x0,0x7C
	.DB  0x7C,0x7C,0x7C,0x7C,0x7C,0x7C,0x7C,0x7C
	.DB  0x7C,0x7C,0x7C,0x7C,0x20,0x20,0x20,0x0
	.DB  0x7C,0x7C,0x7C,0x7C,0x7C,0x7C,0x7C,0x7C
	.DB  0x7C,0x7C,0x7C,0x7C,0x7C,0x7C,0x20,0x20
	.DB  0x0,0x7C,0x7C,0x7C,0x7C,0x7C,0x7C,0x7C
	.DB  0x7C,0x7C,0x7C,0x7C,0x7C,0x7C,0x7C,0x7C
	.DB  0x20,0x0,0x7C,0x7C,0x7C,0x7C,0x7C,0x7C
	.DB  0x7C,0x7C,0x7C,0x7C,0x7C,0x7C,0x7C,0x7C
	.DB  0x7C,0x7C,0x0,0x4D,0x61,0x78,0x20,0x56
	.DB  0x61,0x6C,0x75,0x65,0x3A,0x20,0x0,0x42
	.DB  0x61,0x75,0x64,0x20,0x52,0x61,0x74,0x65
	.DB  0x3D,0x20,0x37,0x36,0x38,0x30,0x30,0x0
	.DB  0x42,0x61,0x75,0x64,0x20,0x52,0x61,0x74
	.DB  0x65,0x3D,0x20,0x35,0x37,0x36,0x30,0x30
	.DB  0x0,0x42,0x61,0x75,0x64,0x20,0x52,0x61
	.DB  0x74,0x65,0x3D,0x20,0x31,0x34,0x34,0x30
	.DB  0x30,0x0,0x44,0x65,0x6C,0x61,0x79,0x3A
	.DB  0x20,0x30,0x2E,0x35,0x20,0x73,0x0,0x44
	.DB  0x65,0x6C,0x61,0x79,0x3A,0x20,0x31,0x20
	.DB  0x73,0x0,0x44,0x65,0x6C,0x61,0x79,0x3A
	.DB  0x20,0x32,0x20,0x73,0x0,0x44,0x65,0x6C
	.DB  0x61,0x79,0x3A,0x20,0x35,0x20,0x73,0x0
	.DB  0x44,0x65,0x6C,0x61,0x79,0x3A,0x20,0x31
	.DB  0x30,0x20,0x73,0x0,0x44,0x65,0x6C,0x61
	.DB  0x79,0x3A,0x20,0x31,0x35,0x20,0x73,0x0
	.DB  0x44,0x65,0x6C,0x61,0x79,0x3A,0x20,0x32
	.DB  0x30,0x20,0x73,0x0,0x44,0x65,0x6C,0x61
	.DB  0x79,0x3A,0x20,0x32,0x35,0x20,0x73,0x0
	.DB  0x44,0x65,0x6C,0x61,0x79,0x3A,0x20,0x33
	.DB  0x30,0x20,0x73,0x0,0x4E,0x6F,0x69,0x73
	.DB  0x65,0x3A,0x20,0x0,0x64,0x42,0x0,0x4E
	.DB  0x4F,0x49,0x53,0x45,0x20,0x4C,0x45,0x56
	.DB  0x45,0x4C,0x0,0x4D,0x45,0x54,0x45,0x52
	.DB  0x0
_0x2000003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x02
	.DW  __REG_BIT_VARS*2

	.DW  0x0A
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x01
	.DW  _truyen_delay
	.DW  _0x3*2

	.DW  0x11
	.DW  _0x15
	.DW  _0x0*2

	.DW  0x11
	.DW  _0x15+17
	.DW  _0x0*2+17

	.DW  0x11
	.DW  _0x15+34
	.DW  _0x0*2

	.DW  0x11
	.DW  _0x15+51
	.DW  _0x0*2

	.DW  0x11
	.DW  _0x15+68
	.DW  _0x0*2+34

	.DW  0x11
	.DW  _0x15+85
	.DW  _0x0*2

	.DW  0x11
	.DW  _0x19
	.DW  _0x0*2

	.DW  0x11
	.DW  _0x19+17
	.DW  _0x0*2+51

	.DW  0x11
	.DW  _0x19+34
	.DW  _0x0*2+68

	.DW  0x11
	.DW  _0x19+51
	.DW  _0x0*2+85

	.DW  0x11
	.DW  _0x19+68
	.DW  _0x0*2+102

	.DW  0x11
	.DW  _0x19+85
	.DW  _0x0*2+119

	.DW  0x11
	.DW  _0x19+102
	.DW  _0x0*2+136

	.DW  0x11
	.DW  _0x19+119
	.DW  _0x0*2+153

	.DW  0x11
	.DW  _0x19+136
	.DW  _0x0*2+170

	.DW  0x11
	.DW  _0x19+153
	.DW  _0x0*2+187

	.DW  0x11
	.DW  _0x19+170
	.DW  _0x0*2+204

	.DW  0x11
	.DW  _0x19+187
	.DW  _0x0*2+221

	.DW  0x11
	.DW  _0x19+204
	.DW  _0x0*2+238

	.DW  0x11
	.DW  _0x19+221
	.DW  _0x0*2+255

	.DW  0x11
	.DW  _0x19+238
	.DW  _0x0*2+272

	.DW  0x11
	.DW  _0x19+255
	.DW  _0x0*2+289

	.DW  0x11
	.DW  _0x19+272
	.DW  _0x0*2+306

	.DW  0x0C
	.DW  _0x69
	.DW  _0x0*2+323

	.DW  0x03
	.DW  _0x69+12
	.DW  _0x0*2+14

	.DW  0x11
	.DW  _0x69+15
	.DW  _0x0*2+335

	.DW  0x11
	.DW  _0x69+32
	.DW  _0x0*2+352

	.DW  0x11
	.DW  _0x69+49
	.DW  _0x0*2+369

	.DW  0x11
	.DW  _0x69+66
	.DW  _0x0*2

	.DW  0x0D
	.DW  _0x69+83
	.DW  _0x0*2+386

	.DW  0x0B
	.DW  _0x69+96
	.DW  _0x0*2+399

	.DW  0x0B
	.DW  _0x69+107
	.DW  _0x0*2+410

	.DW  0x0B
	.DW  _0x69+118
	.DW  _0x0*2+421

	.DW  0x0C
	.DW  _0x69+129
	.DW  _0x0*2+432

	.DW  0x0C
	.DW  _0x69+141
	.DW  _0x0*2+444

	.DW  0x0C
	.DW  _0x69+153
	.DW  _0x0*2+456

	.DW  0x0C
	.DW  _0x69+165
	.DW  _0x0*2+468

	.DW  0x0C
	.DW  _0x69+177
	.DW  _0x0*2+480

	.DW  0x08
	.DW  _0x7E
	.DW  _0x0*2+492

	.DW  0x03
	.DW  _0x7E+8
	.DW  _0x0*2+500

	.DW  0x0C
	.DW  _0xC5
	.DW  _0x0*2+503

	.DW  0x06
	.DW  _0xC5+12
	.DW  _0x0*2+515

	.DW  0x02
	.DW  __base_y_G100
	.DW  _0x2000003*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;/*****************************************************
;This program was produced by the
;CodeWizardAVR V2.05.6
;Automatic Program Generator
;© Copyright 1998-2012 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project : SOUND LEVEL METTER
;Version : 3
;Date    : 3/2/2014
;Author  : Cracked By PerTic@n (Evaluation)V1.0 - SonSivRi.to
;Company : SPKT
;Comments:
;
;
;Chip type               : ATmega8
;Program type            : Application
;AVR Core Clock frequency: 8.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 256
;*****************************************************/
;/*Khai bao thu vien su dung*/
;#include <mega8.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;// Alphanumeric LCD functions
;#include <alcd.h>
;#include <stdio.h>
;
;#ifndef RXB8
;#define RXB8 1
;#endif
;
;#ifndef TXB8
;#define TXB8 0
;#endif
;
;#ifndef UPE
;#define UPE 2
;#endif
;
;#ifndef DOR
;#define DOR 3
;#endif
;
;#ifndef FE
;#define FE 4
;#endif
;
;#ifndef UDRE
;#define UDRE 5
;#endif
;
;#ifndef RXC
;#define RXC 7
;#endif
;
;#define FRAMING_ERROR (1<<FE)
;#define PARITY_ERROR (1<<UPE)
;#define DATA_OVERRUN (1<<DOR)
;#define DATA_REGISTER_EMPTY (1<<UDRE)
;#define RX_COMPLETE (1<<RXC)
;
;// Standard Input/Output functions
;#define ADC_VREF_TYPE 0x00
;#include <KhaiBao.c>
;#define  LATCH  PINB.2       //nut nhan LATCH
;#define  UP  PINC.4       //nut nhan UP
;#define  MODE  PINB.1        //nut nhan cai dat che do
;bit latch_old, mode_old, up_old;
;bit tt;                      //bit trang thai cho LATCH
;unsigned long adc_value;     //bien luu gia tri adc
;unsigned long db_value;      //bien luu gia tri da tinh toan ra dB
;//unsigned int db_value_ss;
;unsigned char bien_edit_db_value=130, bien_baud=2;    // bien MaxValue vaf bieen Baud Rate
;char data=' ';                                          // bien data luu tam ky tu nhan duoc tu may tinh
;unsigned int edit_db_value1;
;char bien_delay=1;
;unsigned int delay,luu_delay=250;     \
;unsigned char connect=0,bien_mode=0;
;unsigned int ng, tr, ch, dv;       // Dung cho gia tri dB
;unsigned int Nghin, Tram, Chuc, Donvi;  // Dung cho Delay edit_db_value
;unsigned char truyen_data=0;
;unsigned char truyen_delay=65;

	.DSEG
;
;//KHAI BAO CHUONG TRINH CON SU DUNG
;unsigned int read_adc(unsigned char adc_input);
;#include <InterruptUSART.c>
;//=================================================
;//NHAN DATA
;//=================================================
;//USART Receiver buffer
;#define RX_BUFFER_SIZE 8
;char rx_buffer[RX_BUFFER_SIZE];
;
;#if RX_BUFFER_SIZE <256
;unsigned char rx_wr_index, rx_rd_index,rx_counter;
;#else
;unsigned int rx_wr_index, rx_rd_index,rx_counter;
;#endif
;
;bit rx_buffer_overflow;
;
;//USART Receiver interrupt service routine
;interrupt [USART_RXC] void usart_rx_isr(void)
; 0000 0045 {

	.CSEG
_usart_rx_isr:
	RCALL SUBOPT_0x0
;    char status;
;    status = UCSRA;
	ST   -Y,R17
;	status -> R17
	IN   R17,11
;    data = UDR;
	IN   R7,12
;    if ((status & (FRAMING_ERROR|PARITY_ERROR|DATA_OVERRUN )) ==0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x4
;    {
;      rx_buffer[rx_wr_index]=data;
	LDS  R30,_rx_wr_index
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer)
	SBCI R31,HIGH(-_rx_buffer)
	ST   Z,R7
;      if(++ rx_wr_index == RX_BUFFER_SIZE) rx_wr_index =0;
	LDS  R26,_rx_wr_index
	SUBI R26,-LOW(1)
	STS  _rx_wr_index,R26
	CPI  R26,LOW(0x8)
	BRNE _0x5
	LDI  R30,LOW(0)
	STS  _rx_wr_index,R30
;      if(++ rx_counter == RX_BUFFER_SIZE)
_0x5:
	LDS  R26,_rx_counter
	SUBI R26,-LOW(1)
	STS  _rx_counter,R26
	CPI  R26,LOW(0x8)
	BRNE _0x6
;      {
;        rx_counter = 0;
	LDI  R30,LOW(0)
	STS  _rx_counter,R30
;        rx_buffer_overflow =1;
	SET
	BLD  R2,4
;      }
;    }
_0x6:
;}
_0x4:
	LD   R17,Y+
	RJMP _0xD6
;
;//#ifndef _DEBUG_TERMINAL_IO_
;////Get a character from USART Receiver buffer
;//#define _ALTERNATE_GETCHAR_
;//#pragma used+
;//char getchar(void)
;//{
;//  char data;
;//  while (rx_counter ==0);
;//  data = rx_buffer[rx_rd_index];
;//  if (++rx_rd_index == RX_BUFFER_SIZE) rx_rd_index = 0;
;//  #asm("cli")
;//  --rx_counter;
;//  #asm("sei")
;//  return data;
;//}
;//
;//#pragma used-
;//#endif
;
;//==================================================
;//TRUYEN DATA
;//==================================================
;//USART Transmitter buffer
;#define TX_BUFFER_SIZE 8
;char tx_buffer[TX_BUFFER_SIZE];
;
;#if TX_BUFFER_SIZE <256
;unsigned char tx_wr_index, tx_rd_index,tx_counter;
;#else
;unsigned int tx_wr_index, tx_rd_index,tx_counter;
;#endif
;
;//USART Transmitter interrupt service routine
;interrupt [USART_TXC] void usart_tx_isr(void)
;{
_usart_tx_isr:
	RCALL SUBOPT_0x0
;  if (tx_counter)
	RCALL SUBOPT_0x1
	CPI  R30,0
	BREQ _0x7
;  {
;    --tx_counter;
	RCALL SUBOPT_0x1
	SUBI R30,LOW(1)
	STS  _tx_counter,R30
;    UDR = tx_buffer[tx_rd_index];
	LDS  R30,_tx_rd_index
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer)
	SBCI R31,HIGH(-_tx_buffer)
	LD   R30,Z
	OUT  0xC,R30
;    if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index =0;
	LDS  R26,_tx_rd_index
	SUBI R26,-LOW(1)
	STS  _tx_rd_index,R26
	CPI  R26,LOW(0x8)
	BRNE _0x8
	LDI  R30,LOW(0)
	STS  _tx_rd_index,R30
;  }
_0x8:
;}
_0x7:
_0xD6:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R26,Y+
	RETI
;
;#ifndef _DEBUG_TERMINAL_IO_
;//Write a character to a USART Transmiter buffer
;#define _ALTERNATE_PUTCHAR_
;#pragma used+
;void putchar (char c)
;{
_putchar:
;  while (tx_counter == TX_BUFFER_SIZE)
	ST   -Y,R26
;	c -> Y+0
_0x9:
	LDS  R26,_tx_counter
	CPI  R26,LOW(0x8)
	BRNE _0xB
;  #asm ("cli")
	cli
;  if (tx_counter || (( UCSRA & DATA_REGISTER_EMPTY) == 0))
	RJMP _0x9
_0xB:
	RCALL SUBOPT_0x1
	CPI  R30,0
	BRNE _0xD
	SBIC 0xB,5
	RJMP _0xC
_0xD:
;  {
;    tx_buffer[tx_wr_index]=c;
	LDS  R30,_tx_wr_index
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer)
	SBCI R31,HIGH(-_tx_buffer)
	LD   R26,Y
	STD  Z+0,R26
;    if(++ tx_wr_index == TX_BUFFER_SIZE) tx_wr_index =0;
	LDS  R26,_tx_wr_index
	SUBI R26,-LOW(1)
	STS  _tx_wr_index,R26
	CPI  R26,LOW(0x8)
	BRNE _0xF
	LDI  R30,LOW(0)
	STS  _tx_wr_index,R30
;    ++ tx_counter;
_0xF:
	RCALL SUBOPT_0x1
	SUBI R30,-LOW(1)
	STS  _tx_counter,R30
;  }
;  else
	RJMP _0x10
_0xC:
;  UDR =c;
	LD   R30,Y
	OUT  0xC,R30
;  delay_ms(20);
_0x10:
	LDI  R26,LOW(20)
	RCALL SUBOPT_0x2
;  #asm("sei")
	sei
;}
	RJMP _0x2080001
;
;#pragma used-
;#endif
;//==================================================
;//==================================================
;#include <Function.c>
;// Read the AD conversion result
;unsigned int read_adc(unsigned char adc_input)   //Ham doc gia tri
; 0000 0046 {
_read_adc:
;ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
	ST   -Y,R26
;	adc_input -> Y+0
	LD   R30,Y
	OUT  0x7,R30
;// Delay needed for the stabilization of the ADC input voltage
;delay_us(20);
	__DELAY_USB 53
;// Start the AD conversion
;ADCSRA|=0x40;
	SBI  0x6,6
;// Wait for the AD conversion to complete
;while ((ADCSRA & 0x10)==0);
_0x11:
	SBIS 0x6,4
	RJMP _0x11
;ADCSRA|=0x10;
	SBI  0x6,4
;return ADCW;
	IN   R30,0x4
	IN   R31,0x4+1
	RJMP _0x2080001
;}
;// =================================
;////================================
;//thong bao khi giao dien ket noi voi phan cung
;void thongbao()
;{
_thongbao:
;  if (data=='b')
	LDI  R30,LOW(98)
	CP   R30,R7
	BRNE _0x14
;  {
;    lcd_gotoxy(0,0);
	RCALL SUBOPT_0x3
	RCALL SUBOPT_0x4
;    lcd_puts("                ");
	__POINTW2MN _0x15,0
	RCALL _lcd_puts
;    lcd_gotoxy(0,1);
	RCALL SUBOPT_0x3
	RCALL SUBOPT_0x5
;    lcd_puts("PC DisConnecting");
	__POINTW2MN _0x15,17
	RCALL _lcd_puts
;    delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RCALL SUBOPT_0x6
;    data=' ';
;    lcd_gotoxy(0,1);
	RCALL SUBOPT_0x5
;    lcd_puts("                ");
	__POINTW2MN _0x15,34
	RJMP _0xCB
;
;  }
;    else if(data=='a')
_0x14:
	LDI  R30,LOW(97)
	CP   R30,R7
	BRNE _0x17
;  {
;    lcd_gotoxy(0,0);
	RCALL SUBOPT_0x3
	RCALL SUBOPT_0x4
;    lcd_puts("                ");
	__POINTW2MN _0x15,51
	RCALL _lcd_puts
;    lcd_gotoxy(0,1);
	RCALL SUBOPT_0x3
	RCALL SUBOPT_0x5
;    lcd_puts(" PC Connecting  ");
	__POINTW2MN _0x15,68
	RCALL _lcd_puts
;    delay_ms(1000);
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL SUBOPT_0x6
;    data=' ';
;    lcd_gotoxy(0,1);
	RCALL SUBOPT_0x5
;    lcd_puts("                ");
	__POINTW2MN _0x15,85
_0xCB:
	RCALL _lcd_puts
;  }
;}
_0x17:
	RET

	.DSEG
_0x15:
	.BYTE 0x66
;// ==============================================================
;//khoi block VU
;void lcd_block(unsigned char step,unsigned int adc_value)
;{

	.CSEG
_lcd_block:
;     if (adc_value <1) {
	RCALL SUBOPT_0x7
;	step -> Y+2
;	adc_value -> Y+0
	SBIW R26,1
	BRSH _0x18
;        lcd_puts("                ");
	__POINTW2MN _0x19,0
	RJMP _0xCC
;     }
;     else if (adc_value >=1 && adc_value <9) {
_0x18:
	RCALL SUBOPT_0x8
	SBIW R26,1
	BRLO _0x1C
	RCALL SUBOPT_0x8
	SBIW R26,9
	BRLO _0x1D
_0x1C:
	RJMP _0x1B
_0x1D:
;        lcd_puts("|               ");
	__POINTW2MN _0x19,17
	RJMP _0xCC
;     }
;     else if (adc_value >=step && adc_value <step*2){
_0x1B:
	LDD  R30,Y+2
	RCALL SUBOPT_0x8
	LDI  R31,0
	RCALL SUBOPT_0x9
	BRLO _0x20
	RCALL SUBOPT_0xA
	BRLO _0x21
_0x20:
	RJMP _0x1F
_0x21:
;        lcd_puts("||              ");
	__POINTW2MN _0x19,34
	RJMP _0xCC
;     }
;     else if (adc_value >=step*2 && adc_value <step*3){
_0x1F:
	RCALL SUBOPT_0xA
	BRLO _0x24
	RCALL SUBOPT_0xB
	BRLO _0x25
_0x24:
	RJMP _0x23
_0x25:
;        lcd_puts("|||             ");
	__POINTW2MN _0x19,51
	RJMP _0xCC
;     }
;     else if (adc_value >=step*3 && adc_value <step*4){
_0x23:
	RCALL SUBOPT_0xB
	BRLO _0x28
	RCALL SUBOPT_0xC
	BRLO _0x29
_0x28:
	RJMP _0x27
_0x29:
;        lcd_puts("||||            ");
	__POINTW2MN _0x19,68
	RJMP _0xCC
;     }
;     else if (adc_value >=step*4 && adc_value <step*5){
_0x27:
	RCALL SUBOPT_0xC
	BRLO _0x2C
	RCALL SUBOPT_0xD
	BRLO _0x2D
_0x2C:
	RJMP _0x2B
_0x2D:
;        lcd_puts("|||||           ");
	__POINTW2MN _0x19,85
	RJMP _0xCC
;     }
;     else if (adc_value >=step*5 && adc_value <step*6){
_0x2B:
	RCALL SUBOPT_0xD
	BRLO _0x30
	RCALL SUBOPT_0xE
	BRLO _0x31
_0x30:
	RJMP _0x2F
_0x31:
;        lcd_puts("||||||          ");
	__POINTW2MN _0x19,102
	RJMP _0xCC
;     }
;     else if (adc_value >=step*6 && adc_value <step*7){
_0x2F:
	RCALL SUBOPT_0xE
	BRLO _0x34
	RCALL SUBOPT_0xF
	BRLO _0x35
_0x34:
	RJMP _0x33
_0x35:
;        lcd_puts("|||||||         ");
	__POINTW2MN _0x19,119
	RJMP _0xCC
;     }
;     else if (adc_value >=step*7 && adc_value <step*8){
_0x33:
	RCALL SUBOPT_0xF
	BRLO _0x38
	RCALL SUBOPT_0x10
	BRLO _0x39
_0x38:
	RJMP _0x37
_0x39:
;        lcd_puts("||||||||        ");
	__POINTW2MN _0x19,136
	RJMP _0xCC
;     }
;     else if (adc_value >=step*8 && adc_value <step*9){
_0x37:
	RCALL SUBOPT_0x10
	BRLO _0x3C
	RCALL SUBOPT_0x11
	BRLO _0x3D
_0x3C:
	RJMP _0x3B
_0x3D:
;        lcd_puts("|||||||||       ");
	__POINTW2MN _0x19,153
	RJMP _0xCC
;     }
;     else if (adc_value >=step*9 && adc_value <step*10){
_0x3B:
	RCALL SUBOPT_0x11
	BRLO _0x40
	RCALL SUBOPT_0x12
	BRLO _0x41
_0x40:
	RJMP _0x3F
_0x41:
;        lcd_puts("||||||||||      ");
	__POINTW2MN _0x19,170
	RJMP _0xCC
;     }
;     else if (adc_value >=step*10 && adc_value <step*11){
_0x3F:
	RCALL SUBOPT_0x12
	BRLO _0x44
	RCALL SUBOPT_0x13
	BRLO _0x45
_0x44:
	RJMP _0x43
_0x45:
;        lcd_puts("|||||||||||     ");
	__POINTW2MN _0x19,187
	RJMP _0xCC
;     }
;     else if (adc_value >=step*11 && adc_value <step*12){
_0x43:
	RCALL SUBOPT_0x13
	BRLO _0x48
	RCALL SUBOPT_0x14
	BRLO _0x49
_0x48:
	RJMP _0x47
_0x49:
;        lcd_puts("||||||||||||    ");
	__POINTW2MN _0x19,204
	RJMP _0xCC
;     }
;     else if (adc_value >=step*12 && adc_value <step*13){
_0x47:
	RCALL SUBOPT_0x14
	BRLO _0x4C
	RCALL SUBOPT_0x15
	BRLO _0x4D
_0x4C:
	RJMP _0x4B
_0x4D:
;        lcd_puts("|||||||||||||   ");
	__POINTW2MN _0x19,221
	RJMP _0xCC
;     }
;     else if (adc_value >=step*13 && adc_value <step*14){
_0x4B:
	RCALL SUBOPT_0x15
	BRLO _0x50
	RCALL SUBOPT_0x16
	BRLO _0x51
_0x50:
	RJMP _0x4F
_0x51:
;        lcd_puts("||||||||||||||  ");
	__POINTW2MN _0x19,238
	RJMP _0xCC
;     }
;     else if (adc_value >=step*14 && adc_value <step*15){
_0x4F:
	RCALL SUBOPT_0x16
	BRLO _0x54
	RCALL SUBOPT_0x17
	BRLO _0x55
_0x54:
	RJMP _0x53
_0x55:
;        lcd_puts("||||||||||||||| ");
	__POINTW2MN _0x19,255
	RJMP _0xCC
;     }
;     else if (adc_value >=step*15 && adc_value <step*16){
_0x53:
	RCALL SUBOPT_0x17
	BRLO _0x58
	LDD  R26,Y+2
	LDI  R30,LOW(16)
	MUL  R30,R26
	MOVW R30,R0
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x9
	BRLO _0x59
_0x58:
	RJMP _0x57
_0x59:
;        lcd_puts("||||||||||||||||");
	__POINTW2MN _0x19,272
_0xCC:
	RCALL _lcd_puts
;     };
_0x57:
;}
	RJMP _0x2080002

	.DSEG
_0x19:
	.BYTE 0x121
;// ==============================================================
;// Ham giai ma ASCII dB
;void lcd_putnum_db(unsigned int N)
;{

	.CSEG
_lcd_putnum_db:
;     ng = N/1000;
	RCALL SUBOPT_0x7
;	N -> Y+0
	RCALL SUBOPT_0x18
	RCALL __DIVW21U
	STS  _ng,R30
	STS  _ng+1,R31
;     tr = (N%1000)/100;
	RCALL SUBOPT_0x19
	STS  _tr,R30
	STS  _tr+1,R31
;     ch = (N%100)/10;
	RCALL SUBOPT_0x1A
	STS  _ch,R30
	STS  _ch+1,R31
;     dv = N%10;
	RCALL SUBOPT_0x1B
	STS  _dv,R30
	STS  _dv+1,R31
;}
	RJMP _0x2080003
;// ==============================================================
;// Ham giai ma ASCII
;void lcd_putnum(unsigned int N)
;{
_lcd_putnum:
;     Nghin = N/1000;
	RCALL SUBOPT_0x7
;	N -> Y+0
	RCALL SUBOPT_0x18
	RCALL __DIVW21U
	STS  _Nghin,R30
	STS  _Nghin+1,R31
;     Tram = (N%1000)/100;
	RCALL SUBOPT_0x19
	STS  _Tram,R30
	STS  _Tram+1,R31
;     Chuc = (N%100)/10;
	RCALL SUBOPT_0x1A
	STS  _Chuc,R30
	STS  _Chuc+1,R31
;     Donvi = N%10;
	RCALL SUBOPT_0x1B
	STS  _Donvi,R30
	STS  _Donvi+1,R31
;}
	RJMP _0x2080003
;// ==============================================================
;//chuong tinh con hien thi gia tri am thanh len lcd
;void db_display (unsigned int nghin,unsigned int tram,unsigned int chuc,unsigned int donvi,)
;{
_db_display:
;     if (nghin ==0){
	RCALL SUBOPT_0x1C
;	nghin -> Y+6
;	tram -> Y+4
;	chuc -> Y+2
;	donvi -> Y+0
	BRNE _0x5A
;         if (tram ==0){
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	SBIW R30,0
	BRNE _0x5B
;            lcd_putchar(32);
	RCALL SUBOPT_0x1D
;            lcd_putchar(32);
	LDI  R26,LOW(32)
	RJMP _0xCD
;         }
;         else{
_0x5B:
;            lcd_putchar(32);
	RCALL SUBOPT_0x1D
;            lcd_putchar(tram + 48);
	RCALL SUBOPT_0x1E
_0xCD:
	RCALL _lcd_putchar
;         };
;     }
;     else{
	RJMP _0x5D
_0x5A:
;         lcd_putchar(nghin + 48);
	RCALL SUBOPT_0x1F
;         lcd_putchar(tram + 48);
	RCALL _lcd_putchar
;     };
_0x5D:
;     lcd_putchar(chuc + 48);
	RCALL SUBOPT_0x20
	RCALL _lcd_putchar
;     lcd_putchar(46);
	LDI  R26,LOW(46)
	RCALL _lcd_putchar
;     lcd_putchar(donvi + 48);
	RJMP _0x2080004
;}
;// ==============================================================
;//chuong trinh con hien thi delay + MaxValue dB
;void delay_display (unsigned int nghin,unsigned int tram,unsigned int chuc,unsigned int donvi,)
;{
_delay_display:
;     if (nghin ==0){
	RCALL SUBOPT_0x1C
;	nghin -> Y+6
;	tram -> Y+4
;	chuc -> Y+2
;	donvi -> Y+0
	BRNE _0x5E
;         if (tram ==0){
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	SBIW R30,0
	BRNE _0x5F
;            if (chuc ==0){
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	SBIW R30,0
	BRNE _0x60
;                lcd_putchar(32);
	RCALL SUBOPT_0x1D
;                lcd_putchar(32);
	RCALL SUBOPT_0x1D
;                lcd_putchar(32);
	LDI  R26,LOW(32)
	RJMP _0xCE
;            }
;            else{
_0x60:
;                lcd_putchar(32);
	RCALL SUBOPT_0x1D
;                lcd_putchar(32);
	RCALL SUBOPT_0x1D
;                lcd_putchar(chuc + 48);
	RCALL SUBOPT_0x20
_0xCE:
	RCALL _lcd_putchar
;            }
;         }
;         else{
	RJMP _0x62
_0x5F:
;            lcd_putchar(32);
	RCALL SUBOPT_0x1D
;            lcd_putchar(tram + 48);
	RCALL SUBOPT_0x1E
	RCALL _lcd_putchar
;            lcd_putchar(chuc + 48);
	RCALL SUBOPT_0x20
	RCALL _lcd_putchar
;         }
_0x62:
;     }
;     else{
	RJMP _0x63
_0x5E:
;         lcd_putchar(nghin + 48);
	RCALL SUBOPT_0x1F
;         lcd_putchar(tram + 48);
	RCALL _lcd_putchar
;         lcd_putchar(chuc + 48);
	RCALL SUBOPT_0x20
	RCALL _lcd_putchar
;     }
_0x63:
;     lcd_putchar(donvi + 48);
_0x2080004:
	LD   R26,Y
	SUBI R26,-LOW(48)
	RCALL _lcd_putchar
;}
	ADIW R28,8
	RET
;// ==============================================================
;//===========================
;//chuong trinh con cai dat che do
;void mode_setting ()
;{
_mode_setting:
;   switch (bien_mode) {
	RCALL SUBOPT_0x21
	LDI  R31,0
;    case 0:                      // hien thi block
	SBIW R30,0
	BRNE _0x67
;        lcd_block(64,adc_value);
	LDI  R30,LOW(64)
	ST   -Y,R30
	LDS  R26,_adc_value
	LDS  R27,_adc_value+1
	RCALL _lcd_block
;        break;
	RJMP _0x66
;    case 1:                       //cai dat MaxValue
_0x67:
	RCALL SUBOPT_0x22
	BRNE _0x68
;        lcd_puts("Max Value: ");
	__POINTW2MN _0x69,0
	RCALL _lcd_puts
;        lcd_putnum(bien_edit_db_value);
	MOV  R26,R5
	CLR  R27
	RCALL _lcd_putnum
;        delay_display(Nghin,Tram,Chuc,Donvi);
	LDS  R30,_Nghin
	LDS  R31,_Nghin+1
	RCALL SUBOPT_0x23
	LDS  R30,_Tram
	LDS  R31,_Tram+1
	RCALL SUBOPT_0x23
	LDS  R30,_Chuc
	LDS  R31,_Chuc+1
	RCALL SUBOPT_0x23
	LDS  R26,_Donvi
	LDS  R27,_Donvi+1
	RCALL _delay_display
;        lcd_puts("  ");
	__POINTW2MN _0x69,12
	RCALL _lcd_puts
;        delay = 100;
	RJMP _0xCF
;
;        break;
;    case 2:                         //cai dat Baud Rate
_0x68:
	RCALL SUBOPT_0x24
	BRNE _0x6A
;
;      switch  (bien_baud){
	MOV  R30,R4
	LDI  R31,0
;        case 1:
	RCALL SUBOPT_0x22
	BRNE _0x6E
;                lcd_puts("Baud Rate= 76800");
	__POINTW2MN _0x69,15
	RCALL _lcd_puts
;                UBRRL=6;
	LDI  R30,LOW(6)
	RJMP _0xD0
;                break;
;        case 2:
_0x6E:
	RCALL SUBOPT_0x24
	BRNE _0x6F
;                lcd_puts("Baud Rate= 57600");
	__POINTW2MN _0x69,32
	RCALL _lcd_puts
;                UBRRL=8;
	LDI  R30,LOW(8)
	RJMP _0xD0
;                break;
;        case 3:
_0x6F:
	RCALL SUBOPT_0x25
	BRNE _0x6D
;                lcd_puts("Baud Rate= 14400");
	__POINTW2MN _0x69,49
	RCALL _lcd_puts
;                UBRRL=34;
	LDI  R30,LOW(34)
_0xD0:
	OUT  0x9,R30
;                break;
;     }
_0x6D:
;     delay = 100;
	RJMP _0xCF
;        break;
;    case 3:
_0x6A:
	RCALL SUBOPT_0x25
	BREQ PC+2
	RJMP _0x66
;    {                       //hien thi delay
;       lcd_puts("                ");
	__POINTW2MN _0x69,66
	RCALL _lcd_puts
;       lcd_gotoxy(0,1);
	RCALL SUBOPT_0x3
	RCALL SUBOPT_0x5
;       switch  (bien_delay){
	MOV  R30,R6
	LDI  R31,0
;            case 1:
	RCALL SUBOPT_0x22
	BRNE _0x75
;                    lcd_puts("Delay: 0.5 s");
	__POINTW2MN _0x69,83
	RCALL _lcd_puts
;                    luu_delay = 250;
	LDI  R30,LOW(250)
	LDI  R31,HIGH(250)
	RJMP _0xD1
;                    break;
;            case 2:
_0x75:
	RCALL SUBOPT_0x24
	BRNE _0x76
;                    lcd_puts("Delay: 1 s");
	__POINTW2MN _0x69,96
	RCALL _lcd_puts
;                    luu_delay = 750;    //740
	LDI  R30,LOW(750)
	LDI  R31,HIGH(750)
	RJMP _0xD1
;                    break;
;            case 3:
_0x76:
	RCALL SUBOPT_0x25
	BRNE _0x77
;                    lcd_puts("Delay: 2 s");
	__POINTW2MN _0x69,107
	RCALL _lcd_puts
;                    luu_delay = 1750;  //1480
	LDI  R30,LOW(1750)
	LDI  R31,HIGH(1750)
	RJMP _0xD1
;                    break;
;            case 4:
_0x77:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x78
;                    lcd_puts("Delay: 5 s");
	__POINTW2MN _0x69,118
	RCALL _lcd_puts
;                    luu_delay = 4750;  //3700
	LDI  R30,LOW(4750)
	LDI  R31,HIGH(4750)
	RJMP _0xD1
;                    break;
;            case 5:
_0x78:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x79
;                    lcd_puts("Delay: 10 s");
	__POINTW2MN _0x69,129
	RCALL _lcd_puts
;                    luu_delay = 9750;     //4700
	LDI  R30,LOW(9750)
	LDI  R31,HIGH(9750)
	RJMP _0xD1
;                    break;
;            case 6:
_0x79:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0x7A
;                    lcd_puts("Delay: 15 s");
	__POINTW2MN _0x69,141
	RCALL _lcd_puts
;                    luu_delay = 14750;   //11100
	LDI  R30,LOW(14750)
	LDI  R31,HIGH(14750)
	RJMP _0xD1
;                    break;
;            case 7:
_0x7A:
	CPI  R30,LOW(0x7)
	LDI  R26,HIGH(0x7)
	CPC  R31,R26
	BRNE _0x7B
;                    lcd_puts("Delay: 20 s");
	__POINTW2MN _0x69,153
	RCALL _lcd_puts
;                    luu_delay = 19750;  //14800
	LDI  R30,LOW(19750)
	LDI  R31,HIGH(19750)
	RJMP _0xD1
;                    break;
;            case 8:
_0x7B:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x7C
;                    lcd_puts("Delay: 25 s");
	__POINTW2MN _0x69,165
	RCALL _lcd_puts
;                    luu_delay = 24750; //18500
	LDI  R30,LOW(24750)
	LDI  R31,HIGH(24750)
	RJMP _0xD1
;                    break;
;            case 9:
_0x7C:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0x74
;                    lcd_puts("Delay: 30 s");
	__POINTW2MN _0x69,177
	RCALL _lcd_puts
;                    luu_delay = 29750; //22200
	LDI  R30,LOW(29750)
	LDI  R31,HIGH(29750)
_0xD1:
	MOVW R12,R30
;                    break;
;       }
_0x74:
;        delay = 100;
_0xCF:
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	MOVW R10,R30
;        break;
;    }
;    };
_0x66:
;}
	RET

	.DSEG
_0x69:
	.BYTE 0xBD
;// ==============================================================
;void adc_convert(unsigned char channel)
;{

	.CSEG
_adc_convert:
;     // Chon che do chot hoac khong chot gia tri
;    lcd_gotoxy(0,0);
	ST   -Y,R26
;	channel -> Y+0
	RCALL SUBOPT_0x3
	RCALL SUBOPT_0x4
;    lcd_puts("Noise: ");
	__POINTW2MN _0x7E,0
	RCALL _lcd_puts
;    lcd_gotoxy(13,0);
	LDI  R30,LOW(13)
	RCALL SUBOPT_0x26
;    lcd_puts("dB");
	__POINTW2MN _0x7E,8
	RCALL _lcd_puts
;
;    lcd_gotoxy(15,0);
	LDI  R30,LOW(15)
	RCALL SUBOPT_0x26
;     if (tt==0){
	SBRC R2,3
	RJMP _0x7F
;        edit_db_value1 = bien_edit_db_value*10;
	MOV  R26,R5
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R8,R0
;        adc_value = read_adc(channel)-293;   //-293                // doc ADC kênh Channel, hi
	LD   R26,Y
	RCALL _read_adc
	SUBI R30,LOW(293)
	SBCI R31,HIGH(293)
	CLR  R22
	CLR  R23
	RCALL SUBOPT_0x27
;
;        adc_value = 730 - adc_value;                    //Hieu chinh gia tri phù hop voi Microphone
	RCALL SUBOPT_0x28
	RCALL SUBOPT_0x29
	RCALL __SUBD12
	RCALL SUBOPT_0x27
;        db_value  = ((adc_value*edit_db_value1)/730);  // Tính toán giá giá tri chuyen doi
	MOVW R30,R8
	RCALL SUBOPT_0x28
	CLR  R22
	CLR  R23
	RCALL __MULD12U
	MOVW R26,R30
	MOVW R24,R22
	RCALL SUBOPT_0x29
	RCALL __DIVD21U
	RCALL SUBOPT_0x2A
;        lcd_putchar(20);                              // xuat ky tu trang ra LCD
	LDI  R26,LOW(20)
	RJMP _0xD2
;     }
;     else{
_0x7F:
;        db_value = db_value;
	LDS  R30,_db_value
	LDS  R31,_db_value+1
	LDS  R22,_db_value+2
	LDS  R23,_db_value+3
	RCALL SUBOPT_0x2A
;        lcd_putchar(0xff);                            // xuat ky tu boi den ra lcd
	LDI  R26,LOW(255)
_0xD2:
	RCALL _lcd_putchar
;     };
;         // Hien thi gia tri len LCD
;         lcd_gotoxy(7,0);
	LDI  R30,LOW(7)
	RCALL SUBOPT_0x26
;         lcd_putnum_db(db_value);                    // giai ma
	RCALL SUBOPT_0x2B
	RCALL _lcd_putnum_db
;         db_display(ng,tr,ch,dv);                    //hien thi gia tri dB
	LDS  R30,_ng
	LDS  R31,_ng+1
	RCALL SUBOPT_0x23
	LDS  R30,_tr
	LDS  R31,_tr+1
	RCALL SUBOPT_0x23
	LDS  R30,_ch
	LDS  R31,_ch+1
	RCALL SUBOPT_0x23
	LDS  R26,_dv
	LDS  R27,_dv+1
	RCALL _db_display
;}
	RJMP _0x2080001

	.DSEG
_0x7E:
	.BYTE 0xB
;//===============================================
;//===================================
;// truyen du lieu len may tinh
;void uart_db_tx(unsigned int db_value)
;{

	.CSEG
_uart_db_tx:
;     if(connect==1)
	ST   -Y,R27
	ST   -Y,R26
;	db_value -> Y+0
	LDS  R26,_connect
	CPI  R26,LOW(0x1)
	BRNE _0x81
;     {
;         if(truyen_data==1)
	LDS  R26,_truyen_data
	CPI  R26,LOW(0x1)
	BRNE _0x82
;         {
;             if (db_value <=99)
	RCALL SUBOPT_0x2C
	BRSH _0x83
;             {
;                    putchar('\n');    // phai gui cai nay truoc giao dien moi hien thi lau cho minh thay
	LDI  R26,LOW(10)
	RJMP _0xD3
;                    putchar(ch +48);
;                    putchar('.');
;                    putchar(dv +48);
;                    putchar('\t');
;
;             }
;             else if ((db_value > 99) && (db_value <= 999))
_0x83:
	RCALL SUBOPT_0x2C
	BRLO _0x86
	RCALL SUBOPT_0x2D
	BRLO _0x87
_0x86:
	RJMP _0x85
_0x87:
;             {
;                    putchar('\n');      // phai gui cai nay truoc giao dien moi hien thi lau cho minh thay
	LDI  R26,LOW(10)
	RJMP _0xD4
;                    putchar(tr +48);
;                    putchar(ch +48);
;                    putchar('.');
;                    putchar(dv +48);
;                    putchar('\t');
;             }
;             else if ((db_value > 999))
_0x85:
	RCALL SUBOPT_0x2D
	BRLO _0x89
;             {
;                    putchar('\n');     // phai gui cai nay truoc giao dien moi hien thi lau cho minh thay
	LDI  R26,LOW(10)
	RCALL _putchar
;                    putchar(ng +48);    //gui ky tu nghin
	LDS  R26,_ng
	SUBI R26,-LOW(48)
_0xD4:
	RCALL _putchar
;                    putchar(tr +48);     //gui ky tu tram
	LDS  R26,_tr
	SUBI R26,-LOW(48)
_0xD3:
	RCALL _putchar
;                    putchar(ch +48);    //gui ky tu chuc
	LDS  R26,_ch
	SUBI R26,-LOW(48)
	RCALL _putchar
;                    putchar('.');       //gui dau cham
	LDI  R26,LOW(46)
	RCALL _putchar
;                    putchar(dv +48);      //gui ky tu don vi
	LDS  R26,_dv
	SUBI R26,-LOW(48)
	RCALL _putchar
;                    putchar('\t');
	LDI  R26,LOW(9)
	RCALL _putchar
;             }
;         }
_0x89:
;     }
_0x82:
;     else
	RJMP _0x8A
_0x81:
;     {
;        delay_ms(70);
	LDI  R26,LOW(70)
	RCALL SUBOPT_0x2
;     }
_0x8A:
;}
	RJMP _0x2080003
;//===================================
;
;
;// Timer 0 overflow interrupt service routine
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)          //Ngat tran Timer 0
; 0000 004A {
_timer0_ovf_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 004B // Place your code here
; 0000 004C    TCNT0=0x00;
	LDI  R30,LOW(0)
	OUT  0x32,R30
; 0000 004D        if(data=='a')       // Neu data=='a' thi ket noi may tinh
	LDI  R30,LOW(97)
	CP   R30,R7
	BRNE _0x8B
; 0000 004E        {
; 0000 004F         connect=1;
	LDI  R30,LOW(1)
	STS  _connect,R30
; 0000 0050         truyen_data=0;
	LDI  R30,LOW(0)
	STS  _truyen_data,R30
; 0000 0051        }
; 0000 0052        else if(data=='b')  // Neu data=='b' thi ngat ket noi may tinh
	RJMP _0x8C
_0x8B:
	LDI  R30,LOW(98)
	CP   R30,R7
	BRNE _0x8D
; 0000 0053        {
; 0000 0054         connect=0;
	LDI  R30,LOW(0)
	STS  _connect,R30
; 0000 0055        }
; 0000 0056        else if(data=='1') // Neu data=='1' thi delay 0.5s
	RJMP _0x8E
_0x8D:
	LDI  R30,LOW(49)
	CP   R30,R7
	BRNE _0x8F
; 0000 0057        {
; 0000 0058         bien_delay=1;
	LDI  R30,LOW(1)
	MOV  R6,R30
; 0000 0059         luu_delay = 250;
	LDI  R30,LOW(250)
	LDI  R31,HIGH(250)
	RJMP _0xD5
; 0000 005A        }
; 0000 005B        else if(data=='2')  // Neu data=='2' thi delay 1s
_0x8F:
	LDI  R30,LOW(50)
	CP   R30,R7
	BRNE _0x91
; 0000 005C        {
; 0000 005D         bien_delay=2;
	LDI  R30,LOW(2)
	MOV  R6,R30
; 0000 005E         luu_delay = 750;
	LDI  R30,LOW(750)
	LDI  R31,HIGH(750)
	RJMP _0xD5
; 0000 005F        }
; 0000 0060        else if(data=='3')  // Neu data=='3' thi delay 2s
_0x91:
	LDI  R30,LOW(51)
	CP   R30,R7
	BRNE _0x93
; 0000 0061        {
; 0000 0062         bien_delay=3;
	LDI  R30,LOW(3)
	MOV  R6,R30
; 0000 0063         luu_delay = 1750;
	LDI  R30,LOW(1750)
	LDI  R31,HIGH(1750)
	RJMP _0xD5
; 0000 0064        }
; 0000 0065        else if(data=='4') // Neu data=='4' thi delay 5s
_0x93:
	LDI  R30,LOW(52)
	CP   R30,R7
	BRNE _0x95
; 0000 0066        {
; 0000 0067         bien_delay=4;
	LDI  R30,LOW(4)
	MOV  R6,R30
; 0000 0068         luu_delay = 4750;
	LDI  R30,LOW(4750)
	LDI  R31,HIGH(4750)
	RJMP _0xD5
; 0000 0069        }
; 0000 006A        else if(data=='5') // Neu data=='5' thi delay 10s
_0x95:
	LDI  R30,LOW(53)
	CP   R30,R7
	BRNE _0x97
; 0000 006B        {
; 0000 006C         bien_delay=5;
	LDI  R30,LOW(5)
	MOV  R6,R30
; 0000 006D         luu_delay = 9750;
	LDI  R30,LOW(9750)
	LDI  R31,HIGH(9750)
	RJMP _0xD5
; 0000 006E        }
; 0000 006F        else if(data=='6')  // Neu data=='6' thi delay 15s
_0x97:
	LDI  R30,LOW(54)
	CP   R30,R7
	BRNE _0x99
; 0000 0070        {
; 0000 0071         bien_delay=6;
	LDI  R30,LOW(6)
	MOV  R6,R30
; 0000 0072         luu_delay = 14750;
	LDI  R30,LOW(14750)
	LDI  R31,HIGH(14750)
	RJMP _0xD5
; 0000 0073        }
; 0000 0074        else if(data=='7')  // Neu data=='7' thi delay 20s
_0x99:
	LDI  R30,LOW(55)
	CP   R30,R7
	BRNE _0x9B
; 0000 0075        {
; 0000 0076         bien_delay=7;
	LDI  R30,LOW(7)
	MOV  R6,R30
; 0000 0077         luu_delay = 19750;
	LDI  R30,LOW(19750)
	LDI  R31,HIGH(19750)
	RJMP _0xD5
; 0000 0078        }
; 0000 0079        else if(data=='8')  // Neu data=='8' thi delay 25s
_0x9B:
	LDI  R30,LOW(56)
	CP   R30,R7
	BRNE _0x9D
; 0000 007A        {
; 0000 007B         bien_delay=8;
	LDI  R30,LOW(8)
	MOV  R6,R30
; 0000 007C         luu_delay = 24750;
	LDI  R30,LOW(24750)
	LDI  R31,HIGH(24750)
	RJMP _0xD5
; 0000 007D        }
; 0000 007E        else if(data=='9')  // Neu data=='9' thi delay 30s
_0x9D:
	LDI  R30,LOW(57)
	CP   R30,R7
	BRNE _0x9F
; 0000 007F        {
; 0000 0080         bien_delay=9;
	LDI  R30,LOW(9)
	MOV  R6,R30
; 0000 0081         luu_delay = 29750;
	LDI  R30,LOW(29750)
	LDI  R31,HIGH(29750)
_0xD5:
	MOVW R12,R30
; 0000 0082        }
; 0000 0083 
; 0000 0084 
; 0000 0085        if(!MODE && MODE!=mode_old)  // Neu nha nut Mode thi tang MODE
_0x9F:
_0x8E:
_0x8C:
	SBIC 0x16,1
	RJMP _0xA1
	RCALL SUBOPT_0x2E
	BRNE _0xA2
_0xA1:
	RJMP _0xA0
_0xA2:
; 0000 0086        {
; 0000 0087        while (!MODE && MODE!=mode_old){};
_0xA3:
	SBIC 0x16,1
	RJMP _0xA6
	RCALL SUBOPT_0x2E
	BRNE _0xA7
_0xA6:
	RJMP _0xA5
_0xA7:
	RJMP _0xA3
_0xA5:
; 0000 0088 //        delay_ms(200);
; 0000 0089         bien_mode++;
	RCALL SUBOPT_0x21
	SUBI R30,-LOW(1)
	STS  _bien_mode,R30
; 0000 008A         if (bien_mode == 4)
	RCALL SUBOPT_0x2F
	CPI  R26,LOW(0x4)
	BRNE _0xA8
; 0000 008B             bien_mode =0;
	LDI  R30,LOW(0)
	STS  _bien_mode,R30
; 0000 008C        }
_0xA8:
; 0000 008D        mode_old = MODE;
_0xA0:
	CLT
	SBIC 0x16,1
	SET
	BLD  R2,1
; 0000 008E }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;
;// Timer2 overflow interrupt service routine
;interrupt [TIM2_OVF] void timer2_ovf_isr(void)    //Ngat tran Timer 2
; 0000 0092 {
_timer2_ovf_isr:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 0093 // Place your code here
; 0000 0094     TCNT2=0x00;
	LDI  R30,LOW(0)
	OUT  0x24,R30
; 0000 0095     // Place your code here
; 0000 0096        if(!LATCH && LATCH!=latch_old)    //nut LATCH cung la nut DOWN
	SBIC 0x16,2
	RJMP _0xAA
	RCALL SUBOPT_0x30
	BRNE _0xAB
_0xAA:
	RJMP _0xA9
_0xAB:
; 0000 0097        {
; 0000 0098         while (!LATCH && LATCH!=latch_old){};
_0xAC:
	SBIC 0x16,2
	RJMP _0xAF
	RCALL SUBOPT_0x30
	BRNE _0xB0
_0xAF:
	RJMP _0xAE
_0xB0:
	RJMP _0xAC
_0xAE:
; 0000 0099 //         delay_ms(200);
; 0000 009A          if (bien_mode == 0)   // chot/khong chot gia tri
	RCALL SUBOPT_0x21
	CPI  R30,0
	BRNE _0xB1
; 0000 009B          {
; 0000 009C            tt=~tt;
	LDI  R30,LOW(8)
	EOR  R2,R30
; 0000 009D          }
; 0000 009E          else if (bien_mode==1)    //giam gia tri do lon nhat
	RJMP _0xB2
_0xB1:
	RCALL SUBOPT_0x2F
	CPI  R26,LOW(0x1)
	BRNE _0xB3
; 0000 009F          {
; 0000 00A0            bien_edit_db_value -= 10;
	LDI  R30,LOW(10)
	SUB  R5,R30
; 0000 00A1            if(bien_edit_db_value<20 )
	LDI  R30,LOW(20)
	CP   R5,R30
	BRSH _0xB4
; 0000 00A2              bien_edit_db_value=140;
	LDI  R30,LOW(140)
	MOV  R5,R30
; 0000 00A3          }
_0xB4:
; 0000 00A4 //         else if (bien_mode==2)    //giam toc do baud
; 0000 00A5 //         {
; 0000 00A6 //           bien_baud--;
; 0000 00A7 //
; 0000 00A8 //           if (bien_baud < 1)
; 0000 00A9 //           bien_baud =3;
; 0000 00AA //         }
; 0000 00AB          else if (bien_mode==3)   //giam gia tri delay
	RJMP _0xB5
_0xB3:
	RCALL SUBOPT_0x2F
	CPI  R26,LOW(0x3)
	BRNE _0xB6
; 0000 00AC          {
; 0000 00AD            bien_delay --;
	DEC  R6
; 0000 00AE 
; 0000 00AF            if(bien_delay<1 )
	LDI  R30,LOW(1)
	CP   R6,R30
	BRSH _0xB7
; 0000 00B0              bien_delay=9;
	LDI  R30,LOW(9)
	MOV  R6,R30
; 0000 00B1            truyen_delay = bien_delay + 64;
_0xB7:
	RCALL SUBOPT_0x31
; 0000 00B2 //           if (truyen_delay < 65)
; 0000 00B3 //             truyen_delay =73;
; 0000 00B4            putchar(truyen_delay);
; 0000 00B5          }
; 0000 00B6        }
_0xB6:
_0xB5:
_0xB2:
; 0000 00B7        latch_old = LATCH;
_0xA9:
	CLT
	SBIC 0x16,2
	SET
	BLD  R2,0
; 0000 00B8 
; 0000 00B9 
; 0000 00BA        if(!UP && UP!=up_old)
	SBIC 0x13,4
	RJMP _0xB9
	RCALL SUBOPT_0x32
	BRNE _0xBA
_0xB9:
	RJMP _0xB8
_0xBA:
; 0000 00BB        {
; 0000 00BC         while (!UP && UP!=up_old){};
_0xBB:
	SBIC 0x13,4
	RJMP _0xBE
	RCALL SUBOPT_0x32
	BRNE _0xBF
_0xBE:
	RJMP _0xBD
_0xBF:
	RJMP _0xBB
_0xBD:
; 0000 00BD //         delay_ms(200);
; 0000 00BE          if (bien_mode==1)     //tang gia tri do lon nhat
	RCALL SUBOPT_0x2F
	CPI  R26,LOW(0x1)
	BRNE _0xC0
; 0000 00BF          {
; 0000 00C0            bien_edit_db_value += 10;
	LDI  R30,LOW(10)
	ADD  R5,R30
; 0000 00C1            if(bien_edit_db_value>140 )
	LDI  R30,LOW(140)
	CP   R30,R5
	BRSH _0xC1
; 0000 00C2              bien_edit_db_value=20;
	LDI  R30,LOW(20)
	MOV  R5,R30
; 0000 00C3          }
_0xC1:
; 0000 00C4 //         else if (bien_mode==2) //tang toc do baund
; 0000 00C5 //         {
; 0000 00C6 //           bien_baud++;
; 0000 00C7 //
; 0000 00C8 //           if (bien_baud > 3)
; 0000 00C9 //           bien_baud =1;
; 0000 00CA //         }
; 0000 00CB          else if (bien_mode==3)   //tang gia tri delay
	RJMP _0xC2
_0xC0:
	RCALL SUBOPT_0x2F
	CPI  R26,LOW(0x3)
	BRNE _0xC3
; 0000 00CC          {
; 0000 00CD            bien_delay ++;
	INC  R6
; 0000 00CE            if(bien_delay>9 )
	LDI  R30,LOW(9)
	CP   R30,R6
	BRSH _0xC4
; 0000 00CF              bien_delay=1;
	LDI  R30,LOW(1)
	MOV  R6,R30
; 0000 00D0            truyen_delay = bien_delay + 64;
_0xC4:
	RCALL SUBOPT_0x31
; 0000 00D1 //           if (truyen_delay > 73)
; 0000 00D2 //             truyen_delay =65;
; 0000 00D3            putchar(truyen_delay);
; 0000 00D4          }
; 0000 00D5        }
_0xC3:
_0xC2:
; 0000 00D6        up_old = UP;
_0xB8:
	CLT
	SBIC 0x13,4
	SET
	BLD  R2,2
; 0000 00D7 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
;void main(void)
; 0000 00D9 {
_main:
; 0000 00DA     #include <ConfigSet.c>
;// Declare your local variables here
;
;// Input/Output Ports initialization
;// Port B initialization
;// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out
;// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0
;PORTB=0xfe;
	LDI  R30,LOW(254)
	OUT  0x18,R30
;DDRB=0x01;           // =0xFF la ngo ra
	LDI  R30,LOW(1)
	OUT  0x17,R30
;
;// Port C initialization
;// Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
;// State6=T State5=T State4=T State3=T State2=T State1=T State0=T
;PORTC=0xf0;
	LDI  R30,LOW(240)
	OUT  0x15,R30
;DDRC=0xf0;         // =0x00 la ngo vao
	OUT  0x14,R30
;
;// Port D initialization
;// Func7=In Func6=In Func5=In Func4=Out Func3=Out Func2=Out Func1=In Func0=In
;// State7=P State6=P State5=P State4=0 State3=0 State2=0 State1=T State0=T
;PORTD=0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;DDRD=0xfC;
	LDI  R30,LOW(252)
	OUT  0x11,R30
;
;// Timer/Counter 0 initialization
;// Clock source: System Clock
;// Clock value: 1000.000 kHz
;TCCR0=0x02;
	LDI  R30,LOW(2)
	OUT  0x33,R30
;TCNT0=0x00;
	LDI  R30,LOW(0)
	OUT  0x32,R30
;
;// Timer/Counter 1 initialization
;// Clock source: System Clock
;// Clock value: Timer1 Stopped
;// Mode: Normal top=0xFFFF
;// OC1A output: Discon.
;// OC1B output: Discon.
;// Noise Canceler: Off
;// Input Capture on Falling Edge
;// Timer1 Overflow Interrupt: Off
;// Input Capture Interrupt: Off
;// Compare A Match Interrupt: Off
;// Compare B Match Interrupt: Off
;/*
;   - 3 bit TRONG THANH GHI TCCR1B: /CS12/CS11/CS10/=/1/0/1/
;   - DE BAT TIMER1: GAN TCCR1B=0x05.
;   - DE TAT TIMER1: GAN TCCR1B=0x00 - TIMER1 KHONG CO NGUON XUNG NHIP
;Tan so T1 =  FOSC(8Mh)/1024 = 7812.5 Hz = 7.813 KHz
;Thoi gian dem 1 don vi cua T1= 1/7.813 = 0.128 ms
;Delay 500ms thi T1 phai dem duoc 500/0.128 =3906 lan
;5000/39063
;VAY GIA TRI CAN DAT CHO VAO THANH GHI TCNT1 CUA TIMER 1 LA 65536-39063=26500 = 0x9784
;- BIT TOV1 TRONG THANH GHI TIFR SE DUOC BAT LEN KHI TIMER1 TRAN.
;*/
;TCCR1A=0x00;
	OUT  0x2F,R30
;TCCR1B=0x00;
	OUT  0x2E,R30
;
;TCNT1H=0x67;
	LDI  R30,LOW(103)
	OUT  0x2D,R30
;TCNT1L=0x84;
	LDI  R30,LOW(132)
	OUT  0x2C,R30
;ICR1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x27,R30
;ICR1L=0x00;
	OUT  0x26,R30
;OCR1AH=0x00;
	OUT  0x2B,R30
;OCR1AL=0x00;
	OUT  0x2A,R30
;OCR1BH=0x00;
	OUT  0x29,R30
;OCR1BL=0x00;
	OUT  0x28,R30
;
;// Timer/Counter 2 initialization
;// Clock source: System Clock
;// Clock value: 1000.000 kHz
;// Mode: Normal top=0xFF
;// OC2 output: Disconnected
;ASSR=0x00;
	OUT  0x22,R30
;TCCR2=0x02;
	LDI  R30,LOW(2)
	OUT  0x25,R30
;TCNT2=0x00;
	LDI  R30,LOW(0)
	OUT  0x24,R30
;OCR2=0x00;
	OUT  0x23,R30
;
;// External Interrupt(s) initialization
;// INT0: Off
;// INT1: Off
;MCUCR=0x00;
	OUT  0x35,R30
;
;// Timer(s)/Counter(s) Interrupt(s) initialization
;TIMSK=0x41;
	LDI  R30,LOW(65)
	OUT  0x39,R30
;
;// USART initialization
;// Communication Parameters: 8 Data, 1 Stop, No Parity
;// USART Receiver: On
;// USART Transmitter: On
;// USART Mode: Asynchronous
;// USART Baud Rate: 9600
;UCSRA=0x00;
	LDI  R30,LOW(0)
	OUT  0xB,R30
;UCSRB=((1<<RXCIE)|(1<<RXEN)|(1<<TXEN));        //cho phep truyen/nhan UART
	LDI  R30,LOW(152)
	OUT  0xA,R30
;UCSRC=(1<<URSEL)|(1<<UCSZ1)|(1<<UCSZ0);        //quy dinh do dai du lieu = 9 bit = 8 data + 1 stop
	LDI  R30,LOW(134)
	OUT  0x20,R30
;UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;//
;//UBRRL=6;      // Toc do Boud = 76800 bps
;UBRRL=8;      // Toc do Boud = 57600 bps
	LDI  R30,LOW(8)
	OUT  0x9,R30
;//UBRRL=25;      // Toc do Boud = 19200 bps
;//UBRRL=51;     //Toc do Boud = 9600 bps
;
;
;// Analog Comparator initialization
;// Analog Comparator: Off
;// Analog Comparator Input Capture by Timer/Counter 1: Off
;ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
;SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
;
;// ADC initialization
;// ADC Clock frequency: 500.000 kHz
;// ADC Voltage Reference: AREF pin
;ADMUX=ADC_VREF_TYPE & 0xff;
	OUT  0x7,R30
;ADCSRA=0x84;                 //cho phep chuyen doi ADC
	LDI  R30,LOW(132)
	OUT  0x6,R30
;
;// SPI initialization
;// SPI disabled
;SPCR=0x00;
	LDI  R30,LOW(0)
	OUT  0xD,R30
;
;// TWI initialization
;// TWI disabled
;TWCR=0x00;
	OUT  0x36,R30
;
;// Alphanumeric LCD initialization
;// Connections are specified in the
;// Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
;// RS - PORTD Bit 2
;// RD - PORTD Bit 3
;// EN - PORTD Bit 4
;// D4 - PORTB Bit 4
;// D5 - PORTB Bit 5
;// D6 - PORTB Bit 6
;// D7 - PORTB Bit 7
; 0000 00DB     // Global enable interrupts
; 0000 00DC     #asm("sei")
	sei
; 0000 00DD     // Characters/line: 16
; 0000 00DE     lcd_init(16);
	LDI  R26,LOW(16)
	RCALL _lcd_init
; 0000 00DF     lcd_gotoxy(2,0);
	LDI  R30,LOW(2)
	RCALL SUBOPT_0x26
; 0000 00E0     lcd_puts("NOISE LEVEL");
	__POINTW2MN _0xC5,0
	RCALL _lcd_puts
; 0000 00E1     lcd_gotoxy(5,1);
	LDI  R30,LOW(5)
	ST   -Y,R30
	RCALL SUBOPT_0x5
; 0000 00E2     lcd_puts("METER");
	__POINTW2MN _0xC5,12
	RCALL _lcd_puts
; 0000 00E3     delay_ms(700);
	LDI  R26,LOW(700)
	LDI  R27,HIGH(700)
	RCALL _delay_ms
; 0000 00E4     lcd_clear();
	RCALL _lcd_clear
; 0000 00E5     while (1)
_0xC6:
; 0000 00E6     {
; 0000 00E7       // Place your code here
; 0000 00E8       delay=luu_delay;
	MOVW R10,R12
; 0000 00E9       thongbao();                 //Thong bao ket noi voi may tinh
	RCALL _thongbao
; 0000 00EA       adc_convert(0);             //chuong trinh con chuyen doi ADC kenh 0, doc dB
	LDI  R26,LOW(0)
	RCALL _adc_convert
; 0000 00EB       lcd_gotoxy(0,1);
	RCALL SUBOPT_0x3
	RCALL SUBOPT_0x5
; 0000 00EC       mode_setting();             //chuong trinh con cai dat che do
	RCALL _mode_setting
; 0000 00ED 
; 0000 00EE       uart_db_tx(db_value);       //chuong trinh con truyen du lieu len may tinh
	RCALL SUBOPT_0x2B
	RCALL _uart_db_tx
; 0000 00EF       truyen_data=1;
	LDI  R30,LOW(1)
	STS  _truyen_data,R30
; 0000 00F0       delay_ms(100);
	LDI  R26,LOW(100)
	RCALL SUBOPT_0x2
; 0000 00F1       if (bien_mode==0)
	RCALL SUBOPT_0x21
	CPI  R30,0
	BRNE _0xC9
; 0000 00F2       delay_ms(delay);          //delay thoi gian lay mau
	MOVW R26,R10
	RCALL _delay_ms
; 0000 00F3     };
_0xC9:
	RJMP _0xC6
; 0000 00F4 }
_0xCA:
	RJMP _0xCA

	.DSEG
_0xC5:
	.BYTE 0x12
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G100:
	ST   -Y,R26
	LD   R30,Y
	ANDI R30,LOW(0x10)
	BREQ _0x2000004
	SBI  0x12,5
	RJMP _0x2000005
_0x2000004:
	CBI  0x12,5
_0x2000005:
	LD   R30,Y
	ANDI R30,LOW(0x20)
	BREQ _0x2000006
	SBI  0x12,6
	RJMP _0x2000007
_0x2000006:
	CBI  0x12,6
_0x2000007:
	LD   R30,Y
	ANDI R30,LOW(0x40)
	BREQ _0x2000008
	SBI  0x12,7
	RJMP _0x2000009
_0x2000008:
	CBI  0x12,7
_0x2000009:
	LD   R30,Y
	ANDI R30,LOW(0x80)
	BREQ _0x200000A
	SBI  0x18,0
	RJMP _0x200000B
_0x200000A:
	CBI  0x18,0
_0x200000B:
	__DELAY_USB 5
	SBI  0x12,4
	__DELAY_USB 13
	CBI  0x12,4
	__DELAY_USB 13
	RJMP _0x2080001
__lcd_write_data:
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
	__DELAY_USB 133
	RJMP _0x2080001
_lcd_gotoxy:
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G100)
	SBCI R31,HIGH(-__base_y_G100)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R30,Y+1
	STS  __lcd_x,R30
	LD   R30,Y
	STS  __lcd_y,R30
_0x2080003:
	ADIW R28,2
	RET
_lcd_clear:
	LDI  R26,LOW(2)
	RCALL __lcd_write_data
	LDI  R26,LOW(3)
	RCALL SUBOPT_0x2
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	RCALL __lcd_write_data
	LDI  R26,LOW(3)
	RCALL SUBOPT_0x2
	LDI  R30,LOW(0)
	STS  __lcd_y,R30
	STS  __lcd_x,R30
	RET
_lcd_putchar:
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2000011
	LDS  R30,__lcd_maxx
	LDS  R26,__lcd_x
	CP   R26,R30
	BRLO _0x2000010
_0x2000011:
	RCALL SUBOPT_0x3
	LDS  R26,__lcd_y
	SUBI R26,-LOW(1)
	STS  __lcd_y,R26
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2000013
	RJMP _0x2080001
_0x2000013:
_0x2000010:
	LDS  R30,__lcd_x
	SUBI R30,-LOW(1)
	STS  __lcd_x,R30
	SBI  0x12,2
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x12,2
	RJMP _0x2080001
_lcd_puts:
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2000014:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x2000016
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2000014
_0x2000016:
	LDD  R17,Y+0
_0x2080002:
	ADIW R28,3
	RET
_lcd_init:
	ST   -Y,R26
	SBI  0x11,5
	SBI  0x11,6
	SBI  0x11,7
	SBI  0x17,0
	SBI  0x11,4
	SBI  0x11,2
	SBI  0x11,3
	CBI  0x12,4
	CBI  0x12,2
	CBI  0x12,3
	LD   R30,Y
	STS  __lcd_maxx,R30
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G100,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G100,3
	LDI  R26,LOW(20)
	RCALL SUBOPT_0x2
	RCALL SUBOPT_0x33
	RCALL SUBOPT_0x33
	RCALL SUBOPT_0x33
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 200
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x2080001:
	ADIW R28,1
	RET
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG

	.CSEG

	.CSEG

	.DSEG
_adc_value:
	.BYTE 0x4
_db_value:
	.BYTE 0x4
_connect:
	.BYTE 0x1
_bien_mode:
	.BYTE 0x1
_ng:
	.BYTE 0x2
_tr:
	.BYTE 0x2
_ch:
	.BYTE 0x2
_dv:
	.BYTE 0x2
_Nghin:
	.BYTE 0x2
_Tram:
	.BYTE 0x2
_Chuc:
	.BYTE 0x2
_Donvi:
	.BYTE 0x2
_truyen_data:
	.BYTE 0x1
_truyen_delay:
	.BYTE 0x1
_rx_buffer:
	.BYTE 0x8
_rx_wr_index:
	.BYTE 0x1
_rx_counter:
	.BYTE 0x1
_tx_buffer:
	.BYTE 0x8
_tx_wr_index:
	.BYTE 0x1
_tx_rd_index:
	.BYTE 0x1
_tx_counter:
	.BYTE 0x1
__base_y_G100:
	.BYTE 0x4
__lcd_x:
	.BYTE 0x1
__lcd_y:
	.BYTE 0x1
__lcd_maxx:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x0:
	ST   -Y,R26
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	LDS  R30,_tx_counter
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2:
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x3:
	LDI  R30,LOW(0)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x4:
	LDI  R26,LOW(0)
	RJMP _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x5:
	LDI  R26,LOW(1)
	RJMP _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6:
	RCALL _delay_ms
	LDI  R30,LOW(32)
	MOV  R7,R30
	RJMP SUBOPT_0x3

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x7:
	ST   -Y,R27
	ST   -Y,R26
	LD   R26,Y
	LDD  R27,Y+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 42 TIMES, CODE SIZE REDUCTION:39 WORDS
SUBOPT_0x8:
	LD   R26,Y
	LDD  R27,Y+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 30 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x9:
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xA:
	LDD  R26,Y+2
	LDI  R30,LOW(2)
	MUL  R30,R26
	MOVW R30,R0
	RCALL SUBOPT_0x8
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xB:
	LDD  R26,Y+2
	LDI  R30,LOW(3)
	MUL  R30,R26
	MOVW R30,R0
	RCALL SUBOPT_0x8
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xC:
	LDD  R26,Y+2
	LDI  R30,LOW(4)
	MUL  R30,R26
	MOVW R30,R0
	RCALL SUBOPT_0x8
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xD:
	LDD  R26,Y+2
	LDI  R30,LOW(5)
	MUL  R30,R26
	MOVW R30,R0
	RCALL SUBOPT_0x8
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xE:
	LDD  R26,Y+2
	LDI  R30,LOW(6)
	MUL  R30,R26
	MOVW R30,R0
	RCALL SUBOPT_0x8
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xF:
	LDD  R26,Y+2
	LDI  R30,LOW(7)
	MUL  R30,R26
	MOVW R30,R0
	RCALL SUBOPT_0x8
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x10:
	LDD  R26,Y+2
	LDI  R30,LOW(8)
	MUL  R30,R26
	MOVW R30,R0
	RCALL SUBOPT_0x8
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x11:
	LDD  R26,Y+2
	LDI  R30,LOW(9)
	MUL  R30,R26
	MOVW R30,R0
	RCALL SUBOPT_0x8
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x12:
	LDD  R26,Y+2
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	RCALL SUBOPT_0x8
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x13:
	LDD  R26,Y+2
	LDI  R30,LOW(11)
	MUL  R30,R26
	MOVW R30,R0
	RCALL SUBOPT_0x8
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x14:
	LDD  R26,Y+2
	LDI  R30,LOW(12)
	MUL  R30,R26
	MOVW R30,R0
	RCALL SUBOPT_0x8
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x15:
	LDD  R26,Y+2
	LDI  R30,LOW(13)
	MUL  R30,R26
	MOVW R30,R0
	RCALL SUBOPT_0x8
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x16:
	LDD  R26,Y+2
	LDI  R30,LOW(14)
	MUL  R30,R26
	MOVW R30,R0
	RCALL SUBOPT_0x8
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x17:
	LDD  R26,Y+2
	LDI  R30,LOW(15)
	MUL  R30,R26
	MOVW R30,R0
	RCALL SUBOPT_0x8
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x18:
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x19:
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x18
	RCALL __MODW21U
	MOVW R26,R30
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	RCALL __DIVW21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1A:
	RCALL SUBOPT_0x8
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	RCALL __MODW21U
	MOVW R26,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RCALL __DIVW21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1B:
	RCALL SUBOPT_0x8
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RCALL __MODW21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1C:
	ST   -Y,R27
	ST   -Y,R26
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SBIW R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1D:
	LDI  R26,LOW(32)
	RJMP _lcd_putchar

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1E:
	LDD  R26,Y+4
	SUBI R26,-LOW(48)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1F:
	LDD  R26,Y+6
	SUBI R26,-LOW(48)
	RCALL _lcd_putchar
	RJMP SUBOPT_0x1E

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x20:
	LDD  R26,Y+2
	SUBI R26,-LOW(48)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x21:
	LDS  R30,_bien_mode
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x22:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x23:
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x24:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x25:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x26:
	ST   -Y,R30
	RJMP SUBOPT_0x4

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x27:
	STS  _adc_value,R30
	STS  _adc_value+1,R31
	STS  _adc_value+2,R22
	STS  _adc_value+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x28:
	LDS  R26,_adc_value
	LDS  R27,_adc_value+1
	LDS  R24,_adc_value+2
	LDS  R25,_adc_value+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x29:
	__GETD1N 0x2DA
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x2A:
	STS  _db_value,R30
	STS  _db_value+1,R31
	STS  _db_value+2,R22
	STS  _db_value+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2B:
	LDS  R26,_db_value
	LDS  R27,_db_value+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2C:
	RCALL SUBOPT_0x8
	CPI  R26,LOW(0x64)
	LDI  R30,HIGH(0x64)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2D:
	RCALL SUBOPT_0x8
	CPI  R26,LOW(0x3E8)
	LDI  R30,HIGH(0x3E8)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x2E:
	LDI  R26,0
	SBIC 0x16,1
	LDI  R26,1
	LDI  R30,0
	SBRC R2,1
	LDI  R30,1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2F:
	LDS  R26,_bien_mode
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x30:
	LDI  R26,0
	SBIC 0x16,2
	LDI  R26,1
	LDI  R30,0
	SBRC R2,0
	LDI  R30,1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x31:
	MOV  R30,R6
	SUBI R30,-LOW(64)
	STS  _truyen_delay,R30
	LDS  R26,_truyen_delay
	RJMP _putchar

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x32:
	LDI  R26,0
	SBIC 0x13,4
	LDI  R26,1
	LDI  R30,0
	SBRC R2,2
	LDI  R30,1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x33:
	LDI  R26,LOW(48)
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 200
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__SUBD12:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	SBC  R23,R25
	RET

__MULD12U:
	MUL  R23,R26
	MOV  R23,R0
	MUL  R22,R27
	ADD  R23,R0
	MUL  R31,R24
	ADD  R23,R0
	MUL  R30,R25
	ADD  R23,R0
	MUL  R22,R26
	MOV  R22,R0
	ADD  R23,R1
	MUL  R31,R27
	ADD  R22,R0
	ADC  R23,R1
	MUL  R30,R24
	ADD  R22,R0
	ADC  R23,R1
	CLR  R24
	MUL  R31,R26
	MOV  R31,R0
	ADD  R22,R1
	ADC  R23,R24
	MUL  R30,R27
	ADD  R31,R0
	ADC  R22,R1
	ADC  R23,R24
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	ADC  R22,R24
	ADC  R23,R24
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	CLR  R20
	CLR  R21
	LDI  R19,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R20
	ROL  R21
	SUB  R0,R30
	SBC  R1,R31
	SBC  R20,R22
	SBC  R21,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R20,R22
	ADC  R21,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R19
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOVW R24,R20
	POP  R21
	POP  R20
	POP  R19
	RET

__MODW21U:
	RCALL __DIVW21U
	MOVW R30,R26
	RET

;END OF CODE MARKER
__END_OF_CODE:
