/************************************************************************
	beeb-bot-mcu.c
    
	Beeb-Bot MCU
    Copyright (C) 2020 Simon Inns
    
    This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
	
    Email: simon.inns@gmail.com
    
************************************************************************/

#include "Beeb-Bot/beeb-bot-mcu.h"
#include "Beeb-Bot/debug.h"
#include "Beeb-Bot/drv8825.h"
#include "Beeb-Bot/led.h"
#include "Beeb-Bot/i2c_slave.h"

#include "gpio.h"
#include "tim.h"

// Beeb-Bot MCU initialisation
void initialise()
{
    // Note: No USART available here for debug
}

// Timer period elapsed call-back handler
void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htimx)
{
    // Call a callback handler based on the timer number
    if (htimx->Instance == TIM2) drv8825_leftMotorCallBack();
    if (htimx->Instance == TIM3) drv8825_rightMotorCallBack();
    if (htimx->Instance == TIM4) led_timerCallBack();
}

// Main Beeb-Bot MCU main process
// Note: This function should never exit
void process()
{
    // Show initialisation messages on debug
    debug("\r\n\r\nBeeb-Bot MCU - (c)2020 Simon Inns\r\n");
    debug("https://www.waitingforfriday.com\r\n");
    debug("GPLv3 Open-Source\r\n\r\n");

    // Initialise the I2C locations
    i2c_initialiseRam();

    // Initialise DRV8825 driver
    drv8825_initialise();
    drv8825_setStepMode(DRV8825_EIGHTH_STEP);

    // Turn on the User LED
    led_turnOn();

    // Show ready state
    debug("Beeb-Bot MCU Ready\r\n");
    
    drv8825_setSpeed(DRV8825_LEFT, 6000);
    drv8825_setSpeed(DRV8825_RIGHT, 6000);
    while (1)
    {
        // drv8825_setDirection(DRV8825_RIGHT, DRV8825_FORWARD);
        // drv8825_setDirection(DRV8825_LEFT, DRV8825_FORWARD);
        // drv8825_move(DRV8825_RIGHT, 1600 * 4); // 4 revolutions
        // drv8825_move(DRV8825_LEFT, 1600 * 4); // 4 revolutions
        // while((drv8825_isMotorMoving(DRV8825_RIGHT) > 0) && (drv8825_isMotorMoving(DRV8825_LEFT) > 0)); // Wait for completion
        // HAL_Delay(3000);

        // drv8825_setDirection(DRV8825_RIGHT, DRV8825_REVERSE);
        // drv8825_setDirection(DRV8825_LEFT, DRV8825_REVERSE);
        // drv8825_move(DRV8825_RIGHT, 1600 * 4); // 4 revolutions
        // drv8825_move(DRV8825_LEFT, 1600 * 4); // 4 revolutions
        // while((drv8825_isMotorMoving(DRV8825_RIGHT) > 0) && (drv8825_isMotorMoving(DRV8825_LEFT) > 0)); // Wait for completion
        // HAL_Delay(3000);
    }
}