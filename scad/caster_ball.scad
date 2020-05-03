/************************************************************************

	caster_ball.scad
    
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

// Caster ball holder -------------------------------------------------------------------------------------------------

module render_caster_body()
{
    thk = 5;
    ang = 15;
    cutpoint = 5;
    difference() {
        union() {
            difference() {
                move([0,0,0]) cyl(h=thk,d=64);
                move([-32,cutpoint,-thk]) cuboid([64,40,thk*2], center=false);
            }
            move([0,0,0]) cyl(h=thk,d=25+14);
        }
        // Add the main hole
        move([0,0,0]) cyl(h=thk*2,d=25.5);

        // Slice the two edge angles
        move([18.8,cutpoint - 50,-thk]) rot([0,0,ang], cp=[0,50,0]) cuboid([25,50, thk*2], center=false);
        rotate([0,180,0]) move([18.8,cutpoint - 50,-thk]) rot([0,0,ang], cp=[0,50,0]) cuboid([25,50, thk*2], center=false);
    }
}

// Note: This is similar to the inner hub used in the cogs, but this part
// seems to be a specific modification for the robot
module render_caster_inner_hub()
{
    rotate([0,0,45]) difference() {
        move([0,0,0]) tube(h = 5, od=25.5, id=24, center=true);

        move([0,0,1]) cyl(h=1, d1=22, d2=25.5);
        move([0,0,2.5]) cyl(h=2.1, d=25.5);

        rotate([0,180,0]){
            move([0,0,1]) cyl(h=1, d1=22, d2=25.5);
            move([0,0,2.5]) cyl(h=2.1, d=25.5);
        }

        rotate([0,0,45]) cuboid([30,3,6]);
        rotate([0,0,-45]) cuboid([30,3,6]);
    }
}

module render_caster_fins()
{
    gap = 5.5;
    rotpos = [
        -(gap) * 1, +(gap * 1),
        -(gap) * 3, +(gap * 3),
        -(gap) * 5, +(gap * 5),
        -(gap) * 7, +(gap * 7),
        -(gap) * 9, +(gap * 9),
        -(gap) * 11, +(gap * 11)
        ];

    rotate([0,0,-90]) {
        zrot_copies(rots=rotpos, r=44/2, subrot=true) {
                move([0,-0.5,2.5]) cuboid([4,1,3], center=false, chamfer = 0.25, edges = EDGES_Z_ALL);
        }
    }
}

// Note: The original part has a pin on the lower side (which isn't 
// used), so this is missing to make the part printable
module render_caster_ball_holder()
{
    difference() {
        render_caster_body();

        // 3x 4mm holes around the circumference of the hub
        zrot_copies(rots=[210,270,330], r=33/2, subrot=false) {
            zcyl(h=6, d=4);

            // Bevel the top and bottom of the hole
            move([0,0,-2.5]) zcyl(h=.51, d1=5,d2=4);
            move([0,0,2.5]) zcyl(h=.51, d1=4,d2=5);
        }
    }

    render_caster_inner_hub();

    render_caster_fins();
}

module caster_ball_holder(printMode)
{
    $fn=60;
    if (printMode) {
        move([0,0,2.5]) render_caster_ball_holder();
    } else {
        color("lightgrey") render_caster_ball_holder();
    }
}

// Caster ball --------------------------------------------------------------------------------------------------------

module render_ball_bearing(diameter)
{
    staggered_sphere(d=diameter, circum=true, $fn=60);
}

module render_caster_ball_base()
{
    difference() { 
        union() {
            move([0,0,-6.5]) cyl(h=2,d=30, chamfer=0.5); // Lip
            move([0,0,-10.5]) cyl(h=3,d1=16, d2=24, chamfer1=0.5, center=false); // Ball chamfer
        }

        // 2x 8mm holes around the circumference of the hub
        move([0,0,-6.5]) zrot_copies(rots=[210,330], r=33/2, subrot=false) {
            zcyl(h=6, d=8);
        }

        move([0,0,-3.5]) render_ball_bearing(20.5);
        render_caster_ball_top();
    }
}

module render_caster_ball_top()
{
    difference() { 
        union() {
            move([0,0,1]) {
                cyl(h=14,d=24);
            
                // Rotation locks
                rotate([0,0,180]) cuboid([25,2.5,14]);
                rotate([0,0,-90]) cuboid([25,2.5,14]);
            }
        }

        move([0,0,-3.5]) render_ball_bearing(20.5);
    }
}

module caster_ball_base(printMode)
{
    $fn=60;
    if (printMode) {
        move([0,0,5.5]) render_caster_ball_base();
    } else {
        color("lightgrey") render_caster_ball_base();
        color("lightgrey") render_caster_ball_top();
    }
}

module caster_ball_top(printMode)
{
    $fn=60;
    if (printMode) {
        move([0,0,-8]) render_caster_ball_top();
    } else {
        color("lightgrey") render_caster_ball_base();
        color("lightgrey") render_caster_ball_top();
    }
}