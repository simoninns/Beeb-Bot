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

// Rendering quality
$fn = 20;

// Display Aluminum profile?
display_alu_profile = "Yes"; // [Yes, No]

// Display 15x15 block?
display_block15 = "Yes"; // [Yes, No]

if (display_alu_profile == "Yes") alu_profile(30);
if (display_block15 == "Yes") block15(15);