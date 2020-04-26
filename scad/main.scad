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

// Rendering quality
$fn = 20;

// Print mode
use_print_mode = "Yes"; // [Yes, No]

// Display Aluminum profile?
display_alu_profile = "Yes"; // [Yes, No]

// Display building block 15?
display_building_block15 = "Yes"; // [Yes, No]

// Display building block 30?
display_building_block30 = "Yes"; // [Yes, No]

// Display building plate 30x90?
display_building_plate_30x90 = "Yes"; // [Yes, No]

// Display building plate 15x90?
display_building_plate_15x90 = "Yes"; // [Yes, No]

// Main function 
printMode = (use_print_mode == "Yes") ? true:false;

// Note: Units are multiples of 15mm
if (display_alu_profile == "Yes") alu_profile15(90/15, printMode);

if (display_building_block15 == "Yes") block15(1, printMode);
if (display_building_block30 == "Yes") block15(2, printMode);

if (display_building_plate_30x90 == "Yes") plate15(6, 2, printMode);
if (display_building_plate_15x90 == "Yes") plate15(6, 1, printMode);