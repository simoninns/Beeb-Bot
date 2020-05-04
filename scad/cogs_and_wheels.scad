/************************************************************************

	cogs_and_wheels.scad
    
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
use <BOSL/involute_gears.scad>

include <common.scad>

// Note: The inner hub is common to both the gear_wheel and the large_pulley_wheel
module inner_hub()
{
    rotate([0,0,45]) difference() {
        union() {
            oc1 = 24; // outer diameter
            cir1 = 2 * 3.141 * ((oc1 - 2) / 2);
            nt1 = 24; // number of teeth

            difference() {
                cyl(h=1, d=oc1 - 2);
                gear(mm_per_tooth=cir1/nt1, number_of_teeth=nt1, thickness=2, pressure_angle=25, backlash=0.1, hole_diameter=0, interior=true); 

                rotate([0,0,45]) cuboid([30,5,5]);
                rotate([0,0,-45]) cuboid([30,5,5]);
            }

            move([0,0,0]) tube(h = 5, od=25.5, id=22, center=true);
        }

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

// Large Pully Wheel - 60mm diameter, 5.5mm height --------------------------------------------------------------------

module render_grey_axle(displayMode)
{
    if (displayMode) {
        rotate([0,0,30]) zrot_copies(rots=[0,60,120,180,240,300], r=33.5 - 16, subrot=true) {
            move([4.5,0,0]) rotate([0,90,0]) cyl(h=15,d=4,fillet2=0.5);
        }
    } else {
        for(xpos = [0:4.5:7*4.5]) {
            move([xpos,0,0]) cyl(h=15,d=4,fillet2=0.5);
        }
        move([15,0,-(15/2) + (1.2/2)]) cuboid([7*4.5,0.6,1.2]);
    }
}

module render_large_pulley_wheel()
{
    width = 61.5;
    groove = 4;

    difference() {
        union() {
            move([0,0,2]) cyl(h=1,d=width, chamfer1 = 0, chamfer2 = 0.5);
            move([0,0,1]) cyl(h=1, d1=width - groove, d2=width);
            move([0,0,0]) cyl(h=3,d=width - groove);
            move([0,0,-1]) cyl(h=1, d1=width, d2=width - groove);
            move([0,0,-2]) cyl(h=1,d=width, chamfer1 = 0.5, chamfer2 = 0);
        }

        // 6x 4mm holes around the circumference of the gear
        zrot_copies(rots=[0,60,120,180,240,300], r=33/2, subrot=false) {
            zcyl(h=6, d=4);

            // Bevel the top and bottom of the hole
            move([0,0,-2.5]) zcyl(h=.51, d1=5,d2=4);
            move([0,0,2.5]) zcyl(h=.51, d1=4,d2=5);
        }

        render() zrot_copies(rots=[0,60,120,180,240,300], r=0, subrot=true) {
            arced_slot(d=42 + 2.5, h=7, sd=4, sa=-17.5, ea=17.5);
        }

        // Horizontal holes around the edge of the wheel (30 degree offset from vertical holes)
        rotate([0,0,30]) zrot_copies(rots=[0,60,120,180,240,300], r=39.5 - (15 + 2.5), subrot=true) {
            move([0,0,0]) xcyl(h=15,d=4);
            move([15.5 - 11,0,0]) cuboid([13,3,6]); // Distance is 11mm
            move([7.5,0,0]) cyl(h=6, d=4);
            move([8.5,0,0]) cuboid([2,4,6]);
        }

        // Add hole for inner hub
        cyl(h=6, d=25.5);
    }

    // Render the inner hub
    inner_hub();
}

module large_pulley_wheel(printMode)
{
    $fn=60;

    if (printMode) {
        render_large_pulley_wheel();
    } else {
        color("red") render_large_pulley_wheel();
        color("lightgrey") render_grey_axle(true);
    }
}

// The grey axles are decoration pieces that go around the
// outside edge of the large pulley wheel
module grey_axle(printMode)
{
    if (printMode) {
        move([0,0,7.5]) render_grey_axle(false);
    } else {
        color("lightgrey") render_grey_axle(false);
    }
}

// Gear wheel Z30, m 1.5 ----------------------------------------------------------------------------------------------

module render_gear_wheel()
{
    oc1 = 47 - 2; // outer diameter
    cir1 = 2 * 3.1415927 * (oc1 / 2);
    nt1 = 30; // number of teeth
    difference() {
        rotate([0,0,7.5]) gear(mm_per_tooth=cir1/nt1, number_of_teeth=nt1, thickness=5, pressure_angle=20, backlash=0.1, hole_diameter=25.5);  

        // 3x 4mm holes around the circumference of the gear
        zrot_copies(rots=[0,120,240], r=33/2, subrot=false) {
            zcyl(h=6, d=4);

            // Bevel the top and bottom of the hole
            move([0,0,-2.5]) zcyl(h=.51, d1=5,d2=4);
            move([0,0,2.5]) zcyl(h=.51, d1=4,d2=5);
        }

        // The arcs are slow to plot, so use render() to speed up preview
        render() move([0,0,6 - 4]) {
            rotate([0,0,20]) arced_slot(d=33, h=7, sd=3.5, sa=0, ea=80);
            rotate([0,0,140]) arced_slot(d=33, h=7, sd=3.5, sa=0, ea=80);
            rotate([0,0,260]) arced_slot(d=33, h=7, sd=3.5, sa=0, ea=80);
        }

        // Upper bevel edge (on gear teeth)
        move([0,0,2]) {
            difference() {
                move([0,0,0.1]) cyl(h=1.1, d=48.25);
                cyl(h=1, d1=48.25, d2=41.35);
                cyl(h=1, d=41.35);
            }
        }

        // Lower bevel edge (on gear teeth)
        rotate([0,180,0]) move([0,0,2]) {
            difference() {
                move([0,0,0.1]) cyl(h=1.1, d=48.25);
                cyl(h=1, d1=48.25, d2=41.35);
                cyl(h=1, d=41.35);
            }
        }
    }

    // Render the inner hub
    inner_hub();
}

module gear_wheel(printMode)
{
    $fn=60;

    if (printMode) {
        render_gear_wheel();
    } else {
        color([0.2,0.2,0.2]) render_gear_wheel();
    }
}

// Cog Wheel Z10, m 1.5 with collett ----------------------------------------------------------------------------------

module render_cog_gear()
{
    oc1 = 17 - 2.75; // outer diameter
    cir1 = 2 * 3.1415927 * (oc1 / 2);
    nt1 = 10; // number of teeth
    rotate([0,0,7.5]) gear(mm_per_tooth=cir1/nt1, number_of_teeth=nt1, thickness=5, pressure_angle=20, backlash=0.1, hole_diameter=4);

    // Bevel the top and bottom of the hole
    //move([0,0,-2.5]) zcyl(h=.51, d1=5,d2=4);
    //move([0,0,2.5]) zcyl(h=.51, d1=4,d2=5);
}

module render_cog_wheel()
{
    render_cog_gear();

    move([0,0,-7.5]) cyl(h=10, d=11);
}

// Note: This is the piece designed to fit to the shaft of the original stepper-motors
module cog_wheel(printMode)
{
    $fn=60;

    if (printMode) {
        render_cog_wheel();
    } else {
        color([0.2,0.2,0.2]) render_cog_wheel();
    }
}

// 4mm axel locking washer --------------------------------------------------------------------------------------------

module render_locking_washer()
{
    difference() {
        union() {
            oc1 = 11 - 1; // outer diameter
            cir1 = 2 * 3.1415927 * (oc1 / 2);
            nt1 = 16; // number of teeth

            gear(mm_per_tooth=cir1/nt1, number_of_teeth=nt1, thickness=2, pressure_angle=1, backlash=0.01, hole_diameter=4);
            cyl(h=2,d=9.5);
        }

        cyl(h=3,d=4);
        cuboid([6,3,4]);
        move([0,0,1]) cyl(h=1, d=6);
    }

    difference() {
        union() {
            move([2.5,1.75,0.75]) cyl(h=1, d=1);
            move([-2.5,1.75,0.75]) cyl(h=1, d=1);
            move([2.5,-1.75,0.75]) cyl(h=1, d=1);
            move([-2.5,-1.75,0.75]) cyl(h=1, d=1);
        }

        cuboid([6,3,4]);
    }
}

module locking_washer(printMode)
{
    if (printMode) {
        $fn=60;
        render_locking_washer();
    } else {
        color("red") render_locking_washer();
    }
}

// V-axel -------------------------------------------------------------------------------------------------------------

module single_vaxle()
{
    difference() {
        union() {
            cyl(h=17, d=4);
            move([0,0,(17/2 - 0.5)]) cyl(h=1,d=4.5, chamfer1=0.25);
            move([0,0,-(17/2 - 0.5)]) cyl(h=1,d=4.5, chamfer2=0.25);
        }

        move([0,0,(17/2 - 2)]) cuboid([6,1,6], chamfer=0.25);
        move([0,0,-(17/2 - 2)]) cuboid([6,1,6], chamfer=0.25);
    }
}

// Render 6 V axles
module render_vaxle()
{
    for(ypos = [0:5:5*5]) {
        move([0,ypos,0]) single_vaxle();
    }
}

module vaxle(printMode)
{
    if (printMode) {
        $fn=9;
        move([0,0,2]) rotate([0,-90,0]) render_vaxle();
    } else {
        $fn=9;
        color("red") render_vaxle();
    }
}

// Clip 10 ------------------------------------------------------------------------------------------------------------

module render_clip10()
{
    difference() {
        cyl(h=10, d=7.5);
        cyl(h=11, d=4);
        move([2.5,0,0]) cuboid([3,3,12]);
        move([3.75,0,0]) cuboid([2,8,12]);
        move([-3,0,5.5]) cuboid([4,1,3]);
    }    
}

module clip10(printMode)
{
    if (printMode) {
        move([0,0,5]) render_clip10();
    } else {
        color("red") render_clip10();
    }
}