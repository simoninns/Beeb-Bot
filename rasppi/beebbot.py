#************************************************************************
#
#   beebbot.py
#
#   BeebBot Raspberry Pi Communication
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
from time import sleep

# Motor left/right enumeration
class Beebbot_Motor(Enum):
    left = 0
    right = 1

# Motor direction forward/reverse enumeration
class Beebbot_Direction(Enum):
    forwards = 0
    reverse = 1

# Takes the 5 byte SPI response from a BeebBot and assembles it into
# a response code and parameter
class Beebbot_response:
	def __init__(self, bytes):
		# Convert the list of bytes from the SPI response to response and parameter ints
		self.resultCode = bytes[0]
		self.parameter = int.from_bytes([bytes[1], bytes[2], bytes[3], bytes[4]], byteorder='big', signed=False)

	def display(self):
		print("Result code: ", self.resultCode, " Parameter: ", self.parameter)

# Accepts a command number and parameter - splits into 5 bytes
# ready for SPI communication to the BeebBot
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

# Send a command to BeebBot and collect the response using SPI
class Beebbot_communicate:
	def __init__(self, bus, device):
		self.spi = spidev.SpiDev()
		self.spi.open(bus, device)
		self.spi.max_speed_hz = 500000
		self.spi.mode = 0

	def send(self, command):
		self.spi.writebytes(command.bytes)
		return Beebbot_response(self.spi.readbytes(5))

# Send SPI commands to BeebBot
# Note: This class is tightly coupled with the STM32 communication protocol
# defined by the BeebBot's STM32 firmware
class Beebbot_protocol:
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

