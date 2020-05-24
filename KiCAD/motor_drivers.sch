EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 4
Title "Beeb-Bot MCU Board - Motor Drivers"
Date "2020-05-24"
Rev "1_0"
Comp "https://www.waitingforfriday.com"
Comment1 "(c)2020 Simon Inns"
Comment2 "License: Attribution-ShareAlike 4.0 (CC BY-SA 4.0)"
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Driver_Motor:Pololu_Breakout_DRV8825 A?
U 1 1 5ECAEAF1
P 5950 2750
F 0 "A?" H 5950 3531 50  0000 C CNN
F 1 "Pololu_Breakout_DRV8825" H 5950 3440 50  0000 C CNN
F 2 "Module:Pololu_Breakout-16_15.2x20.3mm" H 6150 1950 50  0001 L CNN
F 3 "https://www.pololu.com/product/2982" H 6050 2450 50  0001 C CNN
	1    5950 2750
	1    0    0    -1  
$EndComp
$Comp
L Driver_Motor:Pololu_Breakout_DRV8825 A?
U 1 1 5ECAEAF7
P 5950 5000
F 0 "A?" H 5950 5781 50  0000 C CNN
F 1 "Pololu_Breakout_DRV8825" H 5950 5690 50  0000 C CNN
F 2 "Module:Pololu_Breakout-16_15.2x20.3mm" H 6150 4200 50  0001 L CNN
F 3 "https://www.pololu.com/product/2982" H 6050 4700 50  0001 C CNN
	1    5950 5000
	1    0    0    -1  
$EndComp
$Comp
L power:+12V #PWR?
U 1 1 5ECAEAFD
P 5950 1850
F 0 "#PWR?" H 5950 1700 50  0001 C CNN
F 1 "+12V" H 5965 2023 50  0000 C CNN
F 2 "" H 5950 1850 50  0001 C CNN
F 3 "" H 5950 1850 50  0001 C CNN
	1    5950 1850
	1    0    0    -1  
$EndComp
$Comp
L power:+12V #PWR?
U 1 1 5ECAEB03
P 5950 4100
F 0 "#PWR?" H 5950 3950 50  0001 C CNN
F 1 "+12V" H 5965 4273 50  0000 C CNN
F 2 "" H 5950 4100 50  0001 C CNN
F 3 "" H 5950 4100 50  0001 C CNN
	1    5950 4100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5ECAEB09
P 5950 3650
F 0 "#PWR?" H 5950 3400 50  0001 C CNN
F 1 "GND" H 5955 3477 50  0000 C CNN
F 2 "" H 5950 3650 50  0001 C CNN
F 3 "" H 5950 3650 50  0001 C CNN
	1    5950 3650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5ECAEB0F
P 5950 5900
F 0 "#PWR?" H 5950 5650 50  0001 C CNN
F 1 "GND" H 5955 5727 50  0000 C CNN
F 2 "" H 5950 5900 50  0001 C CNN
F 3 "" H 5950 5900 50  0001 C CNN
	1    5950 5900
	1    0    0    -1  
$EndComp
Wire Wire Line
	5950 2150 5950 1900
Wire Wire Line
	5950 4400 5950 4150
Wire Wire Line
	5950 3550 5950 3600
Wire Wire Line
	6050 3550 6050 3600
Wire Wire Line
	6050 3600 5950 3600
Connection ~ 5950 3600
Wire Wire Line
	5950 3600 5950 3650
Wire Wire Line
	5950 5800 5950 5850
Wire Wire Line
	6050 5800 6050 5850
Wire Wire Line
	6050 5850 5950 5850
Connection ~ 5950 5850
Wire Wire Line
	5950 5850 5950 5900
Wire Wire Line
	5550 5600 5400 5600
Wire Wire Line
	5400 5600 5400 3350
Wire Wire Line
	5400 3350 5550 3350
Wire Wire Line
	5550 5500 5300 5500
Wire Wire Line
	5300 5500 5300 3250
Wire Wire Line
	5300 3250 5550 3250
Wire Wire Line
	5550 5400 5200 5400
Wire Wire Line
	5200 5400 5200 3150
Wire Wire Line
	5200 3150 5550 3150
Wire Wire Line
	5550 4700 5100 4700
Wire Wire Line
	5100 4700 5100 2550
Wire Wire Line
	5100 2450 5550 2450
Wire Wire Line
	5550 4800 5100 4800
Wire Wire Line
	5100 4800 5100 4700
Connection ~ 5100 4700
Wire Wire Line
	5550 2550 5100 2550
Connection ~ 5100 2550
Wire Wire Line
	5100 2550 5100 2450
Wire Wire Line
	5100 2450 5100 1900
