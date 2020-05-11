/************************************************************************

	pins.scad
    
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

// Note: The pin is 0.2mm smaller than the pin mask
// So a 4x4 pin is a 4x4 mask, but a 3.8x3.8 pin
module render_pin(xlength, yheight)
{
    move([0,0,-0.125]) {
        difference() {
            union() {
                // Base of pin
                cuboid([xlength -1,3,0.75], fillet=0.5, edges = EDGES_Z_ALL);
            
                // Top of pin
                difference() {
                    move([0,0,1.7]) {
                        difference() {
                            cuboid([xlength,4,4]); // Pin material

                            // Curve x1
                            move([-(xlength / 2) + 2,0,0]) difference() {
                                rotate([90,0,0]) tube(h=4, id=4, od=4 * 2, center=true, $fn=30); // Curve x1
                                move([2,0,0]) cuboid([4,5,10]);
                            }

                            // Curve x1
                            move([(xlength / 2) - 2,0,0]) difference() {
                                rotate([90,0,0]) tube(h=4, id=4, od=4 * 2, center=true, $fn=30); // Curve x1
                                move([-2,0,0]) cuboid([4,5,10]);
                            }
                            
                            rotate([0,90,0]) tube(h=xlength, id=4, od=4 * 2, center=true, $fn=30); // Curve y1
                        }       
                    }
                    move([0,0,2 + yheight]) cuboid([xlength + 2,5,5], center=true); // Flatten the pin
                }
            }

            // Slice the bottom of the pin to prevent overlaying the base
            difference() {
                cuboid([xlength+2,6,0.75], fillet=0.5, edges = EDGES_Z_ALL);
                cuboid([xlength-1,3,1], fillet=0.5, edges = EDGES_Z_ALL);
            }
        }    
    }
}

// Draws a square pin
module square_pin() {
    render() render_pin(4, 2.5);
}

// Draws a square pin mask
module square_pin_mask(xlength, fullHeight) {
    height = fullHeight ? 5:3;
    render() render_pin(xlength, height);

    // Add a small amount to the base to prevent rendering issues
    move([0,0,-0.125 - 0.45]) cuboid([xlength -1,3,0.25], fillet=0.5, edges = EDGES_Z_ALL);
}

// Draws a 15x15xlength column
module column_body(length, cap_mount)
{
        difference() {
            cuboid([15,15,length], chamfer=0.5, edges=EDGES_Z_ALL);

            // Cut out channels
            rotate([0,-90,0]) move([0,0,-7])render() square_pin_mask(length + 4, true);
            rotate([0,90,0]) move([0,0,-7])render() square_pin_mask(length + 4, true);
            rotate([90,90,0]) move([0,0,-7])render() square_pin_mask(length + 4, true);
            rotate([-90,90,0]) move([0,0,-7])render() square_pin_mask(length + 4, true);


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
        rotate([-90,0,0]) render_pin(vlength + 3, 2.5);
        move([(vlength / 2) + 1.5,0,0]) cuboid([3,4,4]);
        move([-(vlength / 2) - 1.5,0,0]) cuboid([3,4,4]);
        move([0,2,0]) rotate([45,0,0]) cuboid([vlength + 3, 2, 2]);
        move([0,1,0]) cuboid([vlength + 3, 1, 0.75]);
    }

    
}