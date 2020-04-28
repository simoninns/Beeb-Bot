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

// Rendering quality
$fn = 20;

// Print mode
use_print_mode = "No"; // [Yes, No]

// Display Aluminium 90mm profile?
display_alu90_profile = "No"; // [Yes, No]

// Display Aluminium 120mm profile?
display_alu120_profile = "No"; // [Yes, No]

// Display Aluminium profile end-cap?
display_alu_profile_end_cap = "No"; // [Yes, No]

// Display building block 5?
display_building_block5 = "No"; // [Yes, No]

// Display building block 7.5?
display_building_block7p5 = "No"; // [Yes, No]

// Display building block 15?
display_building_block15 = "Yes"; // [Yes, No]

// Display building block 30?
display_building_block30 = "No"; // [Yes, No]

// Display building block V15 corner?
display_building_blockv15 = "No"; // [Yes, No]

// Display building plate 30x90?
display_building_plate_30x90 = "No"; // [Yes, No]

// Display building plate 15x90?
display_building_plate_15x90 = "No"; // [Yes, No]

// Display link 15?
display_link15 = "No"; // [Yes, No]

// Display link 30?
display_link30 = "No"; // [Yes, No]

// Display hinge?
display_hinge = "No"; // [Yes, No]

// Display hub base?
display_hub_base = "No"; // [Yes, No]

// Display hub top?
display_hub_top = "No"; // [Yes, No]

// Main function 
printMode = (use_print_mode == "Yes") ? true:false;

// Note: Units are multiples of 15mm
if (display_alu90_profile == "Yes") alu_profile15(6, printMode);
if (display_alu120_profile == "Yes") alu_profile15(8, printMode);
if (display_alu_profile_end_cap == "Yes") alu_profile_end_cap(printMode);

if (display_building_block5 == "Yes") block5(printMode);
if (display_building_block7p5 == "Yes") block7p5(printMode);
if (display_building_block15 == "Yes") block15(1, printMode);
if (display_building_block30 == "Yes") block15(2, printMode);

if (display_building_blockv15 == "Yes") blockv15(printMode);

if (display_building_plate_30x90 == "Yes") plate15(6, 2, printMode);
if (display_building_plate_15x90 == "Yes") plate15(6, 1, printMode);

if (display_link15 == "Yes") link(1, printMode);
if (display_link30 == "Yes") link(2, printMode);

if (display_hinge == "Yes") hinge(printMode);

if (display_hub_base == "Yes") hub_base(printMode);
if (display_hub_top == "Yes") hub_top(printMode);