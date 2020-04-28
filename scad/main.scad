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

// Rendering quality
$fn = 20;

// Print mode
use_print_mode = "No"; // [Yes, No]

// Choose the item to display
choose_item = "alu90"; // [alu90, alu120, alu_end_cap, block5, block7p5, block15, block30, blockv15, plate30x90, plate15x90, link15, link30, hinge, hub_base, hub_top, large_pulley_wheel, cog_wheel, gear_wheel, locking_washer]

// Main function 
printMode = (use_print_mode == "Yes") ? true:false;

// Aluminium profiles
if (choose_item == "alu90") alu_profile15(6, printMode);
if (choose_item == "alu120") alu_profile15(8, printMode);
if (choose_item == "alu_end_cap") alu_profile_end_cap(printMode);

// Blocks
if (choose_item == "block5") block5(printMode);
if (choose_item == "block7p5") block7p5(printMode);
if (choose_item == "block15") block15(1, printMode);
if (choose_item == "block30") block15(2, printMode);
if (choose_item == "blockv15") blockv15(printMode);

// Plates
if (choose_item == "plate30x90") plate15(6, 2, printMode);
if (choose_item == "plate15x90") plate15(6, 1, printMode);

// Links
if (choose_item == "link15") link(1, printMode);
if (choose_item == "link30") link(2, printMode);

// Hinges
if (choose_item == "hinge") hinge(printMode);

// Hub
if (choose_item == "hub_base") hub_base(printMode);
if (choose_item == "hub_top") hub_top(printMode);

// Wheels and cogs
if (choose_item == "large_pulley_wheel") large_pulley_wheel(printMode);
if (choose_item == "cog_wheel") cog_wheel(printMode);
if (choose_item == "gear_wheel") gear_wheel(printMode);
if (choose_item == "locking_washer") locking_washer(printMode);