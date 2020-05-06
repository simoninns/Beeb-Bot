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

// Render block 15x15x15, 30x15x15 and up -----------------------------------------------------------------------------
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
    color("lightgrey") move([0,0,(length / 2) + 0.5]) square_pin();
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

// Render block 15x15x5 -----------------------------------------------------------------------------------------------
module render_block5()
{
    difference() {
        union() {
            cuboid([15,15,5]);

            // Add a pin to the top-side
            move([0,0,3]) square_pin();
        }

        move([0,0,-2]) square_pin_mask(20);
    }
}

module block5(printMode)
{
    if (printMode) {
        move([0,0,2.5]) render_block5();
    } else {
        color("red") render_block5();
    }
}

// Render block 15x15x7.5 -----------------------------------------------------------------------------------------------
module render_block7p5()
{
    difference() {
        cuboid([15,15,7.5]);

        move([0,0,-3.25]) square_pin_mask(20);
        rotate([180,0,0]) move([0,0,-3.25]) square_pin_mask(20);

        // Cut out channels
        move([0,5.5,0]) xcyl(h=20, d=4);
        move([0,-5.5,0]) xcyl(h=20, d=4);

        move([0,7.5,0]) cuboid([20,3,3]);
        move([0,-7.5,0]) cuboid([20,3,3]);
    }
}

module block7p5(printMode)
{
    if (printMode) {
        rotate([0,90,0]) move([-7.5,0,0]) render_block7p5();
    } else {
        color("red") render_block7p5();
    }
}

// Render block V15 corner 15x15x15 -----------------------------------------------------------------------------------
module render_blockv15()
{
    difference() {
        cuboid([15,15,15]);
        move([3.5,3.5,-1.5]) cuboid([15,15,15]);

        rotate([90,90,180]) move([5,0,-7]) square_pin_mask(15);
        rotate([90,90,90]) move([5,0,-7]) square_pin_mask(15);
    }

    // Add a pin to the top-side
    move([0,0,8]) square_pin();
}

module blockv15(printMode)
{
    if (printMode) {
        move([0,0,(15 / 2)]) render_blockv15();
    } else {
        color("red") render_blockv15();
    }
}