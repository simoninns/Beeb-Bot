/************************************************************************
	led.h
    
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

#include "Beeb-Bot/led.h"
#include "tim.h"
#include "gpio.h"

// Process call back from the timer
void led_timerCallBack()
{
    // Toggle the User LED state
    HAL_GPIO_TogglePin(User_LED_GPIO_Port, User_LED_Pin);
}

// Set up TIMer4 with 1KHz clock and 0.25 second period
void led_configureTimer4()
{
    TIM_ClockConfigTypeDef sClockSourceConfig = {0};
    TIM_MasterConfigTypeDef sMasterConfig = {0};

    htim4.Instance = TIM4;
    htim4.Init.Prescaler = 63999;
    htim4.Init.CounterMode = TIM_COUNTERMODE_UP;
    htim4.Init.Period = 250;
    htim4.Init.ClockDivision = TIM_CLOCKDIVISION_DIV1;
    htim4.Init.AutoReloadPreload = TIM_AUTORELOAD_PRELOAD_DISABLE;
    HAL_TIM_Base_Init(&htim4);

    sClockSourceConfig.ClockSource = TIM_CLOCKSOURCE_INTERNAL;
    HAL_TIM_ConfigClockSource(&htim2, &sClockSourceConfig);

    sMasterConfig.MasterOutputTrigger = TIM_TRGO_RESET;
    sMasterConfig.MasterSlaveMode = TIM_MASTERSLAVEMODE_DISABLE;
    HAL_TIMEx_MasterConfigSynchronization(&htim2, &sMasterConfig);
}

// Turn the flashing LED on
void led_turnOn()
{
    led_configureTimer4();

    // Start the TIM4 timer in interrupt mode
    HAL_TIM_Base_Start_IT(&htim4);

    // Set the interrupt's priority to low (0 = lowest, 15=highest)
    HAL_NVIC_SetPriority(TIM4_IRQn, 0, 0);

    // Enable the peripheral IRQ
    HAL_NVIC_EnableIRQ(TIM4_IRQn);
}

// Turn the LED off
void led_turnOff()
{
    // Disable timer4 interrupts
    HAL_NVIC_DisableIRQ(TIM4_IRQn);
    HAL_TIM_Base_Stop_IT(&htim4);
}