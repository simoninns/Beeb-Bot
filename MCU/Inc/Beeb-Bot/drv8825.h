/************************************************************************
	drv8825.h
    
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

#ifndef __DRV8825_H
#define __DRV8825_H

#include "stm32f1xx_hal.h"

// Globals for motor handling 
volatile uint8_t _motorSignal[2];
volatile uint32_t _sps[2];
volatile uint32_t _stepsRemaining[2];
volatile uint32_t _targetSps[2];
volatile uint32_t _curveCounter[2];
volatile uint32_t _motorDirection[2];

// Definitions
#define DRV8825_FULL_STEP           0
#define DRV8825_HALF_STEP           1
#define DRV8825_QUARTER_STEP        2
#define DRV8825_EIGHTH_STEP         3
#define DRV8825_SIXTEENTH_STEP      4
#define DRV8825_THIRTYSECOND_STEP   5

#define DRV8825_FORWARD 0
#define DRV8825_REVERSE 1

#define DRV8825_LEFT    0
#define DRV8825_RIGHT   1

// There are 1600 steps per revolution at 1/8 microstep
// So 16000 is 16000 / 1600 = 10 RPS (600 RPM)
// And 100 / 1600 = 0.0625 RPS (3.75 RPM)
#define DRV8825_MAX_SPS 16000
#define DRV8825_MIN_SPS 100

// Function prototypes
void drv8825_leftTimerSetup();
void drv8825_rightTimerSetup();
void drv8825_leftMotorCallBack();
void drv8825_rightMotorCallBack();
void drv8825_processMotor(uint16_t motor);
void drv8825_initialise();
void drv8825_setStepMode(uint16_t stepMode);

void drv8825_setDirection(uint16_t motor, uint16_t direction);
uint32_t drv8825_getDirection(uint16_t motor);

void drv8825_setSpeed(uint16_t motor, uint16_t motorSps);
uint32_t drv8825_getSpeed(uint16_t motor);

void drv8825_setSteps(uint16_t motor, uint32_t steps);
uint32_t drv8825_getSteps(uint16_t motor);

#endif