EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 4
Title "Beeb-Bot MCU Board"
Date "2020-05-24"
Rev "1_0"
Comp "https://www.waitingforfriday.com"
Comment1 "(c)2020 Simon Inns"
Comment2 "License: Attribution-ShareAlike 4.0 (CC BY-SA 4.0)"
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L YAAJ_STM32:BluePill_1 BP??
U 1 1 5EC60101
P 4250 2950
F 0 "BP??" H 4825 3125 50  0000 C CNN
F 1 "BluePill_1" H 4825 3034 50  0000 C CNN
F 2 "" H 5500 1000 50  0001 C CNN
F 3 "" H 5500 1000 50  0001 C CNN
	1    4250 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 3100 5750 3100
Wire Wire Line
	5750 3100 5750 5150
Wire Wire Line
	5600 3000 5750 3000
Wire Wire Line
	5750 3000 5750 3100
Connection ~ 5750 3100
Wire Wire Line
	4050 4800 3800 4800
Wire Wire Line
	3800 4800 3800 5150
Wire Wire Line
	3800 5150 5750 5150
Wire Wire Line
	5600 3200 5850 3200
Wire Wire Line
	5850 3200 5850 2800
Wire Wire Line
	4050 4900 3900 4900
Wire Wire Line
	3900 4900 3900 5050
Wire Wire Line
	3900 5050 5850 5050
Wire Wire Line
	5850 5050 5850 3200
Connection ~ 5850 3200
Wire Wire Line
	5750 5150 5750 5250
Connection ~ 5750 5150
$Comp
L power:+3V3 #PWR?
U 1 1 5EC694DE
P 5850 2800
F 0 "#PWR?" H 5850 2650 50  0001 C CNN
F 1 "+3V3" H 5865 2973 50  0000 C CNN
F 2 "" H 5850 2800 50  0001 C CNN
F 3 "" H 5850 2800 50  0001 C CNN
	1    5850 2800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EC696F7
P 5750 5250
F 0 "#PWR?" H 5750 5000 50  0001 C CNN
F 1 "GND" H 5755 5077 50  0000 C CNN
F 2 "" H 5750 5250 50  0001 C CNN
F 3 "" H 5750 5250 50  0001 C CNN
	1    5750 5250
	1    0    0    -1  
$EndComp
NoConn ~ 4050 4700
Wire Wire Line
	5600 4200 6050 4200
Wire Wire Line
	5600 4300 6050 4300
NoConn ~ 5600 4800
Text GLabel 3850 3900 0    50   Output ~ 0
L_Step
Text GLabel 3850 4000 0    50   Output ~ 0
L_Dir
Text GLabel 6050 3900 2    50   Output ~ 0
R_Step
Text GLabel 6050 4000 2    50   Output ~ 0
R_Dir
Text GLabel 3850 3200 0    50   Output ~ 0
Step_M0
Text GLabel 3850 3100 0    50   Output ~ 0
Step_M1
Text GLabel 3850 3000 0    50   Output ~ 0
Step_M2
Wire Wire Line
	3850 3200 4050 3200
Wire Wire Line
	5600 4500 6050 4500
Wire Wire Line
	5600 4400 6050 4400
Text GLabel 6050 4500 2    50   Input ~ 0
ADC0
Text GLabel 6050 4400 2    50   Input ~ 0
ADC1
Wire Wire Line
	3850 3100 4050 3100
Wire Wire Line
	3850 3000 4050 3000
Wire Wire Line
	5600 3900 6050 3900
Wire Wire Line
	5600 4000 6050 4000
Wire Wire Line
	3850 3900 4050 3900
Wire Wire Line
	3850 4000 4050 4000
