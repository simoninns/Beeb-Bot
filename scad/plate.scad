/************************************************************************

	plate.scad
    
	Beeb-Bot
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

include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

include <common.scad>

module render_pin_plate(x_units)
{
    move([-((x_units - 1) / 2) * 15,0,0]) {
        for (xpos = [0 : x_units - 1]) {
            move([xpos * 15,0,0]) {
                cuboid([15,15,2]);

                // Add a pin to the top-side
                move([0,0,1.5]) square_pin(false);
            }
        }
    }
}

module render_flat_plate(x_units, y_units)
{
    // Only render if the y_units are greater than 1
    if (y_units > 1) {
        for (ypos = [0 : y_units - 1]) {
            move([-((x_units - 1) / 2) * 15,0,0]) {
                for (xpos = [0 : x_units - 1]) {
                    move([xpos * 15,ypos * 15,0]) {
                        cuboid([15,15,2]);
                    }
                }
            }
        }
    }
}

module plate15(x_units, y_units, printMode)
{
    if (printMode) {
        // Display ready for 3D printing
        move([0,0,1]) {
            color("red") render_pin_plate(x_units);
            color("red") render_flat_plate(x_units, y_units);
        }

    } else {
        color("red") render_pin_plate(x_units);
        color("red") render_flat_plate(x_units, y_units);
    }
}