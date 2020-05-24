EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 4
Title "Beeb-Bot MCU Board - Power Supply"
Date "2020-05-24"
Rev "1_0"
Comp "https://www.waitingforfriday.com"
Comment1 "(c)2020 Simon Inns"
Comment2 "License: Attribution-ShareAlike 4.0 (CC BY-SA 4.0)"
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Regulator_Linear:LM1117-5.0 U?
U 1 1 5ECA24EF
P 5900 4650
F 0 "U?" H 5900 4892 50  0000 C CNN
F 1 "LM1117-5.0" H 5900 4801 50  0000 C CNN
F 2 "" H 5900 4650 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm1117.pdf" H 5900 4650 50  0001 C CNN
	1    5900 4650
	1    0    0    -1  
$EndComp
$Comp
L Regulator_Linear:LM1117-3.3 U?
U 1 1 5ECA2921
P 8550 4650
F 0 "U?" H 8550 4892 50  0000 C CNN
F 1 "LM1117-3.3" H 8550 4801 50  0000 C CNN
F 2 "" H 8550 4650 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm1117.pdf" H 8550 4650 50  0001 C CNN
	1    8550 4650
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C?
U 1 1 5ECA3DA0
P 5300 4950
F 0 "C?" H 5418 4996 50  0000 L CNN
F 1 "10uf Tant" H 5418 4905 50  0000 L CNN
F 2 "" H 5338 4800 50  0001 C CNN
F 3 "~" H 5300 4950 50  0001 C CNN
	1    5300 4950
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C?
U 1 1 5ECA45E6
P 6500 4950
F 0 "C?" H 6618 4996 50  0000 L CNN
F 1 "10uf Tant" H 6618 4905 50  0000 L CNN
F 2 "" H 6538 4800 50  0001 C CNN
F 3 "~" H 6500 4950 50  0001 C CNN
	1    6500 4950
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C?
U 1 1 5ECA49DF
P 7900 4950
F 0 "C?" H 8018 4996 50  0000 L CNN
F 1 "10uf Tant" H 8018 4905 50  0000 L CNN
F 2 "" H 7938 4800 50  0001 C CNN
F 3 "~" H 7900 4950 50  0001 C CNN
	1    7900 4950
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C?
U 1 1 5ECA4E25
P 9200 4950
F 0 "C?" H 9318 4996 50  0000 L CNN
F 1 "10uf Tant" H 9318 4905 50  0000 L CNN
F 2 "" H 9238 4800 50  0001 C CNN
F 3 "~" H 9200 4950 50  0001 C CNN
	1    9200 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 4800 5300 4650
Wire Wire Line
	5300 4650 5600 4650
Wire Wire Line
	6200 4650 6500 4650
Wire Wire Line
	6500 4650 6500 4800
Wire Wire Line
	5300 5100 5300 5200
Wire Wire Line
	5300 5200 5900 5200
Wire Wire Line
	6500 5200 6500 5100
Wire Wire Line
	5900 4950 5900 5200
Connection ~ 5900 5200
Wire Wire Line
	5900 5200 6500 5200
Wire Wire Line
	7900 4800 7900 4650
Wire Wire Line
	7900 4650 8250 4650
Wire Wire Line
	8850 4650 9200 4650
Wire Wire Line
	9200 4650 9200 4800
Wire Wire Line
	7900 5100 7900 5200
Wire Wire Line
	7900 5200 8550 5200
Wire Wire Line
	9200 5200 9200 5100
Wire Wire Line
	8550 4950 8550 5200
Connection ~ 8550 5200
Wire Wire Line
	8550 5200 9200 5200
$Comp
L power:GND #PWR?
U 1 1 5ECA6DFC
P 8550 5300
F 0 "#PWR?" H 8550 5050 50  0001 C CNN
F 1 "GND" H 8555 5127 50  0000 C CNN
F 2 "" H 8550 5300 50  0001 C CNN
F 3 "" H 8550 5300 50  0001 C CNN
	1    8550 5300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5ECA6ED6
P 5900 5300
F 0 "#PWR?" H 5900 5050 50  0001 C CNN
F 1 "GND" H 5905 5127 50  0000 C CNN
F 2 "" H 5900 5300 50  0001 C CNN
F 3 "" H 5900 5300 50  0001 C CNN
	1    5900 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5900 5200 5900 5300
Wire Wire Line
	8550 5200 8550 5300
$Comp
L Connector_Generic:Conn_01x02 J?
U 1 1 5ECA785C
P 7250 2150
F 0 "J?" V 7214 1962 50  0000 R CNN
F 1 "12V Battery In" V 7123 1962 50  0000 R CNN
F 2 "" H 7250 2150 50  0001 C CNN
F 3 "~" H 7250 2150 50  0001 C CNN
	1    7250 2150
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5ECA82D1
P 7350 2600
F 0 "#PWR?" H 7350 2350 50  0001 C CNN
F 1 "GND" H 7355 2427 50  0000 C CNN
F 2 "" H 7350 2600 50  0001 C CNN
F 3 "" H 7350 2600 50  0001 C CNN
	1    7350 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	7350 2600 7350 2350
