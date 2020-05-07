/************************************************************************

	alu_profile.scad
    
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

include <pins.scad>

// Draws an aluminium profile end cap
// Note: end cap is 1.5mm high to allow for tollerances once
// the piece is assembled (should be 2mm)
module render_single_profile_end_cap()
{
    difference() {
        cuboid([15,15,1.5], chamfer=0.5, edges=EDGES_Z_ALL+EDGES_TOP);

        // Cut out channels
        rotate([0,-90,0]) move([0,0,-7])render() square_pin_mask(5, true);
        rotate([0,90,0]) move([0,0,-7])render() square_pin_mask(5, true);
        rotate([90,90,0]) move([0,0,-7])render() square_pin_mask(5, true);
        rotate([-90,90,0]) move([0,0,-7])render() square_pin_mask(5, true);
    }

    // Add a square pin to the top-side
    move([0,0,1.25]) square_pin();

    // Add a cuboid underneath for attachment to profile
    move([0,0,-3]) cuboid([5,5,5], chamfer = 0.5, edges=EDGES_Z_ALL+EDGES_BOTTOM);
}

// Display either 1 or 28 end caps in 4 rows of 7
module render_profile_end_cap(multiple)
{
    if (multiple < 2) {
        render_single_profile_end_cap();
    } else {
        for (ypos = [0:(multiple / 7) - 1]) {
            for(xpos = [0:(multiple / 4) - 1]) {
                move([xpos * 17,ypos*17,0]) {
                    render_single_profile_end_cap();
                }
            }
        }
    }
}

module render_alu_profile(length)
{
    // Profile length is -4 as profile caps are 2mm thick
    color("lightgrey") render() column_body(length - 4, true);

    color([0.2,0.2,0.2]) move([0,0,(length / 2) - 1]) render() render_profile_end_cap(1);
    color([0.2,0.2,0.2]) rotate([180,0,0]) move([0,0,(length / 2) - 1]) render() render_profile_end_cap(1);
}

module alu_profile15(y_units, printMode)
{
    length = y_units * 15;
    
    if (printMode) {
        // Profile length is -4 as profile caps are 2mm thick

        // Display ready for 3D printing
        move([0,0,(length / 2) - 2]) {
            column_body(length - 4, true);
        }
    } else {
        // Profile length is -4 as profile caps are 2mm thick
        color("lightgrey") render() column_body(length - 4, true);

        // The -.75 moves the end caps to the right position...
        // I need to figure out why this prints 1mm longer than
        // the model (probably due to the tolerance on the underside
        // of the end caps).
        color([0.2,0.2,0.2]) move([0,0,(length / 2) - .75]) render() render_profile_end_cap(1);
        color([0.2,0.2,0.2]) rotate([180,0,0]) move([0,0,(length / 2) - .75]) render() render_profile_end_cap(1);
    }
}

module alu_profile_end_cap(printMode, multiple)
{
    if (printMode) {
        move([0,0,5.5]) render_profile_end_cap(multiple);
    } else {
        color([0.2,0.2,0.2]) move([0,0,5.5]) render_profile_end_cap(multiple);
    }
}
