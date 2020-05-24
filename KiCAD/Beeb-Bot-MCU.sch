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
P 4950 2800
F 0 "BP??" H 5525 2975 50  0000 C CNN
F 1 "BluePill_1" H 5525 2884 50  0000 C CNN
F 2 "" H 6200 850 50  0001 C CNN
F 3 "" H 6200 850 50  0001 C CNN
	1    4950 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	6300 2950 6450 2950
Wire Wire Line
	6450 2950 6450 5000
Wire Wire Line
	6300 2850 6450 2850
Wire Wire Line
	6450 2850 6450 2950
Connection ~ 6450 2950
Wire Wire Line
	4750 4650 4500 4650
Wire Wire Line
	4500 4650 4500 5000
Wire Wire Line
	4500 5000 6450 5000
Wire Wire Line
	6300 3050 6550 3050
Wire Wire Line
	6550 3050 6550 2650
Wire Wire Line
	4750 4750 4600 4750
Wire Wire Line
	4600 4750 4600 4900
Wire Wire Line
	4600 4900 6550 4900
Wire Wire Line
	6550 4900 6550 3050
Connection ~ 6550 3050
Wire Wire Line
	6450 5000 6450 5100
Connection ~ 6450 5000
$Comp
L power:+3V3 #PWR?
U 1 1 5EC694DE
P 6550 2650
F 0 "#PWR?" H 6550 2500 50  0001 C CNN
F 1 "+3V3" H 6565 2823 50  0000 C CNN
F 2 "" H 6550 2650 50  0001 C CNN
F 3 "" H 6550 2650 50  0001 C CNN
	1    6550 2650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EC696F7
P 6450 5100
F 0 "#PWR?" H 6450 4850 50  0001 C CNN
F 1 "GND" H 6455 4927 50  0000 C CNN
F 2 "" H 6450 5100 50  0001 C CNN
F 3 "" H 6450 5100 50  0001 C CNN
	1    6450 5100
	1    0    0    -1  
$EndComp
NoConn ~ 4750 4550
Wire Wire Line
	6300 4050 6750 4050
Wire Wire Line
	6300 4150 6750 4150
NoConn ~ 6300 4650
NoConn ~ 6300 3150
Text GLabel 4550 3750 0    50   Output ~ 0
L_Step
Text GLabel 4550 3850 0    50   Output ~ 0
L_Dir
Text GLabel 6750 3750 2    50   Output ~ 0
R_Step
Text GLabel 6750 3850 2    50   Output ~ 0
R_Dir
Text GLabel 4550 3050 0    50   Output ~ 0
Step_M0
Text GLabel 4550 2950 0    50   Output ~ 0
Step_M1
Text GLabel 4550 2850 0    50   Output ~ 0
Step_M2
Wire Wire Line
	4550 3050 4750 3050
Wire Wire Line
	6300 4450 6750 4450
Wire Wire Line
	6300 4550 6750 4550
Text GLabel 6750 4450 2    50   Input ~ 0
L_Bumper
Text GLabel 6750 4550 2    50   Input ~ 0
R_Bumper
Wire Wire Line
	6300 4350 6750 4350
Wire Wire Line
	6300 4250 6750 4250
Text GLabel 6750 4350 2    50   Input ~ 0
ADC0
Text GLabel 6750 4250 2    50   Input ~ 0
ADC1
Wire Wire Line
	4550 2950 4750 2950
Wire Wire Line
	4550 2850 4750 2850
Wire Wire Line
	6300 3750 6750 3750
Wire Wire Line
	6300 3850 6750 3850
Wire Wire Line
	4550 3750 4750 3750
Wire Wire Line
	4550 3850 4750 3850
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
S 10200 2350 800  550 
U 5ECD6582
F0 "Raspberry_Pi" 50
F1 "raspberry_pi.sch" 50
F2 "Serial_TxD" O L 10200 2450 50 
F3 "Serial_RxD" I L 10200 2550 50 
F4 "I2C_SDA" B L 10200 2700 50 
F5 "I2C_SCL" O L 10200 2800 50 
$EndSheet
Text GLabel 4550 4150 0    50   Input ~ 0
SCL1
Text GLabel 4550 4250 0    50   BiDi ~ 0
SDA1
Wire Wire Line
	4550 4150 4750 4150
Wire Wire Line
	4550 4250 4750 4250
Text GLabel 9950 2800 0    50   Input ~ 0
SCL1
Text GLabel 9950 2700 0    50   BiDi ~ 0
SDA1
Wire Wire Line
	9950 2700 10200 2700
Wire Wire Line
	9950 2800 10200 2800
$Sheet
S 10200 3250 800  700 
U 5ECED89D
F0 "Power Supply" 50
F1 "power_supply.sch" 50
F2 "Battery_Sense" O L 10200 3350 50 
$EndSheet
Text GLabel 9950 3350 0    50   Input ~ 0
ADC0
Wire Wire Line
	9950 3350 10200 3350
Text GLabel 6750 4050 2    50   Input ~ 0
RxD_Master
Text GLabel 6750 4150 2    50   Output ~ 0
TxD_Master
Text GLabel 9950 2450 0    50   Input ~ 0
RxD_Master
Text GLabel 9950 2550 0    50   Output ~ 0
TxD_Master
Wire Wire Line
	9950 2450 10200 2450
Wire Wire Line
	10200 2550 9950 2550
NoConn ~ 6300 4750
NoConn ~ 4750 3550
NoConn ~ 4750 3650
Text GLabel 4550 3150 0    50   Output ~ 0
Step_EN
Wire Wire Line
	4550 3150 4750 3150
Text GLabel 9950 1600 0    50   Input ~ 0
Step_EN
Wire Wire Line
	9950 1600 10200 1600
$EndSCHEMATC