Connection ~ 5100 2450
$Comp
L power:+3V3 #PWR?
U 1 1 5ECAEB35
P 5100 1900
F 0 "#PWR?" H 5100 1750 50  0001 C CNN
F 1 "+3V3" H 5115 2073 50  0000 C CNN
F 2 "" H 5100 1900 50  0001 C CNN
F 3 "" H 5100 1900 50  0001 C CNN
	1    5100 1900
	1    0    0    -1  
$EndComp
NoConn ~ 5550 2350
NoConn ~ 5550 4600
Wire Wire Line
	5550 5100 5000 5100
Wire Wire Line
	5550 5200 5000 5200
Wire Wire Line
	5550 2950 5000 2950
Wire Wire Line
	5550 2850 5000 2850
Wire Wire Line
	5200 3150 5000 3150
Connection ~ 5200 3150
Wire Wire Line
	5300 3250 5000 3250
Connection ~ 5300 3250
Wire Wire Line
	5400 3350 5000 3350
Connection ~ 5400 3350
$Comp
L Connector_Generic:Conn_01x04 J?
U 1 1 5ECAEB50
P 7250 2750
F 0 "J?" H 7330 2742 50  0000 L CNN
F 1 "MOTOR_L" H 7330 2651 50  0000 L CNN
F 2 "" H 7250 2750 50  0001 C CNN
F 3 "~" H 7250 2750 50  0001 C CNN
	1    7250 2750
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x04 J?
U 1 1 5ECAEB56
P 7250 5000
F 0 "J?" H 7330 4992 50  0000 L CNN
F 1 "MOTOR_R" H 7330 4901 50  0000 L CNN
F 2 "" H 7250 5000 50  0001 C CNN
F 3 "~" H 7250 5000 50  0001 C CNN
	1    7250 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6350 2650 7050 2650
Wire Wire Line
	6350 2750 7050 2750
Wire Wire Line
	6350 2950 6450 2950
Wire Wire Line
	6450 2950 6450 2850
Wire Wire Line
	6450 2850 7050 2850
Wire Wire Line
	6350 3050 6550 3050
Wire Wire Line
	6550 3050 6550 2950
Wire Wire Line
	6550 2950 7050 2950
Wire Wire Line
	6350 4900 7050 4900
Wire Wire Line
	6350 5000 7050 5000
Wire Wire Line
	6350 5200 6450 5200
Wire Wire Line
	6450 5200 6450 5100
Wire Wire Line
	6450 5100 7050 5100
Wire Wire Line
	6350 5300 6550 5300
Wire Wire Line
	6550 5300 6550 5200
Wire Wire Line
	6550 5200 7050 5200
$Comp
L Device:CP C?
U 1 1 5ECAEB6C
P 6750 2150
F 0 "C?" H 6868 2196 50  0000 L CNN
F 1 "100uF" H 6868 2105 50  0000 L CNN
F 2 "" H 6788 2000 50  0001 C CNN
F 3 "~" H 6750 2150 50  0001 C CNN
	1    6750 2150
	1    0    0    -1  
$EndComp
Wire Wire Line
	6050 3600 6750 3600
Wire Wire Line
	6750 3600 6750 2300
Connection ~ 6050 3600
Wire Wire Line
	6750 2000 6750 1900
Wire Wire Line
	6750 1900 5950 1900
Connection ~ 5950 1900
Wire Wire Line
	5950 1900 5950 1850
$Comp
L Device:CP C?
U 1 1 5ECAEB79
P 6750 4400
F 0 "C?" H 6868 4446 50  0000 L CNN
F 1 "100uF" H 6868 4355 50  0000 L CNN
F 2 "" H 6788 4250 50  0001 C CNN
F 3 "~" H 6750 4400 50  0001 C CNN
	1    6750 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	6750 4250 6750 4150
Wire Wire Line
	6750 4150 5950 4150
Connection ~ 5950 4150
Wire Wire Line
	5950 4150 5950 4100
Wire Wire Line
	6750 4550 6750 5850
Wire Wire Line
	6750 5850 6050 5850
Connection ~ 6050 5850
Text HLabel 5000 2850 0    50   Input ~ 0
L_Step
Text HLabel 5000 2950 0    50   Input ~ 0
L_Dir
Text HLabel 5000 3150 0    50   Input ~ 0
Step_M0
Text HLabel 5000 3250 0    50   Input ~ 0
Step_M1
Text HLabel 5000 3350 0    50   Input ~ 0
Step_M2
Text HLabel 5000 5100 0    50   Input ~ 0
R_Step
Text HLabel 5000 5200 0    50   Input ~ 0
R_Dir
Wire Wire Line
	5550 5000 5500 5000
Wire Wire Line
	5500 5000 5500 2750
Wire Wire Line
	5500 2750 5550 2750
Wire Wire Line
	5500 2750 5000 2750
Connection ~ 5500 2750
Text HLabel 5000 2750 0    50   Input ~ 0
Step_EN
$EndSCHEMATC
