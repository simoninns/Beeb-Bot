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
    move([0,4,0]) cuboid([15,0.5,2]);

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

// Hinged block -------------------------------------------------------------------------------------------------------
module render_block_end()
{
    length = 15;
    column_body(length, false);

    // Add a square pin to the top-side
    move([0,0,(length / 2) + 0.5]) square_pin();
}

module render_hinge_pin_base()
{
    move([0,0, - (7.5 / 2)]) {
        difference() {
            union() {
                move([0,0,-1.5]) cyl(h=(15 / 2) - 3,d=13, $fn=60);
                move([0,0,.75]) cyl(h=4,d=13, $fn=60, chamfer=2);

                
            }
            move([0,0,-3]) cuboid([2,15,3]);
            cyl(h=15, d=4, $fn=60);
        }
    }

    difference() {
        cyl(h=2, d=8, $fn=60);
        cyl(h=3, d=6, $fn=60);

        move([0,0,0.5]) cuboid([10,2,3]);
        move([0,0,0.5]) cuboid([2,10,3]);
    } 
}

module render_hinge_pin_top()
{
    move([0,0, - (7.5 / 2)]) {
        difference() {
            union() {
                move([0,0,-1.5]) cyl(h=(15 / 2) - 3,d=13, $fn=60);
                move([0,0,.75]) cyl(h=4,d=13, $fn=60, chamfer=2);
            }
            move([0,0,-3]) cuboid([2,15,3]);
            cyl(h=15, d=4, $fn=60);
        }
    }

    difference() {
        union() {
            cyl(h=2, d=6, $fn=60);
            move([0,0,0.5]) cuboid([10,1.8,3]);
            move([0,0,0.5]) cuboid([1.8,10,3]);
        }
        cyl(h=6, d=4, $fn=60);
        move([0,0,2.5]) cyl(h=3, d=12, $fn=60);
        move([0,0,-2]) tube(h=4, id=8.5, od=12, $fn=60);
    }
}

module render_hinged_block_body_front()
{
    // Block
    difference() {
        rotate([0,-90,0]) {
            move([0,0,15]) render_block_end();
            move([0,0,(15 / 2) + 0.25]) cuboid([15,15,0.5], chamfer=0.5, edges=EDGES_Z_ALL);
        }
        
        move([-10,4,-4.5]) cuboid([6, 3, 3], chamfer=0.25);
        move([-10,-4,-4.5]) cuboid([6, 3, 3], chamfer=0.25);
    }
}

module render_hinged_block_body_back()
{
    // Outer hinge
    move([0,0, - (7.5 / 2)]) {
        difference() {
            union() {
                cyl(h=15 / 2,d=15, chamfer=0.5, $fn=60);
                move([-(7.5 / 2),0,0]) cuboid([7.5,15, 7.5], chamfer = 0.5, edges = EDGES_X_BK+EDGES_X_FR);           
            }
            cyl(h=(15 / 2) + 1,d=13, $fn=60);
            move([-7.5,0,0]) cuboid([1,16,8]); // Adjust each side by 0.5mm to get correct length after printing
        }
        
        move([-8.5,4,-1]) cuboid([5, 2.7, 2.7], chamfer=0.25);
        move([-8.5,-4,-1]) cuboid([5, 2.7, 2.7], chamfer=0.25);
    }

    // Hinge lip
    difference() {
        move([0,0,-1.5]) cyl(h=3,d=13, $fn=60);
        move([0,0,-1.5]) cyl(h=4,d=10, $fn=60);

        move([0,0,0]) cyl(h=4,d=13, $fn=60, chamfer=2);
        move([0,0,-3]) cyl(h=4,d=13, $fn=60, chamfer=2);
    }   
}

// Note: Angle is for display purposes and allows
// rendering of the hinge with some rotation
module render_hinged_block_display(angle)
{
    rotate([0,0,angle]) {
        render_hinged_block_body_front();
        render_hinged_block_body_back();
    }
    render_hinge_pin_base();

    rotate([180,0,180]) {
        render_hinged_block_body_front();
        render_hinged_block_body_back();
        render_hinge_pin_top();
    }
}

module render_hinged_block_print()
{
    move([0,0,7.5]) {
        move([-23,-12,-15]) rotate([0,90,0]) render_hinged_block_body_front();
        move([-23,12,-15]) rotate([0,90,0]) render_hinged_block_body_front();

        move([0,-12,0]) render_hinged_block_body_back();
        move([0,12,0]) render_hinged_block_body_back();

        move([18,-12,0]) render_hinge_pin_base();
        move([18,12,0]) render_hinge_pin_top();
    }
}

module hinged_block(printMode)
{
    if (printMode) {
        render_hinged_block_print();
    } else {
        color("lightgrey") render_hinged_block_display(60);
    }
}