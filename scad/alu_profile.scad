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

include <common.scad>

// Draws an aluminium profile end cap
// Note: end cap is 1.5mm high to allow for tollerances once
// the piece is assembled (should be 2mm)
module profile_end_cap()
{
    difference() {
        cuboid([15,15,1.5], chamfer=0.5, edges=EDGES_Z_ALL+EDGES_TOP);

        // Cut out channels
        move([5.5,0,0]) cyl(h=3, d=4);
        move([0,5.5,0]) cyl(h=3, d=4);
        move([-5.5,0,0]) cyl(h=3, d=4);
        move([0,-5.5,0]) cyl(h=3, d=4);

        move([7.5,0,0]) cuboid([3,3,3]);
        move([0,7.5,0]) cuboid([3,3,3]);
        move([-7.5,0,0]) cuboid([3,3,3]);
        move([0,-7.5,0]) cuboid([3,3,3]);
    }

    // Add a square pin to the top-side
    move([0,0,1.25]) square_pin();

    // Add a cuboid underneath for attachment to profile
    move([0,0,-3]) cuboid([5,5,5], chamfer = 0.5, edges=EDGES_Z_ALL+EDGES_BOTTOM);
}

module render_alu_profile(length)
{
    // Profile length is -4 as profile caps are 2mm thick
    color("lightgrey") column_body(length - 4, true);

    color([0.2,0.2,0.2]) move([0,0,(length / 2) - 1]) profile_end_cap();
    color([0.2,0.2,0.2]) rotate([180,0,0]) move([0,0,(length / 2) - 1]) profile_end_cap();
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

        //move([25,0,5.5]) profile_end_cap();
        //move([25 + 16,0,5.5]) profile_end_cap();
    } else {
        // Profile length is -4 as profile caps are 2mm thick
        color("lightgrey") column_body(length - 4, true);

        color([0.2,0.2,0.2]) move([0,0,(length / 2) - 1]) profile_end_cap();
        color([0.2,0.2,0.2]) rotate([180,0,0]) move([0,0,(length / 2) - 1]) profile_end_cap();
    }
}

module alu_profile_end_cap(printMode)
{
    if (printMode) {
        move([0,0,5.5]) profile_end_cap();
    } else {
        color([0.2,0.2,0.2]) move([0,0,5.5]) profile_end_cap();
    }
}