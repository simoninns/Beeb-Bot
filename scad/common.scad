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


module render_pin(xlength)
{
    difference() {
        union() {
            move([0,0,-0.125]) rounded_prismoid(size1=[xlength-1,3], size2=[xlength-1,3], h=0.8, r=0.5, center=true);
            move([0,0,0.75]) rounded_prismoid(size1=[xlength-1,3], size2=[xlength,4], h=1.125, r=0.5, center=true);
            move([0,0,1.875]) cuboid([xlength,4,1.25], fillet = 0.5, edges=EDGES_Z_ALL+EDGES_TOP);
        }
    }
}

// Draws a square pin
module square_pin() {
    render_pin(4);
}

// Draws a square pin mask
module square_pin_mask(xlength) {
    render_pin(xlength);
}

// Draws a 15x15xlength column
module column_body(length, cap_mount)
{
   difference() {
        cuboid([15,15,length], chamfer=0.5, edges=EDGES_Z_ALL);

        // Cut out channels
        move([5.5,0,0]) cyl(h=length + 2, d=4);
        move([0,5.5,0]) cyl(h=length + 2, d=4);
        move([-5.5,0,0]) cyl(h=length + 2, d=4);
        move([0,-5.5,0]) cyl(h=length + 2, d=4);

        move([7.5,0,0]) cuboid([3,3,length+2]);
        move([0,7.5,0]) cuboid([3,3,length+2]);
        move([-7.5,0,0]) cuboid([3,3,length+2]);
        move([0,-7.5,0]) cuboid([3,3,length+2]);

        // Recesses to allow attachement of profile caps
        if (cap_mount) {
            move([0,0,(length / 2) + 3 - 5]) cuboid([5,5,6.25], chamfer = 0.5, edges=EDGES_Z_ALL+EDGES_BOTTOM);
            rotate([180,0,0]) move([0,0,(length / 2) + 3 - 5]) cuboid([5,5,6], chamfer = 0.5, edges=EDGES_Z_ALL+EDGES_BOTTOM);
        }
    }
}

// Draws a V-profile joiner as found on the switches and electronic parts
module v_profile(vlength)
{
    difference() {
        union() {
            cuboid([vlength,1,2.8]);

            move([0,1.5,-1.2]) rotate([74,0,0]) cuboid([vlength,1,3.25]);
            move([0,1.5,1.2]) rotate([-74,0,0]) cuboid([vlength,1,3.25]);

            move([0,2,-1.25]) rotate([0,90,0]) cyl(h=vlength, d=1.5);
            move([0,2,1.25]) rotate([0,90,0]) cyl(h=vlength, d=1.5);
        }
        move([0,2.75,0]) cuboid([vlength+1,1,6]);
        move([0,2,0]) cuboid([vlength + 1, 1, 1.4]);   
    }
}