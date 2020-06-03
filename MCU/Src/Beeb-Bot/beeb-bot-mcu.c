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
#include "Beeb-Bot/spi_slave.h"

#include "gpio.h"
#include "tim.h"

// Top level HAL call back handlers -----------------------------------------------------------------------------------

// Timer period elapsed call-back handler
void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htimx)
{
    // Call a callback handler based on the timer number
    if (htimx->Instance == TIM2) drv8825_leftMotorCallBack();
    if (htimx->Instance == TIM3) drv8825_rightMotorCallBack();
    if (htimx->Instance == TIM4) led_timerCallBack();
}

// SPI call-back handlers
void HAL_SPI_TxRxCpltCallback(SPI_HandleTypeDef *hspix)
{
    if (hspix->Instance == SPI1) spi_transmitReceiveCompleteCallback();
}

// Functions ----------------------------------------------------------------------------------------------------------

// Beeb-Bot MCU initialisation
void initialise()
{
    // Note: No USART available here for debug
}

// Main Beeb-Bot MCU main process
// Note: This function should never exit
void process()
{
    // Show initialisation messages on debug
    debug("\r\n\r\nBeeb-Bot MCU - (c)2020 Simon Inns\r\n");
    debug("https://www.waitingforfriday.com\r\n");
    debug("GPLv3 Open-Source\r\n\r\n");

    // Initialise the SPI slave interface
    debug("Initalising SPI slave interface...\r\n");
    spi_initialise();

    // Initialise DRV8825 driver
    debug("Initalising DRV8825 driver...\r\n");
    drv8825_initialise();
    drv8825_setStepMode(DRV8825_EIGHTH_STEP);
    drv8825_setSpeed(DRV8825_LEFT, 6000);
    drv8825_setSpeed(DRV8825_RIGHT, 6000);

    // Turn on the User LED
    debug("Initalising LED driver...\r\n");
    led_turnOn();

    // Show ready state
    debug("Beeb-Bot MCU Ready\r\n\r\n");
    
    while (1)
    {
        // Nothing to do here...
    }
}