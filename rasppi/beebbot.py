#************************************************************************
#
#   beebbot.py
#
#   BeebBot Raspberry Pi Python Example
#   Copyright (C) 2020 Simon Inns
#
#   This program is free software: you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation, either version 3 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#   Email: simon.inns@gmail.com
#
#************************************************************************

import spidev
from enum import Enum

# Motor left/right enumeration
class Beebbot_Motor(Enum):
    left = 0
    right = 1

# Motor direction forward/reverse enumeration
class Beebbot_Direction(Enum):
    forwards = 0
    reverse = 1

# Handle response from BeebBot
class Beebbot_response:
	def __init__(self, bytes):
		# Convert the list of bytes from the SPI response to response and parameter ints
		self.resultCode = bytes[0]
		self.parameter = int.from_bytes([bytes[1], bytes[2], bytes[3], bytes[4]], byteorder='big', signed=False)

	def display(self):
		print("Result code: ", self.resultCode, " Parameter: ", self.parameter)

# Handle command to BeebBot
class Beebbot_command:
	def __init__(self, command, parameter):
		self.command = command
		self.parameter = parameter

		# Generate a list of bytes for sending the command via SPI
		self.bytes = []
		for i in range(0, 4):
			self.bytes.append(parameter >> (i * 8) & 0xff)
		self.bytes.reverse()
		self.bytes.insert(0, command)

	def display(self):
		print("Command: ", self.command, " Parameter: ", self.parameter, " Bytes: ", self.bytes)

# Send a command to BeebBot and collect the response
class Beebbot_communicate:
	def __init__(self, bus, device):
		self.spi = spidev.SpiDev()
		self.spi.open(bus, device)
		self.spi.max_speed_hz = 500000
		self.spi.mode = 0

	def send(self, command):
		self.spi.writebytes(command.bytes)
		return Beebbot_response(self.spi.readbytes(5))

# Send commands to BeebBot
# Note: This class is tightly coupled with the STM32 communication protocol
class Beebbot:
    def __init__(self):
        self.robot = Beebbot_communicate(0, 0)
    # System command - Get firmware version (0x00)
    def firmwareVersion(self):
        response = self.robot.send(Beebbot_command(0x00, 0))
        if response.resultCode != 0:
            return False
        else: 
            return response.parameter

    # System command - Get battery voltage in mV (0x01)
    def batteryVoltage(self):
        response = self.robot.send(Beebbot_command(0x01, 0))
        if response.resultCode != 0:
            return False
        else:
            return response.parameter
        
    # Set motor direction (Left 0x10, Right 0x20)
    def setMotorDirection(self, motor, direction):
        if motor == Beebbot_Motor.left:
            if direction == Beebbot_Direction.forwards:
                response = self.robot.send(Beebbot_command(0x10, 0))
                if response.resultCode != 0: return False
                else: return True
            else:
                response = self.robot.send(Beebbot_command(0x10, 1))
                if response.resultCode != 0: return False
                else: return True

        elif motor == Beebbot_Motor.right:
            if direction == Beebbot_Direction.forwards:
                response = self.robot.send(Beebbot_command(0x20, 0))
                if response.resultCode != 0: return False
                else: return True
            else:
                response = self.robot.send(Beebbot_command(0x20, 1))
                if response.resultCode != 0: return False
                else: return True

        else:
            raise TypeError("Motor should be left or right")

    # Get motor direction (Left 0x11, Right 0x21)
    def getMotorDirection(self, motor):
        if motor == Beebbot_Motor.left:
            response = self.robot.send(Beebbot_command(0x11, 0))
            if response.resultCode != 0: return False
            if response.parameter == 0: return Beebbot_Direction.forwards
            return Beebbot_Direction.reverse

        elif motor == Beebbot_Motor.right:
            response = self.robot.send(Beebbot_command(0x21, 0))
            if response.resultCode != 0: return False
            if response.parameter == 0: return Beebbot_Direction.forwards
            return Beebbot_Direction.reverse

        else:
            raise TypeError("Motor should be left or right")

    # Set motor speed (Left 0x12, Right 0x22)
    def setMotorSpeed(self, motor, speed):
        if motor == Beebbot_Motor.left:
            response = self.robot.send(Beebbot_command(0x12, speed))
            if response.resultCode != 0: return False
            else: return True

        elif motor == Beebbot_Motor.right:
            response = self.robot.send(Beebbot_command(0x22, speed))
            if response.resultCode != 0: return False
            else: return True

        else:
            raise TypeError("Motor should be left or right")

    # Get motor speed (Left 0x13, Right 0x23)
    def getMotorSpeed(self, motor):
        if motor == Beebbot_Motor.left:
            response = self.robot.send(Beebbot_command(0x13, 0))
            if response.resultCode != 0: return -1
            return response.parameter

        elif motor == Beebbot_Motor.right:
            response = self.robot.send(Beebbot_command(0x23, 0))
            if response.resultCode != 0: return -1
            return response.parameter

        else:
            raise TypeError("Motor should be left or right")

    # Set motor steps (Left 0x14, Right 0x24)
    def setMotorSteps(self, motor, steps):
        if motor == Beebbot_Motor.left:
            response = self.robot.send(Beebbot_command(0x14, steps))
            if response.resultCode != 0: return False
            else: return True

        elif motor == Beebbot_Motor.right:
            response = self.robot.send(Beebbot_command(0x24, steps))
            if response.resultCode != 0: return False
            else: return True

        else:
            raise TypeError("Motor should be left or right")

    # Get motor steps (Left 0x15, Right 0x25)
    def getMotorSteps(self, motor):
        if motor == Beebbot_Motor.left:
            response = self.robot.send(Beebbot_command(0x15, 0))
            if response.resultCode != 0: return -1
            return response.parameter

        elif motor == Beebbot_Motor.right:
            response = self.robot.send(Beebbot_command(0x25, 0))
            if response.resultCode != 0: return -1
            return response.parameter

        else:
            raise TypeError("Motor should be left or right")

            