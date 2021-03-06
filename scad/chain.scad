/************************************************************************

	chain.scad
    
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

module render_chain_cap()
{
    move([0,0,9.0 / 2 - (0.9 / 2)]) {
        difference() {
            union() {
                // Lower
                move([-1.9,0,-1]) cyl(h=1, d=4);
                move([-1.4,0,-1]) cuboid([1.5,4,1]);

                // Upper
                move([1.9,0,0.25]) cyl(h=1, d=4);
                move([1.4,0,0.25]) cuboid([1.5,4,1]);
                
            }
            cuboid([1.4,4,10]);
        }
        
    }
    move([0,0,3.06]) rotate([0,90,0]) prismoid(size1=[1,4], size2=[1,4], h=1.4, shift=[-1.25,0], center=true);
}

module render_chain_link()
{
    difference() {
        union() {
            render_chain_cap();
            rotate([180,0,0]) render_chain_cap();
            
            // Draw bars
            move([-2.75,0,0]) cyl(h=7.0,d=2.25); // Main bar
            move([-2.75,0,4.25]) cyl(h=2,d1=2, d2=1.25); // Top cone
            move([-2.75,0,-4.25]) cyl(h=2,d2=2, d1=1.25); // Bottom code
        }
        // Add holes
        move([1.9,0,0]) cyl(h=11,d=2.25);
    }
}

module render_chain(numberOfLinks)
{
    for (num = [0:numberOfLinks - 1]) {
        move([num * 4.65,0,0]) render_chain_link();
    }
    
}

module chain(printMode)
{
    $fn=10; // Keep this low, or the slicer will have problems
            // when it comes to printing
    if (printMode) {
        rotate([90,0,0]) move([-(20 / 2) * 4.75,2,0]) render_chain(20);
    } else {
        color("red") render_chain(20);
    }
}