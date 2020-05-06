/************************************************************************

	cover.scad
    
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
include <alu_profile.scad>

// Note: The cover is designed to be quite thin in order to be
// as transparent as possible when printed with clear filament
module render_cover()
{
    width=125;
    thickn=1;
    height=32;

    difference() {
        cuboid([width,width,height], chamfer=2, edges=EDGES_ALL-EDGES_BOTTOM); 
        
        move([0,0,-thickn]) cuboid([width - (thickn*2),width - (thickn*2),height], chamfer=2, edges=EDGES_ALL-EDGES_BOTTOM);
        move([0,0,-5]) cuboid([97,width + 2,height], fillet=5, edges=EDGES_Y_ALL);

        move([0,0,(height / 2) - 1.2]) cyl(h=1.2, d=width-8, $fn=60);
    }
    
    // Frame clips
    difference() {
        move([((width - (thickn*2)) / 2),0, -(height/2) + 5]) cuboid([3,width / 3,3.5], chamfer=1.5);
        move([((width - (thickn*2)) / 2) + 1.5,0, -(height/2) + 5]) cuboid([3,width / 3,3.5]);
    }
    difference() {
        move([-((width - (thickn*2)) / 2),0, -(height/2) + 5]) cuboid([3,width / 3,3.5], chamfer=1.5);
        move([-((width - (thickn*2)) / 2) - 1.5,0, -(height/2) + 5]) cuboid([3,width / 3,3.5]);
    }
}

module cover(printMode)
{
    if (printMode) {
        rotate([180,0,0]) move([0,0,-16]) render_cover();
    } else {
        color("white") render_cover();
    }
}