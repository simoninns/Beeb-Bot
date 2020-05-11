/************************************************************************

	cover.scad
    
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

include <alu_profile.scad>
include <assemblies.scad>

module render_cover_base()
{
    difference() {
        union() {
            // Base of cover
            move([0,0,47.5]) difference() {
                cuboid([120 + 3 + 2,120 + 4 + 2,14], chamfer = 1, edges=EDGES_Z_ALL);
                cuboid([120 + 1,120 + 2,15]);
            }

            // Top indent
            move([-58,0,53.5]) cuboid([5,70,2]);
            move([58,0,53.5]) cuboid([5,70,2]);

            // Holding tabs
            // Note, these need a triangular base in order to be
            // printable
            move([-59,0,43]) {
                difference() {
                right_triangle([3, 50, 3], center=true);
                move([1,0,-1]) cuboid([1,71,3]);
                }
            }
            rotate([0,0,180]) move([-59,0,43]) {
                difference() {
                right_triangle([3, 50, 3], center=true);
                move([1,0,-1]) cuboid([1,71,3]);
                }
            }

            move([0,0,61.5]) difference() {
                union() {
                    // Top of cover
                    difference() {
                        cuboid([120 + 3 + 2,120 + 4 + 2,14], chamfer = 1, edges=EDGES_Z_ALL);

                        // Main body cut-out
                        cuboid([120 + 1,120 + 2,15]);
                    }

                    // Indents
                    move([-58.5,0,0]) cuboid([5 + 1,70,14]);
                    move([58.5,0,0]) cuboid([5 + 1,70,14]);
                }

                // Cut-out indents
                move([-59 - 2,0,0]) cuboid([7,70 - 4,15]);
                move([59 + 2,0,0]) cuboid([7,70 - 4,15]);
            }
        }

        // Cut-out to allow access to ports
        move([0,0,46]) cuboid([95,130,40], fillet = 5, edges=EDGES_Y_ALL);
    }

    // Angle cut-outs to make it easier to print
    move([59,0,61.5 - 3.5]) right_triangle([7, 70, 7], center=true);
    rotate([0,0,180])move([59,0,61.5 - 3.5]) right_triangle([7, 70, 7], center=true);
}

// Tessellated hexagon pattern
module render_cover_top_pattern1()
{
    move([-49,-54,70]) {
        for (ypos = [0:8:13*8]) {
            move([0,ypos,0]) {
                for (xpos = [0:14:14*7]) {
                    move ([xpos,0,0]) cyl(h=10, d=8, $fn=6);
                }

                for (xpos = [0:14:13*7]) {
                    move ([xpos + 7,4,0]) cyl(h=10, d=8, $fn=6);
                }
            }
        }
    }
}

module render_cover_top()
{
    // Lid
    move([0,0,69.5]) difference() {
        cuboid([120 + 3 + 2,120 + 4 + 2,2], chamfer = 1, edges=EDGES_Z_ALL+EDGES_TOP);

        // Cut-out indents
        move([-59 - 2,0,0]) cuboid([7,70 - 4,15]);
        move([59 + 2,0,0]) cuboid([7,70 - 4,15]);

        // Chamfer indents
        move([0,0,7.5]) {
            move([-59 - 2,0,0]) cuboid([9,70 - 2,15], chamfer=1);
            move([59 + 2,0,0]) cuboid([9,70 - 2,15], chamfer=1);
        }
    }
}

module render_cover()
{
    render_cover_base();
    difference() {
        render_cover_top();
        render_cover_top_pattern1();
    }
}

module cover(printMode)
{
    if (printMode) {
        rotate([180,0,0]) move([0,0,-70.5]) render_cover();
    } else {
        color("red") render_cover();
    }
}