/************************************************************************

	block.scad
    
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

module render_block15(length)
{
   // Profile length is -4 as profile caps are 2mm thick
    color("lightgrey") {
        difference() {
            column_body(length, false);
            move([0,0,-(length / 2) + 2]) xcyl(h=16, d=4);

            move([6,0,-(length / 2) + 1.5]) cuboid([5,4,5]);
            move([-6,0,-(length / 2) + 1.5]) cuboid([5,4,5]);
            move([0,0,-(length / 2)]) cuboid([15,3,3]);
        }
    }

    // Add a square pin to the top-side
    color([0.2,0.2,0.2]) move([0,0,(length / 2) + 0.5]) square_pin(false);
}

module block15(y_units, printMode)
{
    length = y_units * 15;
    
    if (printMode) {
        // Display ready for 3D printing
        move([0,0,(length / 2)]) {
            render_block15(length);
        }
    } else {
        render_block15(length);
    }
}