# The Beebbot class is the high-level communication class
# that uses real-world values (mm, mm/sec, degrees, etc.) to
# communicate with the robot without the caller having to
# understand how the actual robot works, or the physical
# geometry of the robot
#
# The following physical constants are used:
#   Pinion is T10 - Gear is T30 - Gear ratio is 3:1
#   Full step is 200 steps/rotation - micro-stepping is 1/8
#   so 200 * 8 per revolution = 1600 steps
#   3:1 ratio is 4800 per wheel revolution
#
#   Wheel diameter is 65mm
#   Wheel to wheel distance is 163mm
class Beebbot:
    def __init__(self):
        self.beebbot_protocol = Beebbot_protocol()

        # Define the BeebBot's geometry
        self.wheelDiameterMM = 65
        self.wheelDistanceMM = 164
        self.wheelCircumference = 2 * 3.1415927 * (self.wheelDiameterMM / 2)
        self.stepsPerRevolution = 4800

    # Show the current status of the BeebBot
    def showStatus(self):
        print("BeebBot Status: ")
        print("  Firmware version: ", self.beebbot_protocol.firmwareVersion())
        print("  Battery voltage (mV): ", self.beebbot_protocol.batteryVoltage())

        print("  Left motor:")
        print("    Direction: ", self.beebbot_protocol.getMotorDirection(Beebbot_Motor.left))
        print("    Speed (SPS): ", self.beebbot_protocol.getMotorSpeed(Beebbot_Motor.left))
        print("    Steps: ", self.beebbot_protocol.getMotorSteps(Beebbot_Motor.left))

        print("  Right motor:")
        print("    Direction: ", self.beebbot_protocol.getMotorDirection(Beebbot_Motor.right))
        print("    Speed (SPS): ", self.beebbot_protocol.getMotorSpeed(Beebbot_Motor.right))
        print("    Steps: ", self.beebbot_protocol.getMotorSteps(Beebbot_Motor.right))

    # Set the speed of both BeebBot motors
    def speed(self, mmPerSecond):
        # Ensure the robot's motors are stopped
        if self.isMoving():
            print("Warning: Cannot execute speed command - motors active")
            return

        revolutions = mmPerSecond / self.wheelCircumference
        stepsPerSecond = int(revolutions * self.stepsPerRevolution)

        print("Setting speed to", mmPerSecond, "mm/sec (", stepsPerSecond, "steps/sec)")
        self.beebbot_protocol.setMotorSpeed(Beebbot_Motor.left, stepsPerSecond)
        self.beebbot_protocol.setMotorSpeed(Beebbot_Motor.right, stepsPerSecond)

    # Move the BeebBot forwards
    def forwards(self, millimeters):
        # Ensure the robot's motors are stopped
        if self.isMoving():
            print("Warning: Cannot execute forward command - motors active")
            return

        revolutions = millimeters / self.wheelCircumference
        steps = int(revolutions * self.stepsPerRevolution)

        print("Moving forwards", millimeters, "mm (", steps, "steps)")
        self.beebbot_protocol.setMotorDirection(Beebbot_Motor.left, Beebbot_Direction.forwards)
        self.beebbot_protocol.setMotorDirection(Beebbot_Motor.right, Beebbot_Direction.forwards)

        self.beebbot_protocol.setMotorSteps(Beebbot_Motor.left, steps)
        self.beebbot_protocol.setMotorSteps(Beebbot_Motor.right, steps)

    # Move the BeebBot backwards
    def reverse(self, millimeters):
        # Ensure the robot's motors are stopped
        if self.isMoving():
            print("Warning: Cannot execute reverse command - motors active")
            return

        revolutions = millimeters / self.wheelCircumference
        steps = int(revolutions * self.stepsPerRevolution)

        print("Moving backwards", millimeters, "mm (", steps, "steps)")
        self.beebbot_protocol.setMotorDirection(Beebbot_Motor.left, Beebbot_Direction.reverse)
        self.beebbot_protocol.setMotorDirection(Beebbot_Motor.right, Beebbot_Direction.reverse)

        self.beebbot_protocol.setMotorSteps(Beebbot_Motor.left, steps)
        self.beebbot_protocol.setMotorSteps(Beebbot_Motor.right, steps)

    # Pivot the BeebBot left (rotate around wheel axis)
    def pivotLeft(self, degrees):
        # Ensure the robot's motors are stopped
        if self.isMoving():
            print("Warning: Cannot execute pivot left command - motors active")
            return
        
        # Calculate the number of mm per 360 degrees
        pivotCircumferenceMM = 2 * 3.1415927 * (self.wheelDistanceMM / 2)
        
        # Number of required rotations
        rotations = degrees / 360

        # Calculate number of MM required to complete rotations
        millimeters = pivotCircumferenceMM * rotations

        # Convert millimeters into required motor steps
        revolutions = millimeters / self.wheelCircumference
        steps = int(revolutions * self.stepsPerRevolution)

        print("Pivoting left", degrees, "degrees (", steps, "steps)")
        self.beebbot_protocol.setMotorDirection(Beebbot_Motor.left, Beebbot_Direction.forwards)
        self.beebbot_protocol.setMotorDirection(Beebbot_Motor.right, Beebbot_Direction.reverse)

        self.beebbot_protocol.setMotorSteps(Beebbot_Motor.left, steps)
        self.beebbot_protocol.setMotorSteps(Beebbot_Motor.right, steps)

    # Pivot the BeebBot right (rotate around wheel axis)
    def pivotRight(self, degrees):
        # Ensure the robot's motors are stopped
        if self.isMoving():
            print("Warning: Cannot execute pivot right command - motors active")
            return
        
        # Calculate the number of mm per 360 degrees
        pivotCircumferenceMM = 2 * 3.1415927 * (self.wheelDistanceMM / 2)
        
        # Number of required rotations
        rotations = degrees / 360

        # Calculate number of MM required to complete rotations
        millimeters = pivotCircumferenceMM * rotations

        # Convert millimeters into required motor steps
        revolutions = millimeters / self.wheelCircumference
        steps = int(revolutions * self.stepsPerRevolution)

        print("Pivoting right", degrees, "degrees (", steps, "steps)")
        self.beebbot_protocol.setMotorDirection(Beebbot_Motor.left, Beebbot_Direction.reverse)
        self.beebbot_protocol.setMotorDirection(Beebbot_Motor.right, Beebbot_Direction.forwards)

        self.beebbot_protocol.setMotorSteps(Beebbot_Motor.left, steps)
        self.beebbot_protocol.setMotorSteps(Beebbot_Motor.right, steps)

    # Return True if the BeebBot is moving
    def isMoving(self):
        if ((self.beebbot_protocol.getMotorSteps(Beebbot_Motor.left) == 0) and (self.beebbot_protocol.getMotorSteps(Beebbot_Motor.right) == 0)):
            return False # BeebBot is not moving
        return True # BeebBot is moving

    # Wait for the BeebBot to stop moving
    def waitForCompletion(self):
        while (self.isMoving()):
            print("Left:", self.beebbot_protocol.getMotorSteps(Beebbot_Motor.left), " Right:", self.beebbot_protocol.getMotorSteps(Beebbot_Motor.right))
            sleep(0.5)
        print("Left: stopped  Right: stopped")