Wire Wire Line
	7250 2350 7250 2600
Wire Wire Line
	5300 4300 5300 4650
Connection ~ 5300 4650
Connection ~ 7900 4650
$Comp
L power:PWR_FLAG #FLG?
U 1 1 5ECA9349
P 6900 2450
F 0 "#FLG?" H 6900 2525 50  0001 C CNN
F 1 "PWR_FLAG" H 6900 2623 50  0000 C CNN
F 2 "" H 6900 2450 50  0001 C CNN
F 3 "~" H 6900 2450 50  0001 C CNN
	1    6900 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6900 2450 6900 2600
Wire Wire Line
	6900 2600 7250 2600
Connection ~ 7250 2600
$Comp
L power:+5V #PWR?
U 1 1 5ECA9BF1
P 6500 4100
F 0 "#PWR?" H 6500 3950 50  0001 C CNN
F 1 "+5V" H 6515 4273 50  0000 C CNN
F 2 "" H 6500 4100 50  0001 C CNN
F 3 "" H 6500 4100 50  0001 C CNN
	1    6500 4100
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 5ECA9FF5
P 9200 4100
F 0 "#PWR?" H 9200 3950 50  0001 C CNN
F 1 "+3V3" H 9215 4273 50  0000 C CNN
F 2 "" H 9200 4100 50  0001 C CNN
F 3 "" H 9200 4100 50  0001 C CNN
	1    9200 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 4100 6500 4650
Connection ~ 6500 4650
Wire Wire Line
	9200 4650 9200 4100
Connection ~ 9200 4650
Text Notes 6950 1950 0    50   ~ 0
Battery is 12x 1.2V AA\nNMHi 2200mAh pack
Text Notes 6800 5450 0    50   ~ 0
5V supply @ 800mA\n3V3 supply @ 800mA
$Comp
L Device:R R?
U 1 1 5ECB3128
P 4200 4650
F 0 "R?" H 4270 4696 50  0000 L CNN
F 1 "100R" H 4270 4605 50  0000 L CNN
F 2 "" V 4130 4650 50  0001 C CNN
F 3 "~" H 4200 4650 50  0001 C CNN
	1    4200 4650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5ECB361C
P 4200 5150
F 0 "R?" H 4270 5196 50  0000 L CNN
F 1 "390R" H 4270 5105 50  0000 L CNN
F 2 "" V 4130 5150 50  0001 C CNN
F 3 "~" H 4200 5150 50  0001 C CNN
	1    4200 5150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5ECB3963
P 4200 5450
F 0 "#PWR?" H 4200 5200 50  0001 C CNN
F 1 "GND" H 4205 5277 50  0000 C CNN
F 2 "" H 4200 5450 50  0001 C CNN
F 3 "" H 4200 5450 50  0001 C CNN
	1    4200 5450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 4300 4200 4300
Wire Wire Line
	4200 4300 4200 4500
Wire Wire Line
	4200 4800 4200 4900
Wire Wire Line
	4200 5300 4200 5450
Wire Wire Line
	4200 4900 3500 4900
Connection ~ 4200 4900
Wire Wire Line
	4200 4900 4200 5000
Text HLabel 3500 4900 0    50   Output ~ 0
Battery_Sense
Text Notes 1750 5450 0    50   ~ 0
Sense = 12V * (100)/(100 + 390) = 2.45V\n\nNote: At 15V this supplies 3V - just in case someone uses\nstandard 1.5V cells rather than the required 1.2V cells...\n
$Comp
L Switch:SW_SPDT SW?
U 1 1 5ECC6347
P 7600 3250
F 0 "SW?" H 7600 3535 50  0000 C CNN
F 1 "Power" H 7600 3444 50  0000 C CNN
F 2 "" H 7600 3250 50  0001 C CNN
F 3 "~" H 7600 3250 50  0001 C CNN
	1    7600 3250
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_SPDT SW?
U 1 1 5ECC6E9F
P 8550 3250
F 0 "SW?" H 8550 3535 50  0000 C CNN
F 1 "Motors" H 8550 3444 50  0000 C CNN
F 2 "" H 8550 3250 50  0001 C CNN
F 3 "~" H 8550 3250 50  0001 C CNN
	1    8550 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	7250 3250 7400 3250
Wire Wire Line
	7250 2600 7250 3250
Wire Wire Line
	7800 3350 7900 3350
Wire Wire Line
	8200 3350 8200 3250
Wire Wire Line
	8200 3250 8350 3250
Wire Wire Line
	7900 3350 7900 4300
Connection ~ 7900 3350
Wire Wire Line
	7900 3350 8200 3350
Wire Wire Line
	5300 4300 7900 4300
Connection ~ 5300 4300
Connection ~ 7900 4300
Wire Wire Line
	7900 4300 7900 4650
