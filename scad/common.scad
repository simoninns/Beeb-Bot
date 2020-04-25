/************************************************************************

	common.scad
    
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

// Draws a square pin.  If split is true, a 1mm split is removed from 
// the top of the pin
module square_pin(split)
{
    difference() {
        union() {
            cuboid([3,3,1], chamfer = 0.25, edges=EDGES_Z_ALL);
            move([0,0,1]) cuboid([4,4,2], chamfer = 0.5, edges=EDGES_Z_ALL+EDGES_BOTTOM);
        }
        if (split) rotate([0,0,45]) move([0,0,2]) cuboid([6,1,2]);
    }
}

// Draws a 15x15xlength column
module column_body(length, cap_mount)
{
   difference() {
        cuboid([15,15,length], chamfer=0.5, edges=EDGES_Z_ALL);

        // Cut out channels
        move([6,0,0]) cyl(h=length + 2, d=4);
        move([0,6,0]) cyl(h=length + 2, d=4);
        move([-6,0,0]) cyl(h=length + 2, d=4);
        move([0,-6,0]) cyl(h=length + 2, d=4);

        // Recesses to allow attachement of profile caps
        if (cap_mount) {
            move([0,0,(length / 2) + 3 - 5]) cuboid([5,5,6.25], chamfer = 0.5, edges=EDGES_Z_ALL+EDGES_BOTTOM);
            rotate([180,0,0]) move([0,0,(length / 2) + 3 - 5]) cuboid([5,5,6], chamfer = 0.5, edges=EDGES_Z_ALL+EDGES_BOTTOM);
        }
    }
}