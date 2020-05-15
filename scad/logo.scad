/************************************************************************

	logo.scad
    
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

include <alu_profile.scad>
include <block.scad>
include <cogs_and_wheels.scad>

// Note: This isn't part of the printable model
// This module renders the Beeb-Bot logo from model parts

module logo_letter_B()
{
    move([0,0,0]) alu_profile15(4, false);
    move([60,0,15]) alu_profile15(4, false);
    move([30 + 7.5,0,-15 - 7.5]) rotate([0,90,0]) alu_profile15(4, false);
    move([30 - 7.5,0,30 + 7.5]) rotate([0,90,0]) alu_profile15(4, false);
    move([-15,0,60]) alu_profile15(4, false);
    move([60 - 15,0,15 + 60]) alu_profile15(4, false);
    move([30 - 7.5 - 15,0,30 + 7.5 + 60]) rotate([0,90,0]) alu_profile15(4, false);
}

module logo_letter_e()
{
    move([0,0,15]) {
        move([0,0,0]) alu_profile15(4, false);
        move([30 - 7.5,0,-30 - 7.5]) rotate([0,90,0]) alu_profile15(4, false);
        move([30 - 7.5,0,30 + 7.5]) rotate([0,90,0]) alu_profile15(4, false);

        move([15 + 7.5,0,0]) rotate([0,-90,0]) block15(2, false);
    }
}

module logo_letter_b()
{
    move([0,0,0]) alu_profile15(4, false);
    move([60,0,15]) alu_profile15(4, false);
    move([30 + 7.5,0,-15 - 7.5]) rotate([0,90,0]) alu_profile15(4, false);
    move([30 - 7.5,0,30 + 7.5]) rotate([0,90,0]) alu_profile15(4, false);
    move([0,0,75]) alu_profile15(4, false);
}

module logo_letter_o()
{
    move([30,0,7.5]) rotate([90,0,0]) scale(1.3) large_pulley_wheel(false);
}

module logo_letter_t()
{
    move([0,0,0]) alu_profile15(4, false);
    move([0,0,45 - 7.5]) rotate([0,90,0]) block15(1, false);
    move([0,0,75]) alu_profile15(4, false);
    move([15 + 7.5,0,60 - 7.5]) rotate([0,-90,0]) block15(2, false);
}

module logo()
{
    move([-230 + 7.5 - 60,0,0]) {
        move([0,0,0]) logo_letter_B();
        move([90,0,0]) logo_letter_e();
        move([165,0,0]) logo_letter_e();
        move([240,0,0]) logo_letter_b();

        move([330 + 60,0,0]) logo_letter_B();
        move([420 + 60,0,0]) logo_letter_o();
        move([570,0,0]) logo_letter_t();
    }
}