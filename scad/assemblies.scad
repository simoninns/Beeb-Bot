/************************************************************************

	assemblies.scad
    
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
use <BOSL/metric_screws.scad>

include <pins.scad>
include <alu_profile.scad>
include <plate.scad>
include <mini_switch.scad>
include <hinge.scad>
include <hub.scad>
include <cogs_and_wheels.scad>
include <link.scad>
include <caster_ball.scad>

// Sub-assembly diagrams ----------------------------------------------------------------------------------------------

// 1 - Lower front cross member
module sub_assembly_1(standalone)
{
    move([-60 + 7.5,-60 + 7.5,7.5]) {
        // Bottom front 90mm profile
        move([45 + 7.5,0,-45 + 7.5]) rotate([0,90,0]) alu_profile15(6, false);
    }

    // Left and right inside hinges
    hinge_offset = (standalone) ? 5:0;
    move([-8 - hinge_offset,-45 - 15 - (7.5 / 2),-45 + 15]) rotate([90,0,180]) hinge(false);
    move([+8 + hinge_offset,-45 - 15 - (7.5 / 2),-45 + 15]) rotate([90,0,180]) hinge(false);

    // Sensor mount
    move([0,-45 - 7.5,-7.5]) rotate([0,180,90]) block15(2, false);

    // Left and right switches
    move([-45 + 15 + 5,-45 - 7.5,-45 + (7.5 / 2)]) {
        rotate([90,0,0]) {
            mini_switch_base(false);
            mini_switch_top(false);
            mini_switch_plunger(false);
        }
    }
    move([-45 + 65 + 5,-45 - 7.5,-45 + (7.5 / 2)]) {
        rotate([90,0,0]) {
            mini_switch_base(false);
            mini_switch_top(false);
            mini_switch_plunger(false);
        }
    }

    // Links
    linkpos = standalone ? 0:18;
    rotate([90,0,0]) move([20 + linkpos,-30,45 - 2]) link(1, false);
    rotate([90,0,0]) move([-20 - linkpos,-30,45 - 2]) link(1, false);
}

// 2 - Lower side members
module sub_assembly_2(standalone)
{
    move([-60 + 7.5,-60 + 7.5,7.5]) {
        // Bottom left and right 120mm profiles
        move([0,45 + 7.5,-45 - 7.5]) rotate([90,0,0]) alu_profile15(8, false);
        move([90 + 15,45 + 7.5,-45 - 7.5]) rotate([90,0,0]) alu_profile15(8, false);
    }

    // Left and right spacers
    move([-45 + 2.5,-45 - 7.5,-45]) rotate([0,-90,0]) block5(false);
    move([+45 - 2.5,-45 - 7.5,-45]) rotate([180,-90,0]) block5(false);

    // Links
    xpos1 = (standalone) ? 15:0;
    move([45 + 7.5,48 - 15 - xpos1,-45 + 7.5 + 2]) rotate([180,0,90]) link(1, false);
    move([45 + 7.5,-45 + 15 + xpos1,-45 + 7.5 + 2]) rotate([180,0,90]) link(2, false);

    move([-45 - 7.5,48 - 15 - xpos1,-45 + 7.5 + 2]) rotate([180,0,90]) link(1, false);
    move([-45 - 7.5,-45 + 15 + xpos1,-45 + 7.5 + 2]) rotate([180,0,90]) link(2, false);
}

// 3 - Front vertical legs
module sub_assembly_3(standalone)
{
    move([-60 + 7.5,-60 + 7.5,7.5]) {
        // Left and right front uprights 90mm profiles
        move([0,0,0]) alu_profile15(6, false);
        move([90 + 15,0,0]) alu_profile15(6, false);
    }

    // Left and right outside hinges
    move([-45 - 7.5,-45 - 15 - (7.5 / 2),-45 + 15]) rotate([90,0,180]) hinge(false);
    move([+45 + 7.5,-45 - 15 - (7.5 / 2),-45 + 15]) rotate([90,0,180]) hinge(false);

    // Left wheel mount
    move([-45 - 7.5,-45 + 7.5,-45 + 15]) rotate([90,0,0]) block15(1,false);
    move([-45 - 7.5 + 15,-45 + 7.5,-45 + 15]) rotate([90,0,-90]) block15(1,false);

    // Right wheel mount
    move([45 + 7.5,-45 + 7.5,-45 + 15]) rotate([90,0,0]) block15(1,false);
    move([45 + 7.5 - 15,-45 + 7.5,-45 + 15]) rotate([90,0,90]) block15(1,false);
}

// 4 - Rear vertical legs
module sub_assembly_4(standalone)
{
    move([-60 + 7.5,-60 + 7.5,7.5]) {
        // Left and right back uprights 90mm profiles
        move([0,90+15,0]) alu_profile15(6, false);
        move([90 + 15,90+15,0]) alu_profile15(6, false);
    }

    // Left spacer
    move([-45 + 2.5,45 + 7.5,-45 + 15]) rotate([0,-90,0]) block5(false);

    // Right support
    move([45 - 15,45 + 7.5,-45 + 15]) rotate([0,90,0]) block15(2, false);

    // Bottom right mount
    move([45 + 7.5,45 - 15 + 2.5,-45 + 15]) rotate([-90,0,0]) {
        block15(1,false);
        move([0,0,7.5 + 2.5])block5(false);
    }

    // Bottom left mount
    move([-45 - 7.5,45 - 15 + 2.5,-45 + 15]) rotate([-90,0,0]) {
        block15(1,false);
        move([0,0,7.5 + 2.5]) block5(false);
    }
}

// 5 - Upper side members
module sub_assembly_5(standalone)
{
    move([-60 + 7.5,-60 + 7.5,7.5]) {
        move([0,0,-2]) {
            // Top left and right 90mm profiles
            move([0,45 + 7.5,45 - 7.5]) rotate([90,0,0]) alu_profile15(6, false);
            move([90 + 15,45 + 7.5,45 - 7.5]) rotate([90,0,0]) alu_profile15(6, false);
        }
    }

    // Top left plate
    move([-45 - 7.5,0,45+7.5 - 1]) rotate([0,180,90]) plate15(6, 1, false);

    // Top right plate
    move([45 + 7.5,0,45+7.5 - 1]) rotate([0,180,90]) plate15(6, 1, false);

    // Top left mount
    move([-45 - 7.5,-45 + 15,45 - 15 - 2]) rotate([90,0,0]) block15(2,false);

    // Top right mount
    move([45 + 7.5,-45 + 15,45 - 15 - 2]) rotate([90,0,0]) block15(2,false);

    // Links
    move([45 + 7.5,-30,45 - 7.5 ]) rotate([180,0,90]) link(2, false);
    move([-45 - 7.5,-30,45 - 7.5 ]) rotate([180,0,90]) link(2, false);
}

// 6 - Upper front and rear cross members
module sub_assembly_6(standalone)
{
    move([-60 + 7.5,-60 + 7.5,7.5]) {
        move([0,0,-2]) {
            // Top front and back 90mm profiles
            move([45 + 7.5,0,45 - 7.5]) rotate([0,90,0]) alu_profile15(6, false);
            move([45 + 7.5,90+15,45 - 7.5]) rotate([0,90,0]) alu_profile15(6, false);
        }
    }

    // Top back plate
    move([0,45 + 7.5,45+7.5 - 1]) rotate([0,180,0]) plate15(6, 1, false);

    // Top front plate
    move([0,-45 - 7.5,45+7.5 - 1]) rotate([0,180,0]) plate15(6, 1, false);
}

// 7 - Rear lower member
module sub_assembly_7(standalone)
{
    move([-60 + 7.5,-60 + 7.5,7.5]) {
        // Bottom centre 90mm profile
        move([45 + 7.5,60 - 7.5,-45 - 7.5]) rotate([0,90,0]) alu_profile15(6, false);
    }
}

// 8 - Rear caster support
module sub_assembly_8(standalone)
{
    // Bottom back plate
    move([0,45 + 15 + 1,-45 + 15]) rotate([90,180,0]) plate15(6, 1, false);

    // Left support
    move([-45 + 15 + 5,45 + 7.5,-45 + 15]) rotate([0,-90,0]) block15(2, false);
}

module single_wheel_assembly()
{
    // Axle
    rotate([0,90,0]) color("silver") cyl(h=80, d=4);

    // Wheel
    move([40 - 7.5,0,0]) {
        move([0,0,0]) rotate([0,90,0]) hub_top(false);
        move([-2,0,0]) rotate([0,90,0]) large_pulley_wheel(false);
        move([-4,0,0]) rotate([0,90,0]) hub_base(false);
    }

    // Locking washers
    move([40 - 13 ,0,0]) {
        move([0 ,0,0]) rotate([0,90,0]) locking_washer(false);
        move([-2.1 ,0,0]) rotate([0,90,0]) locking_washer(false);
    }
    
    // V-axle joiners
    move([40 - 14,0,16.5]) rotate([0,90,0]) color("red") single_vaxle();
    rotate([120,0,0]) move([40 - 14,0,16.5]) rotate([0,90,0]) color("red") single_vaxle();
    rotate([240,0,0]) move([40 - 14,0,16.5]) rotate([0,90,0]) color("red") single_vaxle();
    
    // Gear
    move([40 - 18.5 ,0,0]) {
        rotate([0,90,0]) gear_wheel(false);
        move([2,0,0]) rotate([0,-90,0]) hub_base(false);
        move([-1.5,0,0]) rotate([0,-90,0]) hub_top(false);
    }

    // Inside clips
    move([-30,0,0]) rotate([0,90,0]) clip10(false);

    // O-ring tyres
    move([30.5,0,0]) rotate([0,90,0]) color([0.2,0.2,0.2]) torus(d=62.5, d2=3);

    // M4 washers
    move([11,0,0]) rotate([0,90,0]) color("grey") tube(h=0.75, id=5, od=7);
    move([10,0,0]) rotate([0,90,0]) color("grey") tube(h=0.75, id=5, od=7);
    move([-24.5,0,0]) rotate([0,90,0]) color("grey") tube(h=0.75, id=5, od=7);
}

// 9 - Driving wheels assembly
module sub_assembly_9(standalone)
{
    // Left wheel assembly
    move([0,-45 - 15 - 4,0]) rotate([0,0,180]) move([51 + 2,-45 + 15 - 2,-45 + 15]) single_wheel_assembly();

    // right wheel assembly
    move([51 + 2,-45 + 15 - 2,-45 + 15]) single_wheel_assembly();
}

// 10 - Ball caster assembly
module sub_assembly_10(standalone)
{
    // If display is standalone, include the other assemblies
    // to make things clearer
    if (standalone) {
        sub_assembly_2(false);
        sub_assembly_4(false);
        sub_assembly_8(false);
    }

    // Spacers
    move([45 - 30 + (7.5 / 4),45 + 7.5,-45 + 7.5 - 5]) clip10(false);
    move([ -45 + 30 + (7.5 / 2),45 + 7.5,-45 + 7.5 - 5]) clip10(false);

    // Screws
    move([2.5,45 + 7.5,-45 - 7.5]) rotate([0,180,0]) color("darkgrey") {
        move([14.5,0,0]) screw(screwsize=4,screwlen=35,headsize=8,headlen=3, align="base");
        move([-14.5,0,0]) screw(screwsize=4,screwlen=35,headsize=8,headlen=3, align="base");

        move([14.5,0,-33.5]) metric_nut(size=4, hole=true);
        move([-14.5,0,-33.5]) metric_nut(size=4, hole=true);
    }

    // Holder
    move([3,45 + 15 + 1,-45 - 5]) caster_ball_holder(false);

    // Ball holder
    move([3,45 + 15 + 1,-45 - 2]) {
        caster_ball_base(false);
        caster_ball_top(false);

        // Add bearing
        caster_ball_bearing(false);
    }

    // Support
    move([-45 + 7.5,45 + 7.5,-45]) rotate([0,90,180]) blockv15(false);
    move([45 - 7.5,45 + 7.5,-45]) rotate([90,180,90]) blockv15(false);

    // Links
    move([-45 + 7.5 + 5,45 + 7.5,-39]) rotate([0,0,0]) link(1, false);
    move([45 - 7.5 - 5,45 + 7.5,-39]) rotate([0,0,0]) link(1, false);
}

// 11 - Front bumper assembly
module sub_assembly_11(standalone)
{
    // If display is standalone, include the other assemblies
    // to make things clearer
    if (standalone) {
        sub_assembly_1(false);
        sub_assembly_3(false);
    }

    // Left and right bumper plates
    move([-45.5,-45 - 15 - 7.5 - 1,-45 + 15]) rotate([-90,0,0]) plate15(6, 2, false);
    move([45.5,-45 - 15 - 7.5 - 1,-45 + 15]) rotate([-90,0,0]) plate15(6, 2, false);

    // Switch raisers
    move([-45 + 7,-45 - 15 - (7.5 / 2),-45 + 9]) rotate([90,90,0]) block7p5(false);
    move([45 + 8 - 30,-45 - 15 - (7.5 / 2),-45 + 9]) rotate([90,90,0]) block7p5(false);
}

// 12 - Motors and gears
// Note: This renders a model of the original Philips Stepper Motor
module render_single_motor()
{
    $fn=60; 

    color("DarkKhaki") {
        // Body
        cyl(h=33.5 - 1.5, d=56.3);

        // Hub
        move([0,0,(33.5 / 2) + 1.5]) cyl(h=1.5, d=12);
        move([0,0,-(33.5 / 2)]) cyl(h=1.5, d=12);
    }

    // Face plate
    color("khaki") {
        difference() {
            move([0,0,(33.5 / 2)]) rotate([90,0,0]) {
                teardrop(r=54 / 2, h=1.5, ang=40, cap_h=38);
                rotate([180,0,0]) teardrop(r=54 / 2, h=1.5, ang=40, cap_h=38);
            }

            move([0,33 + 2,(33.5 / 2)]) rotate([0,0,90]) slot(l=4, r1=2.2, r2=2.2, h=5);
            move([0,-33 - 2,(33.5 / 2)]) rotate([0,0,90]) slot(l=4, r1=2.2, r2=2.2, h=5);
        }
    }

    color("silver") {
        // Spindle
        move([0,0,(33.5 / 2) + 8]) cyl(h=16, d=4);
        move([0,0, -(33.5 / 2) - 1.5]) cyl(h=2, d=4);
    }

    // Add cog wheel to shaft
    rotate([0,0,0]) move([0,0,44]){
        cog_wheel_bottom(false);
        move([0,0,-14.5]) rotate([180,0,0]) cog_wheel_top(false);
    }
}

module sub_assembly_12(standalone)
{
    // If display is standalone, include the other assemblies
    // to make things clearer
    if (standalone) {
        sub_assembly_5(false);
        sub_assembly_4(false);
    }

    // Motor right
    rotate([0,-90, 0]) move([0,0,45]) {
        // Tweak the motor alignment
        move([-1.5,5.75,0]) rotate([0,0,52.5]) render_single_motor();
    }

    // Motor left
    rotate([0, 90 , 0]) move([2.75,0.25,45]) {
        // Tweak the motor alignment
        move([-1.5,5.75,0]) rotate([0,0,-52.5]) render_single_motor();
    }

    // Screws right
    color("darkgrey") {
        move([-45 - 15 - 2.5,-45 + 30 - 2,45 - 15 - 2.5]) rotate([180,90,0]) screw(screwsize=4,screwlen=25,headsize=8,headlen=3, align="base");
        move([-41.75,-45 + 30 - 2,45 - 15 - 2.5]) rotate([180,90,0]) metric_nut(size=4, hole=true);

        move([-45 - 15 - 2.5,45 - 20 + 2,-45 + 15]) rotate([180,90,0]) screw(screwsize=4,screwlen=25,headsize=8,headlen=3, align="base");
        move([-41.75,45 - 20 + 2,-45 + 15]) rotate([180,90,0]) metric_nut(size=4, hole=true);
    }

    // Screws left
    color("darkgrey") {
        move([45 + 15 + 2.5,-45 + 30 - 2,45 - 15 - 2.5]) rotate([0,90,0]) screw(screwsize=4,screwlen=25,headsize=8,headlen=3, align="base");
        move([44.75,-45 + 30 - 2,45 - 15 - 2.5]) rotate([180,90,0]) metric_nut(size=4, hole=true);

        move([45 + 15 + 2.5,45 - 20 + 2,-45 + 15]) rotate([0,90,0]) screw(screwsize=4,screwlen=25,headsize=8,headlen=3, align="base");
        move([44.75,45 - 20 + 2,-45 + 15]) rotate([180,90,0]) metric_nut(size=4, hole=true);
    }
}

// 13 - PCB supports
module sub_assembly_13(standalone)
{
    move([45+7.5,-45 - 7.5,45+7.5 + 2.5]) rotate([0,0,90]) block5(false);
    move([45+7.5,45 + 7.5,45+7.5 + 2.5]) rotate([0,0,90]) block5(false);
    move([-45-7.5,-45 - 7.5,45+7.5 + 2.5]) rotate([0,0,90]) block5(false);
    move([-45-7.5,45 + 7.5,45+7.5 + 2.5]) rotate([0,0,90]) block5(false);
}

// 14 - Sensors
module sub_assembly_14(standalone)
{
    // If display is standalone, include the other assemblies
    // to make things clearer
    if (standalone) {
        sub_assembly_1(false);
        sub_assembly_3(false);
    }

    // Barcode reader mount
    move([0,-45 - 38, 0]) rotate([90,0,90]) hinged_block(false);
}

module sub_assembly_complete()
{
    sub_assembly_1(false);
    sub_assembly_2(false);
    sub_assembly_3(false);
    sub_assembly_4(false);
    sub_assembly_5(false);
    sub_assembly_6(false);
    sub_assembly_7(false);
    sub_assembly_8(false);
    sub_assembly_9(false);
    sub_assembly_10(false);
    sub_assembly_11(false);
    sub_assembly_12(false);
    sub_assembly_13(false);
    sub_assembly_14(false);
}

// Assembly diagrams --------------------------------------------------------------------------------------------------

module assembly_step_1()
{
    sub_assembly_1(false);
    sub_assembly_3(false);
}

module assembly_step_2()
{
    sub_assembly_1(false);
    sub_assembly_2(true);
    sub_assembly_3(false);
}

module assembly_step_3()
{
    sub_assembly_1(false);
    sub_assembly_2(false);
    sub_assembly_3(false);
}

module assembly_step_4()
{
    sub_assembly_1(false);
    sub_assembly_2(false);
    sub_assembly_3(false);
    sub_assembly_4(false);
}

module assembly_step_5()
{
    sub_assembly_1(false);
    sub_assembly_2(false);
    sub_assembly_3(false);
    sub_assembly_4(false);
    sub_assembly_5(false);
}

module assembly_step_6()
{
    sub_assembly_1(false);
    sub_assembly_2(false);
    sub_assembly_3(false);
    sub_assembly_4(false);
    sub_assembly_5(false);
    sub_assembly_6(false);
}

module assembly_step_7()
{
    sub_assembly_1(false);
    sub_assembly_2(false);
    sub_assembly_3(false);
    sub_assembly_4(false);
    sub_assembly_5(false);
    sub_assembly_6(false);
    sub_assembly_7(false);
}

module assembly_step_8()
{
    sub_assembly_1(false);
    sub_assembly_2(false);
    sub_assembly_3(false);
    sub_assembly_4(false);
    sub_assembly_5(false);
    sub_assembly_6(false);
    sub_assembly_7(false);
    sub_assembly_8(false);
    sub_assembly_10(false);
}

module assembly_step_9()
{
    sub_assembly_1(false);
    sub_assembly_2(false);
    sub_assembly_3(false);
    sub_assembly_4(false);
    sub_assembly_5(false);
    sub_assembly_6(false);
    sub_assembly_7(false);
    sub_assembly_8(false);
    sub_assembly_10(false);
    sub_assembly_9(false);
}