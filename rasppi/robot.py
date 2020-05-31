#************************************************************************
#
#   robot.py
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

from beebbot import Beebbot
from beebbot import Beebbot_Motor
from beebbot import Beebbot_Direction

from time import sleep

# Main
beebbot = Beebbot()
print("BeebBot Status: ")
print("  Firmware version: ", beebbot.firmwareVersion())
print("  Battery voltage (mV): ", beebbot.batteryVoltage())

print("  Left motor:")
print("    Direction: ", beebbot.getMotorDirection(Beebbot_Motor.left))
print("    Speed (SPS): ", beebbot.getMotorSpeed(Beebbot_Motor.left))
print("    Steps: ", beebbot.getMotorSteps(Beebbot_Motor.left))

print("  Right motor:")
print("    Direction: ", beebbot.getMotorDirection(Beebbot_Motor.right))
print("    Speed (SPS): ", beebbot.getMotorSpeed(Beebbot_Motor.right))
print("    Steps: ", beebbot.getMotorSteps(Beebbot_Motor.right))

# Move BeebBot in square
beebbot.setMotorSpeed(Beebbot_Motor.left, 6000)
beebbot.setMotorSpeed(Beebbot_Motor.right, 6000)

beebbot.setMotorDirection(Beebbot_Motor.left, Beebbot_Direction.forwards)
beebbot.setMotorDirection(Beebbot_Motor.right, Beebbot_Direction.reverse)

beebbot.setMotorSteps(Beebbot_Motor.left, 5000)
beebbot.setMotorSteps(Beebbot_Motor.right, 5000)

while ((beebbot.getMotorSteps(Beebbot_Motor.left) != 0) and (beebbot.getMotorSteps(Beebbot_Motor.right) != 0)):
	sleep(0.2)

beebbot.setMotorDirection(Beebbot_Motor.left, Beebbot_Direction.reverse)
beebbot.setMotorDirection(Beebbot_Motor.right, Beebbot_Direction.forwards)

beebbot.setMotorSteps(Beebbot_Motor.left, 5000)
beebbot.setMotorSteps(Beebbot_Motor.right, 5000)
