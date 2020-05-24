EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 4
Title "Beeb-Bot MCU Board - Raspberry PI"
Date "2020-05-24"
Rev "1_0"
Comp "https://www.waitingforfriday.com"
Comment1 "(c)2020 Simon Inns"
Comment2 "License: Attribution-ShareAlike 4.0 (CC BY-SA 4.0)"
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector:Raspberry_Pi_2_3 J?
U 1 1 5ECD6B5C
P 6000 4050
F 0 "J?" H 6000 5531 50  0000 C CNN
F 1 "Raspberry_Pi_2_3" H 6000 5440 50  0000 C CNN
F 2 "" H 6000 4050 50  0001 C CNN
F 3 "https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/rpi_SCH_3bplus_1p0_reduced.pdf" H 6000 4050 50  0001 C CNN
	1    6000 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 5350 5600 5450
Wire Wire Line
	5600 5450 5700 5450
Wire Wire Line
	6300 5450 6300 5350
Wire Wire Line
	5950 5550 5950 5450
Connection ~ 5950 5450
Wire Wire Line
	5950 5450 6000 5450
Wire Wire Line
	5700 5350 5700 5450
Connection ~ 5700 5450
Wire Wire Line
	5700 5450 5800 5450
Wire Wire Line
	5800 5350 5800 5450
Connection ~ 5800 5450
Wire Wire Line
	5800 5450 5900 5450
Wire Wire Line
	5900 5450 5900 5350
Connection ~ 5900 5450
Wire Wire Line
	5900 5450 5950 5450
Wire Wire Line
	6000 5350 6000 5450
Connection ~ 6000 5450
Wire Wire Line
	6000 5450 6100 5450
Wire Wire Line
	6100 5350 6100 5450
Connection ~ 6100 5450
Wire Wire Line
	6100 5450 6200 5450
Wire Wire Line
	6200 5350 6200 5450
Connection ~ 6200 5450
Wire Wire Line
	6200 5450 6300 5450
$Comp
L power:GND #PWR?
U 1 1 5ECD98AF
P 5950 5550
F 0 "#PWR?" H 5950 5300 50  0001 C CNN
F 1 "GND" H 5955 5377 50  0000 C CNN
F 2 "" H 5950 5550 50  0001 C CNN
F 3 "" H 5950 5550 50  0001 C CNN
	1    5950 5550
	1    0    0    -1  
$EndComp
NoConn ~ 6100 2750
NoConn ~ 6200 2750
Wire Wire Line
	5800 2750 5800 2350
Wire Wire Line
	5800 2350 5900 2350
Wire Wire Line
	5900 2350 5900 2750
Wire Wire Line
	5800 2350 5800 2250
Connection ~ 5800 2350
$Comp
L power:+5V #PWR?
U 1 1 5ECDDA07
P 5800 2250
F 0 "#PWR?" H 5800 2100 50  0001 C CNN
F 1 "+5V" H 5815 2423 50  0000 C CNN
F 2 "" H 5800 2250 50  0001 C CNN
F 3 "" H 5800 2250 50  0001 C CNN
	1    5800 2250
	1    0    0    -1  
$EndComp
Text HLabel 4950 3150 0    50   Output ~ 0
Serial_TxD
Text HLabel 4950 3250 0    50   Input ~ 0
Serial_RxD
Wire Wire Line
	4950 3150 5200 3150
Wire Wire Line
	4950 3250 5200 3250
Text HLabel 7050 3450 2    50   BiDi ~ 0
I2C_SDA
Text HLabel 7050 3550 2    50   Output ~ 0
I2C_SCL
Wire Wire Line
	6800 3450 7050 3450
Wire Wire Line
	6800 3550 7050 3550
$EndSCHEMATC
