/************************************************************************
	drv8825.c
    
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

#include "Beeb-Bot/drv8825.h"
#include "gpio.h"
#include "tim.h"
#include "Beeb-Bot/debug.h"

// Note: All timings are based on 1/8 microstepping
// so there are 8 * 200 = 1600 steps per revolution

void drv8825_leftTimerSetup()
{
    TIM_ClockConfigTypeDef sClockSourceConfig = {0};
    TIM_MasterConfigTypeDef sMasterConfig = {0};
    TIM_OC_InitTypeDef sConfigOC = {0};

    htim2.Instance = TIM2;
    htim2.Init.Prescaler = 180;
    htim2.Init.CounterMode = TIM_COUNTERMODE_UP;
    htim2.Init.Period = 1; //(+1 for PSC, so 1 is PSC=2) so 72000 / (180 * 2) = 200 KHz = 1,000,000 / 200,000 = 5uS
    htim2.Init.ClockDivision = TIM_CLOCKDIVISION_DIV1;
    htim2.Init.AutoReloadPreload = TIM_AUTORELOAD_PRELOAD_ENABLE;
    HAL_TIM_Base_Init(&htim2);
    
    sClockSourceConfig.ClockSource = TIM_CLOCKSOURCE_INTERNAL;
    HAL_TIM_ConfigClockSource(&htim2, &sClockSourceConfig);
    HAL_TIM_OC_Init(&htim2);
    
    sMasterConfig.MasterOutputTrigger = TIM_TRGO_RESET;
    sMasterConfig.MasterSlaveMode = TIM_MASTERSLAVEMODE_DISABLE;
    HAL_TIMEx_MasterConfigSynchronization(&htim2, &sMasterConfig);
    
    sConfigOC.OCMode = TIM_OCMODE_TIMING;
    sConfigOC.Pulse = 0;
    sConfigOC.OCPolarity = TIM_OCPOLARITY_HIGH;
    sConfigOC.OCFastMode = TIM_OCFAST_DISABLE;
    HAL_TIM_OC_ConfigChannel(&htim2, &sConfigOC, TIM_CHANNEL_1);
}

void drv8825_rightTimerSetup()
{
    TIM_ClockConfigTypeDef sClockSourceConfig = {0};
    TIM_MasterConfigTypeDef sMasterConfig = {0};
    TIM_OC_InitTypeDef sConfigOC = {0};

    htim3.Instance = TIM3;
    htim3.Init.Prescaler = 180;
    htim3.Init.CounterMode = TIM_COUNTERMODE_UP;
    htim3.Init.Period = 1; //(+1 for PSC, so 1 is PSC=2) so 72000 / (180 * 2) = 200 KHz = 1,000,000 / 200,000 = 5uS
    htim3.Init.ClockDivision = TIM_CLOCKDIVISION_DIV1;
    htim3.Init.AutoReloadPreload = TIM_AUTORELOAD_PRELOAD_ENABLE;
    HAL_TIM_Base_Init(&htim3);
    
    sClockSourceConfig.ClockSource = TIM_CLOCKSOURCE_INTERNAL;
    HAL_TIM_ConfigClockSource(&htim3, &sClockSourceConfig);
    HAL_TIM_OC_Init(&htim3);
    
    sMasterConfig.MasterOutputTrigger = TIM_TRGO_RESET;
    sMasterConfig.MasterSlaveMode = TIM_MASTERSLAVEMODE_DISABLE;
    HAL_TIMEx_MasterConfigSynchronization(&htim3, &sMasterConfig);
    
    sConfigOC.OCMode = TIM_OCMODE_TIMING;
    sConfigOC.Pulse = 0;
    sConfigOC.OCPolarity = TIM_OCPOLARITY_HIGH;
    sConfigOC.OCFastMode = TIM_OCFAST_DISABLE;
    HAL_TIM_OC_ConfigChannel(&htim3, &sConfigOC, TIM_CHANNEL_1);
}

void drv8825_rightMotorCallBack()
{
    drv8825_processMotor(DRV8825_RIGHT);
}

void drv8825_leftMotorCallBack()
{
    drv8825_processMotor(DRV8825_LEFT);
}

void drv8825_processMotor(uint16_t motor)
{
    if (_stepsRemaining[motor] > 0) {
        // Step the motor
        if (_motorSignal[motor] == 0) {
            if (motor == DRV8825_RIGHT) HAL_GPIO_WritePin(R_Step_GPIO_Port, R_Step_Pin, GPIO_PIN_RESET);
            else HAL_GPIO_WritePin(L_Step_GPIO_Port, L_Step_Pin, GPIO_PIN_RESET);
            _motorSignal[motor] = 1;
            _stepsRemaining[motor]--;

            // Call the interrupt again in 5uS (so the DRV8825 sees the step pulse)
            // 72000 / (180 * 2) = 200 KHz = 1,000,000 / 200,000 = 5uS
            if (motor == DRV8825_RIGHT) {
                TIM3->PSC = 180;
                TIM3->ARR = 2;
            } else {
                TIM2->PSC = 180;
                TIM2->ARR = 2;
            }
        } else {
            if (motor == DRV8825_RIGHT) HAL_GPIO_WritePin(R_Step_GPIO_Port, R_Step_Pin, GPIO_PIN_SET);
            else HAL_GPIO_WritePin(L_Step_GPIO_Port, L_Step_Pin, GPIO_PIN_SET);
            _motorSignal[motor] = 0;

            // Timer units are 2.5us, so 1000000 / 2.5 = 400000
            uint32_t period = 400000 / _sps[motor];

            // Call the interrupt again once the SPS period is complete
            if (motor == DRV8825_RIGHT) {
                TIM3->PSC = 180;
                TIM3->ARR = (uint16_t)period;
            } else {
                TIM2->PSC = 180;
                TIM2->ARR = (uint16_t)period;
            }
        }

        // Handle acceleration and deceleration 
        if (_stepsRemaining[motor] <= (_sps[motor] / 4)) {
            // Decelerating...
            _curveCounter[motor]++;

            if (_curveCounter[motor] > 10) {
                _curveCounter[motor] = 0;
                _sps[motor] -= 20;

                if (_sps[motor] < (DRV8825_MIN_SPS * 8)) _sps[motor] = DRV8825_MIN_SPS * 8;
            } else {
                _curveCounter[motor]++;
            }
        } else {
            // Accelerating?
            if (_targetSps[motor] > _sps[motor]) {
                _curveCounter[motor]++;

                if (_curveCounter[motor] > 10) {
                    _curveCounter[motor] = 0;
                    _sps[motor] += 20;

                    if (_sps[motor] > _targetSps[motor]) _sps[motor] = _targetSps[motor];
                } else {
                    _curveCounter[motor]++;
                }
            }
        }
    } else {
        // Motor is off - interrupt again later
        if (motor == DRV8825_RIGHT) {
            TIM3->PSC = 180;
            TIM3->ARR = 16000;
        } else {
            TIM2->PSC = 180;
            TIM2->ARR = 16000;
        }

        // Disable drivers if nothing is happening
        if (_stepsRemaining[DRV8825_LEFT] == 0 && _stepsRemaining[DRV8825_RIGHT] == 0)
            HAL_GPIO_WritePin(Step_EN_GPIO_Port, Step_EN_Pin, GPIO_PIN_SET);
    }
}

void drv8825_initialise()
{
    debug("Initalising DRV8825 boards...\r\n");
    drv8825_setStepMode(DRV8825_EIGHTH_STEP);
    drv8825_setDirection(DRV8825_LEFT, DRV8825_FORWARD);
    drv8825_setDirection(DRV8825_RIGHT, DRV8825_FORWARD);

    // Initialise the callback globals
    _motorSignal[DRV8825_LEFT] = 0;
    _motorSignal[DRV8825_RIGHT] = 0;
    _sps[DRV8825_LEFT] = DRV8825_MIN_SPS;
    _sps[DRV8825_RIGHT] = DRV8825_MIN_SPS;
    _curveCounter[DRV8825_LEFT] = 0;
    _curveCounter[DRV8825_RIGHT] = 0;

    // Configure the output pulse timers
    drv8825_leftTimerSetup();
    drv8825_rightTimerSetup();

    // Start the left and right timers in interrupt mode
    HAL_TIM_Base_Start_IT(&htim2);
    HAL_TIM_Base_Start_IT(&htim3);

    // Set the timer interrupt priorities to low (0 = lowest, 15=highest)
    HAL_NVIC_SetPriority(TIM2_IRQn, 0, 0);
    HAL_NVIC_SetPriority(TIM3_IRQn, 0, 0);

    // Enable the peripheral IRQs
    HAL_NVIC_EnableIRQ(TIM2_IRQn);
    HAL_NVIC_EnableIRQ(TIM3_IRQn);

    // Disable the 8825s (set EN to 0)
    // Note: The drivers are disabled when the motors are not in use.  This disables
    // holding torque, but saves lots of power.
    HAL_GPIO_WritePin(Step_EN_GPIO_Port, Step_EN_Pin, GPIO_PIN_SET);
}

void drv8825_setDirection(uint16_t motor, uint16_t direction)
{
    if (motor == DRV8825_LEFT) {
        if (direction == DRV8825_FORWARD) HAL_GPIO_WritePin(L_Dir_GPIO_Port, L_Dir_Pin, GPIO_PIN_SET);
        else HAL_GPIO_WritePin(L_Dir_GPIO_Port, L_Dir_Pin, GPIO_PIN_RESET);
    } else {
        if (direction == DRV8825_FORWARD) HAL_GPIO_WritePin(R_Dir_GPIO_Port, R_Dir_Pin, GPIO_PIN_RESET);
        else HAL_GPIO_WritePin(R_Dir_GPIO_Port, R_Dir_Pin, GPIO_PIN_SET);
    }
}

void drv8825_setSpeed(uint16_t motor, uint16_t motorSps)
{
    // Range check against maximum SPS
    if (motorSps > DRV8825_MAX_SPS) motorSps = DRV8825_MAX_SPS;

    _targetSps[motor] = motorSps;
    _curveCounter[motor] = 0;

    // Set the initial SPS to minimum
    _sps[motor] = DRV8825_MIN_SPS;
}

void drv8825_setStepMode(uint16_t stepMode)
{
    switch(stepMode) {
        case DRV8825_FULL_STEP:
            HAL_GPIO_WritePin(Step_M0_GPIO_Port, Step_M0_Pin, GPIO_PIN_RESET);
            HAL_GPIO_WritePin(Step_M1_GPIO_Port, Step_M1_Pin, GPIO_PIN_RESET);
            HAL_GPIO_WritePin(Step_M2_GPIO_Port, Step_M2_Pin, GPIO_PIN_RESET);
            break;
        case DRV8825_HALF_STEP:
            HAL_GPIO_WritePin(Step_M0_GPIO_Port, Step_M0_Pin, GPIO_PIN_SET);
            HAL_GPIO_WritePin(Step_M1_GPIO_Port, Step_M1_Pin, GPIO_PIN_RESET);
            HAL_GPIO_WritePin(Step_M2_GPIO_Port, Step_M2_Pin, GPIO_PIN_RESET);
            break;
        case DRV8825_QUARTER_STEP:
            HAL_GPIO_WritePin(Step_M0_GPIO_Port, Step_M0_Pin, GPIO_PIN_RESET);
            HAL_GPIO_WritePin(Step_M1_GPIO_Port, Step_M1_Pin, GPIO_PIN_SET);
            HAL_GPIO_WritePin(Step_M2_GPIO_Port, Step_M2_Pin, GPIO_PIN_RESET);
            break;
        case DRV8825_EIGHTH_STEP:
            HAL_GPIO_WritePin(Step_M0_GPIO_Port, Step_M0_Pin, GPIO_PIN_SET);
            HAL_GPIO_WritePin(Step_M1_GPIO_Port, Step_M1_Pin, GPIO_PIN_SET);
            HAL_GPIO_WritePin(Step_M2_GPIO_Port, Step_M2_Pin, GPIO_PIN_RESET);
            break;
        case DRV8825_SIXTEENTH_STEP:
            HAL_GPIO_WritePin(Step_M0_GPIO_Port, Step_M0_Pin, GPIO_PIN_RESET);
            HAL_GPIO_WritePin(Step_M1_GPIO_Port, Step_M1_Pin, GPIO_PIN_RESET);
            HAL_GPIO_WritePin(Step_M2_GPIO_Port, Step_M2_Pin, GPIO_PIN_SET);
            break;
        case DRV8825_THIRTYSECOND_STEP:
            HAL_GPIO_WritePin(Step_M0_GPIO_Port, Step_M0_Pin, GPIO_PIN_RESET);
            HAL_GPIO_WritePin(Step_M1_GPIO_Port, Step_M1_Pin, GPIO_PIN_SET);
            HAL_GPIO_WritePin(Step_M2_GPIO_Port, Step_M2_Pin, GPIO_PIN_SET);
            break;
        default:
            HAL_GPIO_WritePin(Step_M0_GPIO_Port, Step_M0_Pin, GPIO_PIN_RESET);
            HAL_GPIO_WritePin(Step_M1_GPIO_Port, Step_M1_Pin, GPIO_PIN_RESET);
            HAL_GPIO_WritePin(Step_M2_GPIO_Port, Step_M2_Pin, GPIO_PIN_RESET);
    }
}

// Move a motor the specified number of steps
void drv8825_move(uint16_t motor, uint32_t steps)
{
    // Enable the motors
    HAL_GPIO_WritePin(Step_EN_GPIO_Port, Step_EN_Pin, GPIO_PIN_RESET);

    _stepsRemaining[motor] += steps;
    _curveCounter[motor] = 0;
    _sps[motor] = DRV8825_MIN_SPS;
}

// Check if motor is moving: Returns >0 if motor is active
uint32_t drv8825_isMotorMoving(uint16_t motor)
{
    return _stepsRemaining[motor];
}