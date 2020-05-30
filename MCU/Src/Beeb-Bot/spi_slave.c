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

uint8_t _spiBuffer[5];

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
// 0x01 - Get battery level
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
    char debugString[80] = "";

    uint8_t inCommand;
    uint32_t inParameter;

    uint8_t outResponse = 1;
    uint32_t outParameter = 0;

    // Split the in buffer into command and parameter
    inCommand = _spiBuffer[0];
    inParameter  = (uint32_t)(_spiBuffer[1] << 24);
    inParameter += (uint32_t)(_spiBuffer[2] << 16);
    inParameter += (uint32_t)(_spiBuffer[3] <<  8);
    inParameter += (uint32_t)(_spiBuffer[4]);

    sprintf(debugString, "SPI in: %u %u %u %u %u\r\n", _spiBuffer[0], _spiBuffer[1], _spiBuffer[2], _spiBuffer[3], _spiBuffer[4]);
    debug(debugString);

    sprintf(debugString, "SPI in: Command %u with parameter %lu received\r\n", inCommand, inParameter);
    debug(debugString);

    switch(inCommand) {
        // System commands 0x0x -------------------------------------------------------------------
        case 0x00: // Get version
            outResponse = 0x02; // ok
            outParameter = 0x03040506;
            break;

        case 0x01: // Get battery level
            outResponse = 0;
            outParameter = 0;
            break;

        // Left motor commands --------------------------------------------------------------------
        case 0x10: // Set left motor direction
            if (inParameter == 0) drv8825_setDirection(DRV8825_LEFT, DRV8825_FORWARD);
            else drv8825_setDirection(DRV8825_LEFT, DRV8825_REVERSE);
            outResponse = 0;
            outParameter = 0;
            break;

        case 0x11: // Get left motor direction
            if (drv8825_getDirection(DRV8825_LEFT) == 0) outParameter = 0;
            else outParameter = 1;
            outResponse = 0;
            break;

        case 0x12: // Set left motor SPS (speed)
            drv8825_setSpeed(DRV8825_LEFT, (uint16_t)inParameter);
            outResponse = 0;
            outParameter = 0;
            break;

        case 0x13: // Get left motor SPS (speed)
            outParameter = drv8825_getSpeed(DRV8825_LEFT);
            outResponse = 0;
            break;

        case 0x14: // Set left motor steps
            drv8825_setSteps(DRV8825_LEFT, inParameter);
            outResponse = 0;
            outParameter = 0;
            break;

        case 0x15: // Get left motor steps
            outParameter = drv8825_getSteps(DRV8825_LEFT);
            outResponse = 0;
            break;

        // Right motor commands --------------------------------------------------------------------
        case 0x20: // Set right motor direction
            if (inParameter == 0) drv8825_setDirection(DRV8825_RIGHT, DRV8825_FORWARD);
            else drv8825_setDirection(DRV8825_RIGHT, DRV8825_REVERSE);
            outResponse = 0;
            outParameter = 0;
            break;

        case 0x21: // Get right motor direction
            if (drv8825_getDirection(DRV8825_RIGHT) == 0) outParameter = 0;
            else outParameter = 1;
            outResponse = 0;
            break;

        case 0x22: // Set right motor SPS (speed)
            drv8825_setSpeed(DRV8825_RIGHT, (uint16_t)inParameter);
            outResponse = 0;
            outParameter = 0;
            break;

        case 0x23: // Get right motor SPS (speed)
            outParameter = drv8825_getSpeed(DRV8825_RIGHT);
            outResponse = 0;
            break;

        case 0x24: // Set right motor steps
            drv8825_setSteps(DRV8825_RIGHT, inParameter);
            outResponse = 0;
            outParameter = 0;
            break;

        case 0x25: // Get right motor steps
            outParameter = drv8825_getSteps(DRV8825_RIGHT);
            outResponse = 0;
            break;

        // Unknown command
        default:
            outResponse = 0x01;
            outParameter = 0x02020202;
    }

    // Join the output response and parameter into the out buffer
    _spiBuffer[0] = outResponse;
    _spiBuffer[1] = (uint8_t)((outParameter & 0xFF000000UL) >> 24);
    _spiBuffer[2] = (uint8_t)((outParameter & 0x00FF0000UL) >> 16);
    _spiBuffer[3] = (uint8_t)((outParameter & 0x0000FF00UL) >> 8);
    _spiBuffer[4] = (uint8_t)((outParameter & 0x000000FFUL));

    sprintf(debugString, "SPI out: %u %u %u %u %u\r\n", _spiBuffer[0], _spiBuffer[1], _spiBuffer[2], _spiBuffer[3], _spiBuffer[4]);
    debug(debugString);

    sprintf(debugString, "SPI out: Response %u with parameter %lu\r\n", outResponse, outParameter);
    debug(debugString);
}

// SPI interrupt handlers ---------------------------------------------------------------------------------------------

void spi_initialise()
{
    // Initialise the buffer
    _spiBuffer[0] = 0;
    _spiBuffer[1] = 0;
    _spiBuffer[2] = 0;
    _spiBuffer[3] = 0;
    _spiBuffer[4] = 0;

    // Enable the HAL SPI receive interrupt so
    // Wait for 5 bytes of incoming data
    HAL_SPI_Receive_IT(&hspi1, _spiBuffer, 5);
}

void spi_receiveCompleteCallback()
{
    // Process the received command
    processSpiCommand();

    // Send the response
    HAL_SPI_Transmit_IT(&hspi1, _spiBuffer, 5);
}

void spi_transmitCompleteCallback()
{
    // Rearm the reception
    HAL_SPI_Receive_IT(&hspi1, _spiBuffer, 5);
}