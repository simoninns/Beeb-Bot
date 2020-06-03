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

# Main
beebbot = Beebbot()
running = True

# Show the status of the BeebBot
beebbot.showStatus()

# Set speed to 100mm/sec
if not beebbot.speed(100):
    print("Cannot set speed - Communication failure")
    running = False

while running:
    if not beebbot.pivotLeft(90): running = False
    if not beebbot.waitForCompletion(): running = False

    if not beebbot.pivotRight(90): running = False
    if not beebbot.waitForCompletion(): running = False

    if not running: print("Stopping run due to communication failure")

print("Finished")