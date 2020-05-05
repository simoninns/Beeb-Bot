/************************************************************************

	mockup.scad
    
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

include <common.scad>
include <alu_profile.scad>
include <plate.scad>
include <mini_switch.scad>
include <hinge.scad>
include <hub.scad>
include <cogs_and_wheels.scad>
include <cover.scad>

module mock_frame()
{
    // Centre frame on axis
    move([-60 + 7.5,-60 + 7.5,7.5]) {
        // Left and right front uprights 90mm profiles
        move([0,0,0]) alu_profile15(6, false);
        move([90 + 15,0,0]) alu_profile15(6, false);

        // Left and right back uprights 90mm profiles
        move([0,90+15,0]) alu_profile15(6, false);
        move([90 + 15,90+15,0]) alu_profile15(6, false);

        move([0,0,-2]) {
            // Top front and back 90mm profiles
            move([45 + 7.5,0,45 - 7.5]) rotate([0,90,0]) alu_profile15(6, false);
            move([45 + 7.5,90+15,45 - 7.5]) rotate([0,90,0]) alu_profile15(6, false);
            
            // Top left and right 90mm profiles
            move([0,45 + 7.5,45 - 7.5]) rotate([90,0,0]) alu_profile15(6, false);
            move([90 + 15,45 + 7.5,45 - 7.5]) rotate([90,0,0]) alu_profile15(6, false);
        }

        // Bottom left and right 120mm profiles
        move([0,45 + 7.5,-45 - 7.5]) rotate([90,0,0]) alu_profile15(8, false);
        move([90 + 15,45 + 7.5,-45 - 7.5]) rotate([90,0,0]) alu_profile15(8, false);

        // Bottom front 90mm profile
        move([45 + 7.5,0,-45 + 7.5]) rotate([0,90,0]) alu_profile15(6, false);
        //move([45 + 7.5,90+15,-45 + 7.5]) rotate([0,90,0]) alu_profile15(6, false);

        // Bottom centre 90mm profile
        move([45 + 7.5,60 - 7.5,-45 - 7.5]) rotate([0,90,0]) alu_profile15(6, false);
    }
}

module mock_build_plate_decoration()
{
    // Top back plate
    move([0,45 + 7.5,45+7.5 - 1]) rotate([0,180,0]) plate15(6, 1, false);

    // Top front plate
    move([0,-45 - 7.5,45+7.5 - 1]) rotate([0,180,0]) plate15(6, 1, false);

    // Top left plate
    move([-45 - 7.5,0,45+7.5 - 1]) rotate([0,180,90]) plate15(6, 1, false);

    // Top right plate
    move([45 + 7.5,0,45+7.5 - 1]) rotate([0,180,90]) plate15(6, 1, false);

    // Bottom back plate
    move([0,45 + 15 + 1,-45 + 15]) rotate([90,180,0]) plate15(6, 1, false);
}

module mock_back_support()
{
    // Left spacer
    move([-45 + 2.5,45 + 7.5,-45 + 15]) rotate([0,-90,0]) block5(false);

    // Left support
    move([-45 + 15 + 5,45 + 7.5,-45 + 15]) rotate([0,-90,0]) block15(2, false);

    // Right support
    move([45 - 15,45 + 7.5,-45 + 15]) rotate([0,90,0]) block15(2, false);

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
        caster_ball_base();
        caster_ball_top();
    }

    // Support
    move([-45 + 7.5,45 + 7.5,-45]) rotate([0,90,180]) blockv15(false);
    move([45 - 7.5,45 + 7.5,-45]) rotate([90,180,90]) blockv15(false);
}

module mock_switch()
{
    rotate([90,0,0]) {
        mini_switch_base(false);
        mini_switch_top(false);
        mini_switch_plunger(false);
    }
}

module mock_front_bumpers()
{
    // Left and right spacers
    move([-45 + 2.5,-45 - 7.5,-45]) rotate([0,-90,0]) block5(false);
    move([+45 - 2.5,-45 - 7.5,-45]) rotate([180,-90,0]) block5(false);

    // Left and right switches
    move([-45 + 15 + 5,-45 - 7.5,-45 + (7.5 / 2)]) mock_switch();
    move([-45 + 65 + 5,-45 - 7.5,-45 + (7.5 / 2)]) mock_switch();

    // Left and right outside hinges
    move([-45 - 7.5,-45 - 15 - (7.5 / 2),-45 + 15]) rotate([90,0,180]) hinge(false);
    move([+45 + 7.5,-45 - 15 - (7.5 / 2),-45 + 15]) rotate([90,0,180]) hinge(false);

    // Left and right inside hinges
    move([-8,-45 - 15 - (7.5 / 2),-45 + 15]) rotate([90,0,180]) hinge(false);
    move([+8,-45 - 15 - (7.5 / 2),-45 + 15]) rotate([90,0,180]) hinge(false);

    // Left and right bumper plates
    move([-45.5,-45 - 15 - 7.5 - 1,-45 + 15]) rotate([-90,0,0]) plate15(6, 2, false);
    move([45.5,-45 - 15 - 7.5 - 1,-45 + 15]) rotate([-90,0,0]) plate15(6, 2, false);

    // Switch raisers
    move([-45 + 7,-45 - 15 - (7.5 / 2),-45 + 9]) rotate([90,90,0]) block7p5(false);
    move([45 + 8 - 30,-45 - 15 - (7.5 / 2),-45 + 9]) rotate([90,90,0]) block7p5(false);

    // Sensor mount
    move([0,-45 - 7.5,-7.5]) rotate([0,180,90]) block15(2, false);
}

module mock_wheel_assembly()
{
    // Axle
    rotate([0,90,0]) color("silver") cyl(h=80, d=4);

    // Wheel
    move([40 - 7.5,0,0]) rotate([0,90,0]) hub_top(false);
    move([40 - 7.5 - 2,0,0]) rotate([0,90,0]) large_pulley_wheel(false);
    move([40 - 7.5 - 4,0,0]) rotate([0,90,0]) hub_base(false);
    
    // V-axle joiners
    move([40 - 15,0,16.5]) rotate([0,90,0]) color("red") single_vaxle();
    rotate([120,0,0]) move([40 - 15,0,16.5]) rotate([0,90,0]) color("red") single_vaxle();
    rotate([240,0,0]) move([40 - 15,0,16.5]) rotate([0,90,0]) color("red") single_vaxle();
    
    // Gear
    move([40 - 20.5 ,0,0]) rotate([0,90,0]) gear_wheel(false);
    move([40 - 19,0,0]) rotate([0,-90,0]) hub_base(false);
    move([40 - 22,0,0]) rotate([0,-90,0]) hub_top(false);

    // Inside clips
    move([-29,0,0]) rotate([0,90,0]) clip10(false);

    // O-ring tyres
    move([30.5,0,0]) rotate([0,90,0]) color([0.2,0.2,0.2]) torus(d=62.5, d2=3);
}

module mock_wheels()
{
    // Left wheel mount
    move([-45 - 7.5,-45 + 7.5,-45 + 15]) rotate([90,0,0]) block15(1,false);
    move([-45 - 7.5 + 15,-45 + 7.5,-45 + 15]) rotate([90,0,-90]) block15(1,false);

    // Right wheel mount
    move([45 + 7.5,-45 + 7.5,-45 + 15]) rotate([90,0,0]) block15(1,false);
    move([45 + 7.5 - 15,-45 + 7.5,-45 + 15]) rotate([90,0,90]) block15(1,false);

    // Left wheel assembly
    move([0,-45 - 15 - 4,0]) rotate([0,0,180]) move([51 + 2,-45 + 15 - 2,-45 + 15]) mock_wheel_assembly();

    // right wheel assembly
    move([51 + 2,-45 + 15 - 2,-45 + 15]) mock_wheel_assembly();
    
}

module mock_motor_mounts()
{
    // Top left mount
    move([-45 - 7.5,-45 + 15,45 - 15 - 2]) rotate([90,0,0]) block15(2,false);

    // Top right mount
    move([45 + 7.5,-45 + 15,45 - 15 - 2]) rotate([90,0,0]) block15(2,false);

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

// Note: This renders a model of the original Philips Stepper Motor
module mock_motor()
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
    rotate([0,0,0]) move([0,0,42]){
        cog_wheel_bottom(false);
        move([0,0,-14.5]) rotate([180,0,0]) cog_wheel_top(false);
    }
}

module mock_drive_motors()
{
    // Motor right
    rotate([0,-90, 0]) move([0,0,45]) {
        // Tweak the motor alignment
        move([-1.5,5.75,0]) rotate([0,0,52.5]) mock_motor();
    }

    // Motor left
    rotate([0, 90 , 0]) move([2.75,0.25,45]) {
        // Tweak the motor alignment
        move([-1.5,5.75,0]) rotate([0,0,-52.5]) mock_motor();
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

module mock_pcb_holders()
{
    move([45+7.5,-45 - 7.5,45+7.5 + 2.5]) rotate([0,0,90]) block5(false);
    move([45+7.5,45 + 7.5,45+7.5 + 2.5]) rotate([0,0,90]) block5(false);
    move([-45-7.5,-45 - 7.5,45+7.5 + 2.5]) rotate([0,0,90]) block5(false);
    move([-45-7.5,45 + 7.5,45+7.5 + 2.5]) rotate([0,0,90]) block5(false);
}

module mock_cover()
{
    move([0,0,45 + 1 + 7.5]) cover(false);
}

module render_mock_up()
{
    mock_frame();
    mock_build_plate_decoration();
    mock_back_support();
    mock_front_bumpers();
    mock_wheels();
    mock_motor_mounts();
    mock_drive_motors();
    mock_pcb_holders();
    mock_cover();
}

module mock_up()
{
    render_mock_up();
}