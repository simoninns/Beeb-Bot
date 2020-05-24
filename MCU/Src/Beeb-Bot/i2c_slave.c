/************************************************************************
	i2c_slave.c
    
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

#include "Beeb-Bot/i2c_slave.h"
#include "Beeb-Bot/debug.h"
#include "i2c.h"

// Set up 256 bytes of test I2C parameter locations
static uint8_t ram[256];
static uint8_t offset; // Index of current RAM cell
static uint8_t first=1;// First byte = new offset

static uint8_t test = 0;

// Functions
uint8_t getTest()
{
    return test;
}

void i2c_initialiseRam()
{
    debug("Initalising I2C RAM locations...\r\n");
    for (uint16_t i = 0; i < 256; i++) {
        ram[i] = i + 10;
    }

    // Reset byte pointer
    first = 1;
}

// Callbacks ----------------------------------------------------------------------------------------------------------  
void HAL_I2C_ListenCpltCallback(I2C_HandleTypeDef *hi2c)
{
    first = 1;
    // Indicate that slave is ready again
    HAL_I2C_EnableListen_IT(hi2c);
    test = 1;
}
    
void HAL_I2C_AddrCallback(I2C_HandleTypeDef *hi2c, uint8_t TransferDirection, uint16_t AddrMatchCode)
{
    if( TransferDirection==I2C_DIRECTION_TRANSMIT ) {
        if(first) {
            HAL_I2C_Slave_Sequential_Receive_IT(hi2c, &offset, 1, I2C_NEXT_FRAME);
        } else {
            HAL_I2C_Slave_Sequential_Receive_IT(hi2c, &ram[offset], 1, I2C_NEXT_FRAME);
        }
    } else {
        HAL_I2C_Slave_Sequential_Transmit_IT(hi2c, &ram[offset], 1, I2C_NEXT_FRAME);
    }
    test = 1;
}
    
void HAL_I2C_SlaveRxCpltCallback(I2C_HandleTypeDef *hi2c)
{
    if(first) {
        first = 0;
    } else {
        offset++;
    }
    HAL_I2C_Slave_Sequential_Receive_IT(hi2c, &ram[offset], 1, I2C_NEXT_FRAME);
    test = 1;
}
    
void HAL_I2C_SlaveTxCpltCallback(I2C_HandleTypeDef *hi2c)
{
    offset++;
    HAL_I2C_Slave_Sequential_Transmit_IT(hi2c, &ram[offset], 1, I2C_NEXT_FRAME);
    test = 1;
}
    
void HAL_I2C_ErrorCallback(I2C_HandleTypeDef *hi2c)
{
    if( HAL_I2C_GetError(hi2c)==HAL_I2C_ERROR_AF ) {
        // Transaction terminated by I2C master
        offset--;
    } else {
        // Unknown error
    }

    test = 1;
}