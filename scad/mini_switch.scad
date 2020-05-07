/************************************************************************

	mini_switch.scad
    
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

module render_switch_plunger()
{
    // Main body
    difference() {
        union() {
            cuboid([12,4.5,10], fillet=0.5, edges=EDGES_Z_ALL);
            move([0,0,6.5]) rounded_prismoid(size1=[12,4.5], size2=[2,4.5], h=3, r=0.5, center=true);

            // Add a catch for the switch
            move([6,0,0.5]) rotate([0,-90,0]) rounded_prismoid(size1=[0.5,4.5], size2=[3,4.5], h=2, r=0.5, center=true);
        }

        // Make space for the spring holder
        move([0,0,-5]) cuboid([6,5,5]);
    }

    // Add guides
    move([4,-2.5,1.5]) cuboid([0.8,0.5,5]);
    move([-4,-2.5,1.5]) cuboid([0.8,0.5,5]);

    // Add a stop
    move([6,0,3.5]) cuboid([2,4.5,1], fillet = 0.5);    

    // Add a spring holder
    move([0,0,-3.75]) cuboid([3.5,3.5,2.5], chamfer=1, edges=EDGES_Z_ALL);
}

module render_switch_case_base()
{
    difference() {
        cuboid([30,7.5,15]);
        move([0,0,0]) cuboid([30-2,8,15-2]);

        // Make a hole for the lever
        move([-8 + (0.125 / 2),0,7]) cuboid([12.125,5,3]);

        // Cut outs
        render_top_cuts();
    }

    // Grooves for the lever to slide in
    move([4,0,0]) {
        move([-9,-3.125,2.5]) cuboid([1,1.25,9]);
        move([-7,-3.125,2.5]) cuboid([1,1.25,9]);
        move([-8,-3.125,1 - 3]) cuboid([3,1.25,1]);
    }
    move([-4,0,0]) {
        move([-9,-3.125,2.5]) cuboid([1,1.25,9]);
        move([-7,-3.125,2.5]) cuboid([1,1.25,9]);
        move([-8,-3.125,1 - 3]) cuboid([3,1.25,1]);
    }

    // Switch mount
    move([3,0,0]) {
        difference() {
            move([-3,-3.35,0]) cuboid([30,0.8,15]);

            // Add holes for the cables
            move([12 - 3,-2,0]) ycyl(h=4, d=2.5);
            move([10 - 3,-2,5]) ycyl(h=4, d=2.5);
            move([10 - 3,-2,-5]) ycyl(h=4, d=2.5);
        }
        move([1.75,-1,3.25]) ycyl(h=5, d=2.1);
        move([1.75,-1,-3.25]) ycyl(h=5, d=2.1);
    }

    // Add a spring holder
    move([-8,0,-6.5]) cuboid([4,4.5,1.5], chamfer=0.75, edges=EDGES_Z_ALL+EDGES_TOP);

    // Add V-profiles
    move([-15.5,0,0]) rotate([0,0,90]) v_profile(7.5);
    move([15.5,0,0]) rotate([0,0,-90]) v_profile(7.5);
}

module render_switch_case_top()
{
    difference() {
        move([0,3.3,0]) cuboid([28,0.9,13]);

        // Add holes for the cables
        move([12,2,0]) ycyl(h=4, d=2.5);
        move([10,2,5]) ycyl(h=4, d=2.5);
        move([10,2,-5]) ycyl(h=4, d=2.5);
    }
    
    render_top_cuts();

    // Add joiner V-profile
    move([-5.5,4.2,0]) v_profile(19);
}

module render_top_cuts()
{
    move([14.5,3.3,0]) cuboid([1,0.9,13]);
    move([3,3.3,-7]) cuboid([14,0.9,1]);
    move([-14.5,3.3,0]) cuboid([1,0.9,10]);
    move([6,3.3,7]) cuboid([12,0.9,1]);
}

// Microswitch is a Multicomp DM1-01P-30-3
module render_micro_switch()
{
    // Switch body
    difference() {
        union() {
            color("lightgrey") move([0,-1.75,0]) cuboid([12.8,3,5.8]);
            color([0.2,0.2,0.2]) move([0,1.5,0]) cuboid([12.8,3.5,5.7]);

            // Lever (10 degrees in minimum on position, 17 is maximum off position)
            rotdeg = 8;
            rot([0,0,rotdeg], cp=[-(12.8 / 2) + 1.6,0,0]) move([-(12.8 / 2) + 1.6,3.25,-(5.8 / 2) + (3.2 / 2) - 0.25])
                cuboid([11.5,0.25,3.2], center=false);
        }

        // Mounting holes
        move([-3.25,-3.25 + 1.5,0 - (6 / 2)]) cyl(h=6, d=2.2, center=false);
        move([+3.25,-3.25 + 1.5,0 - (6 / 2)]) cyl(h=6, d=2.2, center=false);
    }

    // Terminals
    color("yellow") {
        move([-5.08,-(6.5 / 2) - 3.3,0]) ycyl(h=3.3, d=0.9, center=false);
        move([-0,-(6.5 / 2) - 3.3,0]) ycyl(h=3.3, d=0.9, center=false);
        move([5.08,-(6.5 / 2) - 3.3,0]) ycyl(h=3.3, d=0.9, center=false);
    }
}

module mini_switch_plunger(printMode)
{
    if (printMode) {
        rotate([-90,0,0]) move([0,-2.25,0]) render_switch_plunger();
    } else {
        color("red") move([-8,0,2.5]) render_switch_plunger();
    }
}

module mini_switch_base(printMode)
{
    if (printMode) {
        rotate([90,0,0]) move([0,3.75,0]) render_switch_case_base();
    } else {
        color("lightgrey") render_switch_case_base();
    }
}

module mini_switch_top(printMode)
{
    if (printMode) {
        rotate([90,0,0]) move([0,-2.75,0]) render_switch_case_top();
    } else {
        color("lightgrey") render_switch_case_top();
    }
}