$Sheet
S 10200 750  800  950 
U 5ECA12E7
F0 "Motor Drivers" 50
F1 "motor_drivers.sch" 50
F2 "L_Step" I L 10200 850 50 
F3 "L_Dir" I L 10200 950 50 
F4 "Step_M0" I L 10200 1300 50 
F5 "Step_M1" I L 10200 1400 50 
F6 "Step_M2" I L 10200 1500 50 
F7 "R_Step" I L 10200 1050 50 
F8 "R_Dir" I L 10200 1150 50 
F9 "Step_EN" I L 10200 1600 50 
$EndSheet
Text GLabel 9950 850  0    50   Input ~ 0
L_Step
Text GLabel 9950 950  0    50   Input ~ 0
L_Dir
Text GLabel 9950 1050 0    50   Input ~ 0
R_Step
Text GLabel 9950 1150 0    50   Input ~ 0
R_Dir
Text GLabel 9950 1500 0    50   Input ~ 0
Step_M2
Text GLabel 9950 1400 0    50   Input ~ 0
Step_M1
Text GLabel 9950 1300 0    50   Input ~ 0
Step_M0
Wire Wire Line
	9950 850  10200 850 
Wire Wire Line
	9950 950  10200 950 
Wire Wire Line
	9950 1050 10200 1050
Wire Wire Line
	9950 1150 10200 1150
Wire Wire Line
	9950 1300 10200 1300
Wire Wire Line
	9950 1400 10200 1400
Wire Wire Line
	9950 1500 10200 1500
$Sheet
S 10200 2350 800  700 
U 5ECD6582
F0 "Raspberry_Pi" 50
F1 "raspberry_pi.sch" 50
F2 "Serial_TxD" O L 10200 2450 50 
F3 "Serial_RxD" I L 10200 2550 50 
F4 "I2C_SDA" B L 10200 2700 50 
F5 "I2C_SCL" O L 10200 2800 50 
F6 "Interrupt" I L 10200 2950 50 
$EndSheet
Text GLabel 3850 4300 0    50   Input ~ 0
SCL1
Text GLabel 3850 4400 0    50   BiDi ~ 0
SDA1
Wire Wire Line
	3850 4300 4050 4300
Wire Wire Line
	3850 4400 4050 4400
Text GLabel 9950 2800 0    50   Input ~ 0
SCL1
Text GLabel 9950 2700 0    50   BiDi ~ 0
SDA1
Wire Wire Line
	9950 2700 10200 2700
Wire Wire Line
	9950 2800 10200 2800
$Sheet
S 10200 3400 800  700 
U 5ECED89D
F0 "Power Supply" 50
F1 "power_supply.sch" 50
F2 "Battery_Sense" O L 10200 3500 50 
$EndSheet
Text GLabel 9950 3500 0    50   Input ~ 0
ADC1
Wire Wire Line
	9950 3500 10200 3500
Text GLabel 6050 4200 2    50   Input ~ 0
RxD_Master
Text GLabel 6050 4300 2    50   Output ~ 0
TxD_Master
Text GLabel 9950 2450 0    50   Input ~ 0
RxD_Master
Text GLabel 9950 2550 0    50   Output ~ 0
TxD_Master
Wire Wire Line
	9950 2450 10200 2450
Wire Wire Line
	10200 2550 9950 2550
NoConn ~ 5600 4900
NoConn ~ 4050 3700
NoConn ~ 4050 3800
Text GLabel 3850 3300 0    50   Output ~ 0
Step_EN
Wire Wire Line
	3850 3300 4050 3300
Text GLabel 9950 1600 0    50   Input ~ 0
Step_EN
Wire Wire Line
	9950 1600 10200 1600
Text GLabel 9950 2950 0    50   Input ~ 0
Interrupt0
Wire Wire Line
	9950 2950 10200 2950
$Comp
L power:+3V3 #PWR?
U 1 1 5ED1B9C2
P 5850 2100
F 0 "#PWR?" H 5850 1950 50  0001 C CNN
F 1 "+3V3" H 5865 2273 50  0000 C CNN
F 2 "" H 5850 2100 50  0001 C CNN
F 3 "" H 5850 2100 50  0001 C CNN
	1    5850 2100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5ED1BFC4
P 6450 2400
F 0 "#PWR?" H 6450 2150 50  0001 C CNN
F 1 "GND" H 6455 2227 50  0000 C CNN
F 2 "" H 6450 2400 50  0001 C CNN
F 3 "" H 6450 2400 50  0001 C CNN
	1    6450 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	5850 2100 5850 2400
