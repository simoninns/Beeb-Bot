/************************************************************************

	hinge.scad
    
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

// Render hinge -------------------------------------------------------------------------------------------------------
module render_hinge()
{
    difference() {
        cuboid([15,15,7.5]);

        // Add a grove for square pins
        move([-5,0,-3.25]) square_pin_mask(15);

        // Cut edge of hinge
        move([0,7.5,0]) rotate([45,0,0]) cuboid([20,4.5,4.5]);

        // Cut out the centre
        move([0,-7.5,0.5]) cuboid([20,5,2.5]);
        move([0,-1,-0.75]) rotate([0,0,90]) prismoid(size1=[10,20], size2=[9,20], h=3);
    }

    // Add base back in
    move([0,-1,-0.75]) rotate([0,0,90]) prismoid(size1=[8.5,15], size2=[8,15], h=1);

    // Reenforce the hinge a little
    move([0,4.25,0]) cuboid([15,0.75,2]);

    // Add a pin to the top-side
    move([0,0,4.25]) square_pin();
}

module hinge(printMode)
{
    if (printMode) {
        rotate([0,90,0]) move([-7.5,0,0]) render_hinge();
    } else {
        color("lightgrey") render_hinge();
    }
}