Wire Wire Line
	8750 3350 9150 3350
Wire Wire Line
	9150 3350 9150 3100
$Comp
L power:+12V #PWR?
U 1 1 5ECCE46B
P 9150 3100
F 0 "#PWR?" H 9150 2950 50  0001 C CNN
F 1 "+12V" H 9165 3273 50  0000 C CNN
F 2 "" H 9150 3100 50  0001 C CNN
F 3 "" H 9150 3100 50  0001 C CNN
	1    9150 3100
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D?
U 1 1 5ECCED30
P 4550 2250
F 0 "D?" H 4543 1995 50  0000 C CNN
F 1 "Motor_LED" H 4543 2086 50  0000 C CNN
F 2 "" H 4550 2250 50  0001 C CNN
F 3 "~" H 4550 2250 50  0001 C CNN
	1    4550 2250
	-1   0    0    1   
$EndComp
$Comp
L Device:LED D?
U 1 1 5ECCF375
P 4550 2650
F 0 "D?" H 4543 2395 50  0000 C CNN
F 1 "5V_LED" H 4543 2486 50  0000 C CNN
F 2 "" H 4550 2650 50  0001 C CNN
F 3 "~" H 4550 2650 50  0001 C CNN
	1    4550 2650
	-1   0    0    1   
$EndComp
$Comp
L Device:LED D?
U 1 1 5ECCF8F7
P 4550 3050
F 0 "D?" H 4543 2795 50  0000 C CNN
F 1 "3V3_LED" H 4543 2886 50  0000 C CNN
F 2 "" H 4550 3050 50  0001 C CNN
F 3 "~" H 4550 3050 50  0001 C CNN
	1    4550 3050
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5ECCFC0E
P 4950 3300
F 0 "#PWR?" H 4950 3050 50  0001 C CNN
F 1 "GND" H 4955 3127 50  0000 C CNN
F 2 "" H 4950 3300 50  0001 C CNN
F 3 "" H 4950 3300 50  0001 C CNN
	1    4950 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	4700 2250 4950 2250
Wire Wire Line
	4950 2250 4950 2650
Wire Wire Line
	4700 3050 4950 3050
Connection ~ 4950 3050
Wire Wire Line
	4950 3050 4950 3300
Wire Wire Line
	4700 2650 4950 2650
Connection ~ 4950 2650
Wire Wire Line
	4950 2650 4950 3050
$Comp
L power:+12V #PWR?
U 1 1 5ECDA38D
P 3300 2050
F 0 "#PWR?" H 3300 1900 50  0001 C CNN
F 1 "+12V" H 3315 2223 50  0000 C CNN
F 2 "" H 3300 2050 50  0001 C CNN
F 3 "" H 3300 2050 50  0001 C CNN
	1    3300 2050
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 5ECDA8E7
P 2950 2050
F 0 "#PWR?" H 2950 1900 50  0001 C CNN
F 1 "+5V" H 2965 2223 50  0000 C CNN
F 2 "" H 2950 2050 50  0001 C CNN
F 3 "" H 2950 2050 50  0001 C CNN
	1    2950 2050
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 5ECDAF1A
P 2600 2050
F 0 "#PWR?" H 2600 1900 50  0001 C CNN
F 1 "+3V3" H 2615 2223 50  0000 C CNN
F 2 "" H 2600 2050 50  0001 C CNN
F 3 "" H 2600 2050 50  0001 C CNN
	1    2600 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	3300 2250 3300 2050
Wire Wire Line
	2950 2650 2950 2050
Wire Wire Line
	2600 3050 2600 2050
$Comp
L Device:R R?
U 1 1 5ECE665C
P 4050 2250
F 0 "R?" V 3843 2250 50  0000 C CNN
F 1 "560R" V 3934 2250 50  0000 C CNN
F 2 "" V 3980 2250 50  0001 C CNN
F 3 "~" H 4050 2250 50  0001 C CNN
	1    4050 2250
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5ECE6A7B
P 4050 2650
F 0 "R?" V 3843 2650 50  0000 C CNN
F 1 "180R" V 3934 2650 50  0000 C CNN
F 2 "" V 3980 2650 50  0001 C CNN
F 3 "~" H 4050 2650 50  0001 C CNN
	1    4050 2650
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5ECE6E15
P 4050 3050
F 0 "R?" V 3843 3050 50  0000 C CNN
F 1 "82R" V 3934 3050 50  0000 C CNN
F 2 "" V 3980 3050 50  0001 C CNN
F 3 "~" H 4050 3050 50  0001 C CNN
	1    4050 3050
	0    1    1    0   
$EndComp
Wire Wire Line
	3300 2250 3900 2250
Wire Wire Line
	2950 2650 3900 2650
Wire Wire Line
	2600 3050 3900 3050
Wire Wire Line
	4200 2250 4400 2250
Wire Wire Line
	4200 2650 4400 2650
Wire Wire Line
	4200 3050 4400 3050
$EndSCHEMATC