Wire Wire Line
	5850 2400 6350 2400
Wire Wire Line
	6350 2400 6350 2250
Wire Wire Line
	6450 2250 6450 2400
Wire Wire Line
	6550 2250 6550 3400
Wire Wire Line
	6550 3400 5600 3400
Wire Wire Line
	6650 2250 6650 3500
Wire Wire Line
	6650 3500 5600 3500
Wire Wire Line
	6750 2250 6750 3600
Wire Wire Line
	6750 3600 5600 3600
Text Notes 6650 1950 1    50   ~ 0
I2C2_SCL
Text Notes 6550 1950 1    50   ~ 0
I2C2_SDA
Text Notes 6750 1950 1    50   ~ 0
Interrupt1
Text GLabel 6050 3800 2    50   Output ~ 0
Interrupt0
Wire Wire Line
	5600 4100 6050 4100
$Comp
L Connector_Generic:Conn_01x01 J?
U 1 1 5ED22968
P 7250 3300
F 0 "J?" H 7330 3342 50  0000 L CNN
F 1 "NRST" H 7330 3251 50  0000 L CNN
F 2 "" H 7250 3300 50  0001 C CNN
F 3 "~" H 7250 3300 50  0001 C CNN
	1    7250 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 3300 7050 3300
$Comp
L Connector_Generic:Conn_01x06 J?
U 1 1 5ED249F1
P 6450 2050
F 0 "J?" V 6414 1662 50  0000 R CNN
F 1 "Exp_Header0" V 6323 1662 50  0000 R CNN
F 2 "" H 6450 2050 50  0001 C CNN
F 3 "~" H 6450 2050 50  0001 C CNN
	1    6450 2050
	0    -1   -1   0   
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 5ED2D388
P 6100 2100
F 0 "#PWR?" H 6100 1950 50  0001 C CNN
F 1 "+5V" H 6115 2273 50  0000 C CNN
F 2 "" H 6100 2100 50  0001 C CNN
F 3 "" H 6100 2100 50  0001 C CNN
	1    6100 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	6100 2100 6100 2300
Wire Wire Line
	6100 2300 6250 2300
Wire Wire Line
	6250 2300 6250 2250
$Comp
L Connector_Generic:Conn_01x02 J?
U 1 1 5ED30269
P 7800 4600
F 0 "J?" H 7880 4592 50  0000 L CNN
F 1 "Bumper_L" H 7880 4501 50  0000 L CNN
F 2 "" H 7800 4600 50  0001 C CNN
F 3 "~" H 7800 4600 50  0001 C CNN
	1    7800 4600
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J?
U 1 1 5ED3065E
P 7800 4900
F 0 "J?" H 7880 4892 50  0000 L CNN
F 1 "Bumper_R" H 7880 4801 50  0000 L CNN
F 2 "" H 7800 4900 50  0001 C CNN
F 3 "~" H 7800 4900 50  0001 C CNN
	1    7800 4900
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 4600 7600 4600
Wire Wire Line
	7600 4900 6500 4900
Wire Wire Line
	6500 4900 6500 4700
Wire Wire Line
	5600 4700 6500 4700
Wire Wire Line
	7600 4700 7500 4700
Wire Wire Line
	7500 4700 7500 5000
Wire Wire Line
	7600 5000 7500 5000
Connection ~ 7500 5000
Wire Wire Line
	7500 5000 7500 5200
$Comp
L power:GND #PWR?
U 1 1 5ED362CC
P 7500 5200
F 0 "#PWR?" H 7500 4950 50  0001 C CNN
F 1 "GND" H 7505 5027 50  0000 C CNN
F 2 "" H 7500 5200 50  0001 C CNN
F 3 "" H 7500 5200 50  0001 C CNN
	1    7500 5200
	1    0    0    -1  
$EndComp
Text GLabel 6050 4100 2    50   Input ~ 0
ADC4
Text Notes 9600 6050 0    50   ~ 0
Notes:\nLDR\nBarcode\nPen U/D\nTilt\n+2 additional digital channels
Wire Wire Line
	5600 3800 6050 3800
$EndSCHEMATC
