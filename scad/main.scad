/************************************************************************

	main.scad
    
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

include <alu_profile.scad>
include <block.scad>
include <plate.scad>
include <link.scad>
include <hub.scad>
include <hinge.scad>
include <cogs_and_wheels.scad>
include <mini_switch.scad>
include <caster_ball.scad>
include <chain.scad>
include <cover.scad>
include <assemblies.scad>
include <diagrams.scad>
include <nema17.scad>

/* [Main] */
// What should be displayed?
display_mode = "Parts"; // [Parts, Assembly steps]

/* [Parts] */
// Display parts ready for printing?
printMode = false;

// Aluminium profiles:
choose_alu = "None"; // [None, 90mm Profile, 120mm Profile, End cap, End cap x28]

// Blocks:
choose_block = "None"; // [None, 5mm Block, 7.5mm Block, 15mm Block, 30mm Block, V15 Block]

// Build plates:
choose_plate = "None"; // [None, 30x90mm single row plate, 15x90mm single row plate]

// Links:
choose_link = "None"; // [None, 15mm link, 30mm link]

// Hinges:
choose_hinge = "None"; // [None, Small hinge, Hinged block]

// Gear hubs:
choose_hub = "None"; // [None, Hub base, Hub top]

// Gears, wheels and accessories:
choose_gear = "None"; // [None, Large pulley wheel, Grey axle, Cog wheel top, Cog wheel bottom, Gear wheel, Locking washer, V axle, 10mm axle clip]

// Mini-Switch:
choose_switch = "None"; // [None, Mini switch plunger, Mini switch base, Mini switch top]

// Ball caster:
choose_caster = "None"; // [None, Ball caster holder, Ball caster base, Ball caster top]

// Drive chain:
choose_chain = "None"; // [None, Drive chain]

// Cover - Not complete:
choose_cover = "None"; // [None, Cover]

// Motor - Not complete:
choose_motor = "None"; // [None, NEMA 17]

/* [Assembly guide] */
// Display a sub-assembly diagram:
choose_sub_assembly = "None"; // [None, 1 - Lower front cross member, 2 - Lower side members, 3 - Front vertical legs, 4 - Rear vertical legs, 5 - Upper side members, 6 - Upper front and rear cross members, 7 - Rear lower member, 8 - Rear caster support, 9 - Driving wheels assembly, 10 - Ball caster assembly, 11 - Front bumper assembly, 12 - Motors and gears, 13 - PCB supports, 14 - Sensors]

// Display an assembly diagram:
choose_diagram = "None"; // [None, Complete Robot, Mini-Switch, Ball Caster, Block Hinge]

// Main function module
module main()
{
    if (display_mode == "Parts") {
        // Rendering quality
        $fn = 20;

        // Aluminium profiles
        if (choose_alu == "90mm Profile") alu_profile15(6, printMode);
        if (choose_alu == "120mm Profile") alu_profile15(8, printMode);
        if (choose_alu == "End cap") alu_profile_end_cap(printMode, 1);
        if (choose_alu == "End cap x28") alu_profile_end_cap(printMode, 28);

        // Blocks
        if (choose_block == "5mm Block") block5(printMode);
        if (choose_block == "7.5mm Block") block7p5(printMode);
        if (choose_block == "15mm Block") block15(1, printMode);
        if (choose_block == "30mm Block") block15(2, printMode);
        if (choose_block == "V15 Block") blockv15(printMode);

        // Plates
        if (choose_plate == "30x90mm single row plate") plate15(6, 2, printMode);
        if (choose_plate == "15x90mm single row plate") plate15(6, 1, printMode);

        // Links
        if (choose_link == "15mm link") link(1, printMode);
        if (choose_link == "30mm link") link(2, printMode);

        // Hinges
        if (choose_hinge == "Small hinge") hinge(printMode);
        if (choose_hinge == "Hinged block") hinged_block(printMode);

        // Hub
        if (choose_hub == "Hub base") hub_base(printMode);
        if (choose_hub == "Hub top") hub_top(printMode);

        // Wheels and cogs
        if (choose_gear == "Large pulley wheel") large_pulley_wheel(printMode);
        if (choose_gear == "Grey axle") grey_axle(printMode);
        if (choose_gear == "Cog wheel top") cog_wheel_top(printMode);
        if (choose_gear == "Cog wheel bottom") cog_wheel_bottom(printMode);
        if (choose_gear == "Gear wheel") gear_wheel(printMode);
        if (choose_gear == "Locking washer") locking_washer(printMode);
        if (choose_gear == "V axle") vaxle(printMode);
        if (choose_gear == "10mm axle clip") clip10(printMode);

        // Mini-Switch
        if (choose_switch == "Mini switch plunger") mini_switch_plunger(printMode);
        if (choose_switch == "Mini switch base") mini_switch_base(printMode);
        if (choose_switch == "Mini switch top") mini_switch_top(printMode);

        // Ball caster
        if (choose_caster == "Ball caster holder") caster_ball_holder(printMode);
        if (choose_caster == "Ball caster base") caster_ball_base(printMode);
        if (choose_caster == "Ball caster top") caster_ball_top(printMode);

        // Chain
        if (choose_chain == "Drive chain") chain(printMode);

        // Cover
        if (choose_cover == "Cover") cover(printMode);

        // Motor
        if (choose_motor == "NEMA 17") nema17_mount(printMode);
    }

    // Display sub-assemblies (according to the original BBC Buggy assembly manual)
    if (display_mode == "Assembly steps") {
        // Rendering quality
        $fn = 20;
        
        // Sub-assembly diagrams
        if (choose_sub_assembly == "1 - Lower front cross member") sub_assembly_1(true);
        if (choose_sub_assembly == "2 - Lower side members") sub_assembly_2(true);
        if (choose_sub_assembly == "3 - Front vertical legs") sub_assembly_3(true);
        if (choose_sub_assembly == "4 - Rear vertical legs") sub_assembly_4(true);
        if (choose_sub_assembly == "5 - Upper side members") sub_assembly_5(true);
        if (choose_sub_assembly == "6 - Upper front and rear cross members") sub_assembly_6(true);
        if (choose_sub_assembly == "7 - Rear lower member") sub_assembly_7(true);
        if (choose_sub_assembly == "8 - Rear caster support") sub_assembly_8(true);
        if (choose_sub_assembly == "9 - Driving wheels assembly") sub_assembly_9(true);
        if (choose_sub_assembly == "10 - Ball caster assembly") sub_assembly_10(true);
        if (choose_sub_assembly == "11 - Front bumper assembly") sub_assembly_11(true);
        if (choose_sub_assembly == "12 - Motors and gears") sub_assembly_12(true);
        if (choose_sub_assembly == "13 - PCB supports") sub_assembly_13(true);
        if (choose_sub_assembly == "14 - Sensors") sub_assembly_14(true);

        // Other assembly diagrams
        if (choose_diagram == "Complete Robot") sub_assembly_complete();
        if (choose_diagram == "Mini-Switch") diagram_mini_switch();
        if (choose_diagram == "Ball Caster") diagram_ball_caster();
        if (choose_diagram == "Block Hinge") diagram_block_hinge();
    }
}

main();
