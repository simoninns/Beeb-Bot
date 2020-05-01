/************************************************************************

	link.scad
    
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

include <common.scad>

// Render link 15 and up ----------------------------------------------------------------------------------------------
module render_link(length)
{
    difference() {
        union() {
            move([0,0,0]) xcyl(h=length, d=3.8);
            move([0,0,1.5]) cuboid([length,3,3]);
            move([0,0,4]) xcyl(h=length, d=3.8);
        }

        // Slice base
        move([0,0,-2]) cuboid([length + 2,5,3]);

        // Slice top
        move([0,0,7]) cuboid([length + 2,5,3]);

        // Slice dividers
        move([0,0,-0.5]) cuboid([length + 2,0.75,3]);
        move([0,0,5]) cuboid([length + 2,0.75,3]);
    }
}

module link(x_units, printMode)
{
    length = x_units * 15;
    
    if (printMode) {
        // Display ready for 3D printing
        move([0,0,0.5]) {
            render_link(length);
        }
    } else {
        color("red") render_link(length);
    }
}