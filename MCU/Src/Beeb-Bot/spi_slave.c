/************************************************************************
	spi_slave.c
    
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

#include "Beeb-Bot/spi_slave.h"
#include "Beeb-Bot/debug.h"
#include "Beeb-Bot/drv8825.h"
#include "spi.h"

static uint8_t _spiTxBuffer[5];
static uint8_t _spiRxBuffer[5];

#define SPISTATE_WAITING    0
#define SPISTATE_SENDING    1
volatile uint8_t _spiState = SPISTATE_WAITING;

// Define response codes
#define RESPONSE_OK 1
#define RESPONSE_ERROR 2

// Note:
//
// Communication is always 5 bytes from master followed by a reply
// of 5 bytes from the slave:
//
//  Mester sends:  [Command] [Parameter MSB] [Parameter] [Parameter] [Parameter LSB]
// Slave replies: [Response] [Parameter MSB] [Parameter] [Parameter] [Parameter LSB]
//
// Note that [Response] is 0 for ok, or non-zero if an error occurred (note that the
// non-zero response can be a detailed error code if supported by the command).
//
// In both the send and receive action the [Parameter] is a 32 bit number
//
// Command is 1 byte followed by a 32-bit integer (4 bytes)
// response is a 32-bit integer.
// 
// The integers are send and received even if not required
// by the command (in which case they will only be 0)

// Commands are:
// 0x0x = System commands
// 0x00 - Get version
// 0x01 - Get battery voltage level
//
// 0x1x = Left motor commands
// 0x10 - Set left motor direction
// 0x11 - Get left motor direction
// 0x12 - Set left motor SPS (speed)
// 0x13 - Get left motor SPS (speed)
// 0x14 - Set left motor steps
// 0x15 - Get left motor steps
//
// 0x2x = Right motor commands
// 0x20 - Set right motor direction
// 0x21 - Get right motor direction
// 0x22 - Set right motor SPS (speed)
// 0x23 - Get right motor SPS (speed)
// 0x24 - Set right motor steps
// 0x25 - Get right motor steps
//
// 0x30 - Get bumper state

// SPI command processing
void processSpiCommand()
{
    uint8_t inCommand;
    uint32_t inParameter;

    uint8_t outResponse = RESPONSE_ERROR;
    uint32_t outParameter = 0;

    // Split the Rx buffer into command and parameter
    inCommand = _spiRxBuffer[0];
    inParameter  = (uint32_t)(_spiRxBuffer[1] << 24);
    inParameter += (uint32_t)(_spiRxBuffer[2] << 16);
    inParameter += (uint32_t)(_spiRxBuffer[3] <<  8);
    inParameter += (uint32_t)(_spiRxBuffer[4]);

    // Clear the receive buffer
    for (uint16_t i = 0; i < 5; i++) _spiRxBuffer[i] = 0;

    switch(inCommand) {
        // System commands 0x0x -------------------------------------------------------------------
        case 0x00: // Get firmware version
            outResponse = RESPONSE_OK;
            outParameter = 1;
            break;

        case 0x01: // Get battery voltage level (in mV)
            outResponse = RESPONSE_OK;
            outParameter = 0;
            break;

        // Left motor commands --------------------------------------------------------------------
        case 0x10: // Set left motor direction
            // Do not allow change of direction if motor is active
            if (drv8825_getSteps(DRV8825_LEFT) == 0) {
                if (inParameter == 0) drv8825_setDirection(DRV8825_LEFT, DRV8825_FORWARD);
                else drv8825_setDirection(DRV8825_LEFT, DRV8825_REVERSE);
                outResponse = RESPONSE_OK;
                outParameter = 0;
            } else {
                outResponse = RESPONSE_ERROR; // Error
                outParameter = 0;
            }
            break;

        case 0x11: // Get left motor direction
            if (drv8825_getDirection(DRV8825_LEFT) == 0) outParameter = 0;
            else outParameter = 1;
            outResponse = RESPONSE_OK;
            break;

        case 0x12: // Set left motor SPS (speed)
            drv8825_setSpeed(DRV8825_LEFT, (uint16_t)inParameter);
            outResponse = RESPONSE_OK;
            outParameter = 0;
            break;

        case 0x13: // Get left motor SPS (speed)
            outParameter = drv8825_getSpeed(DRV8825_LEFT);
            outResponse = RESPONSE_OK;
            break;

        case 0x14: // Set left motor steps
            drv8825_setSteps(DRV8825_LEFT, inParameter);
            outResponse = RESPONSE_OK;
            outParameter = 0;
            break;

        case 0x15: // Get left motor steps
            outParameter = drv8825_getSteps(DRV8825_LEFT);
            outResponse = RESPONSE_OK;
            break;

        // Right motor commands --------------------------------------------------------------------
        case 0x20: // Set right motor direction
            // Do not allow change of direction if motor is active
            if (drv8825_getSteps(DRV8825_RIGHT) == 0) {
                if (inParameter == 0) drv8825_setDirection(DRV8825_RIGHT, DRV8825_FORWARD);
                else drv8825_setDirection(DRV8825_RIGHT, DRV8825_REVERSE);
                outResponse = RESPONSE_OK;
                outParameter = 0;
            } else {
                outResponse = RESPONSE_ERROR; // Error
                outParameter = 0;
            }
            break;

        case 0x21: // Get right motor direction
            if (drv8825_getDirection(DRV8825_RIGHT) == 0) outParameter = 0;
            else outParameter = 1;
            outResponse = RESPONSE_OK;
            break;

        case 0x22: // Set right motor SPS (speed)
            drv8825_setSpeed(DRV8825_RIGHT, (uint16_t)inParameter);
            outResponse = RESPONSE_OK;
            outParameter = 0;
            break;

        case 0x23: // Get right motor SPS (speed)
            outParameter = drv8825_getSpeed(DRV8825_RIGHT);
            outResponse = RESPONSE_OK;
            break;

        case 0x24: // Set right motor steps
            drv8825_setSteps(DRV8825_RIGHT, inParameter);
            outResponse = RESPONSE_OK;
            outParameter = 0;
            break;

        case 0x25: // Get right motor steps
            outParameter = drv8825_getSteps(DRV8825_RIGHT);
            outResponse = RESPONSE_OK;
            break;

        // Unknown command
        default:
            outResponse = RESPONSE_ERROR;
            outParameter = 0;
    }

    // Join the output response and parameter into the out buffer
    _spiTxBuffer[0] = outResponse;
    _spiTxBuffer[1] = (uint8_t)((outParameter & 0xFF000000UL) >> 24);
    _spiTxBuffer[2] = (uint8_t)((outParameter & 0x00FF0000UL) >> 16);
    _spiTxBuffer[3] = (uint8_t)((outParameter & 0x0000FF00UL) >> 8);
    _spiTxBuffer[4] = (uint8_t)((outParameter & 0x000000FFUL));
}

// SPI interrupt handlers ---------------------------------------------------------------------------------------------

void spi_initialise()
{
    // Initialise the buffers
    for (uint16_t i = 0; i < 5; i++) {
        _spiTxBuffer[i] = 0;
        _spiRxBuffer[i] = 0;
    }

    // Wait for 5 bytes of incoming data
    _spiState = SPISTATE_WAITING;
    HAL_SPI_TransmitReceive_IT(&hspi1, _spiTxBuffer, _spiRxBuffer, 5);
}

void spi_transmitReceiveCompleteCallback()
{
    if (_spiState == SPISTATE_WAITING) {
        // Process the received command
        processSpiCommand();
        // Send the response
        _spiState = SPISTATE_SENDING;
        HAL_SPI_TransmitReceive_IT(&hspi1, _spiTxBuffer, _spiRxBuffer, 5);
    } else {
        // Wait for the next command
        _spiState = SPISTATE_WAITING;

        // Clear the transmit buffer
        for (uint16_t i = 0; i < 5; i++) _spiTxBuffer[i] = 0;

        HAL_SPI_TransmitReceive_IT(&hspi1, _spiTxBuffer, _spiRxBuffer, 5);
    }
}
