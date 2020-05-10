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
                cuboid([120 + 4 + 2,120 + 4 + 2,14], chamfer = 1, edges=EDGES_Z_ALL);
                cuboid([120 + 2,120 + 2,15]);
            }

            // Top indent
            move([-58.5,0,53.5]) cuboid([5,70,2]);
            move([58.5,0,53.5]) cuboid([5,70,2]);

            // Holding tabs
            move([-59.5,0,43]) cuboid([3,70,2.5], chamfer=1, edges=EDGES_RIGHT);
            move([59.5,0,43]) cuboid([3,70,2.5], chamfer=1, edges=EDGES_LEFT);

            move([0,0,61.5]) difference() {
                union() {
                    // Top of cover
                    difference() {
                        cuboid([120 + 4 + 2,120 + 4 + 2,14], chamfer = 1, edges=EDGES_Z_ALL);

                        // Main body cut-out
                        cuboid([120 + 2,120 + 2,15]);
                    }

                    // Indents
                    move([-59.5,0,0]) cuboid([5 + 2,70,14]);
                    move([59.5,0,0]) cuboid([5 + 2,70,14]);
                }

                // Cut-out indents
                move([-59.5 - 2,0,0]) cuboid([7,70 - 4,15]);
                move([59.5 + 2,0,0]) cuboid([7,70 - 4,15]);
            }
        }

        // Cut-out to allow access to ports
        move([0,0,46]) cuboid([95,130,40], fillet = 5, edges=EDGES_Y_ALL);
    }
}

module render_cover_top_pattern()
{
    patWidth = 150;
    move([0,0,69])difference() {
        rotate([0,0,45]) {
            for (pos = [0:10:patWidth]) {
                move([0,pos - patWidth / 2,0]) cuboid([patWidth,5,10]);
            }
        }

        difference() {
            cyl(h=12, d=patWidth + 100, $fn=60);
            cyl(h=13, d=110, $fn=60);
        }
    }
}

module render_cover_top()
{
    // Lid
    move([0,0,69.5]) difference() {
        cuboid([120 + 4 + 2,120 + 4 + 2,2], chamfer = 1, edges=EDGES_Z_ALL+EDGES_TOP);

        // Cut-out indents
        move([-59.5 - 2,0,0]) cuboid([7,70 - 4,15]);
        move([59.5 + 2,0,0]) cuboid([7,70 - 4,15]);
    }
}

module render_cover()
{
    render_cover_base();
    difference() {
        render_cover_top();
        render_cover_top_pattern();
    }
}

module cover(printMode)
{
    if (printMode) {
        rotate([180,0,0]) move([0,0,-16]) render_cover();
    } else {
        //assembly_step_8();
        color("red") render_cover();
    }
}