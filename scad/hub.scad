/************************************************************************

	hub.scad
    
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
use <BOSL/threading.scad>
use <BOSL/metric_screws.scad>
use <BOSL/involute_gears.scad>

include <common.scad>

module render_hub_base()
{
    difference() {
        union() {
            // Base
            cyl(h=1, d=25);
            move([0,0,1]) cyl(h=1, d1=25, d2=20);

            // Ring
            move([0,0,2.5]) difference() {
                cyl(h=2, d=20);
                cyl(h=2.2, d1=10, d2=20);
            }

            // Threaded shaft
            difference() {
                union() {
                    move([0,0,4]) threaded_rod(d=10, l=5, pitch=get_metric_iso_fine_thread_pitch(10), orient=ORIENT_Z);
                    move([0,0,9]) cyl(h=5, d1=8, d2=7);
                }

                move([0,0,6]) cuboid([6.5,1,15]);
                move([0,0,6]) cuboid([1,10,15]);
                move([0,0,11]) cuboid([10,1,3]);
            }
        }

        // 4mm Hole for axle
        move([0,0,5]) cyl(h=20, d=4);
    }

    // Add the pins to hold the gear in place
    // Pin angles are 15 degrees apart (i.e. there would be 24 pins if all were present)
    move([0,0,1.5]) zrot_copies(rots=[0,45,60,75,90,105,120,135,180,225,240,255,270,285,300,315], r=10, subrot=false) {
        zcyl(h=2, d=1);
        move([0,0,1.25]) zcyl(h=0.5, d1=1, d2 = 0.5);
    }
}

module hub_base(printMode)
{
    // Make sure the resolution is high enough to correctly
    // render the threads
    $fn=60;
    if (printMode) {
        move([0,0,0.5]) render_hub_base();
    } else {
        color("red") render_hub_base();
    }
}

module render_hub_top()
{
    difference() {
        difference() {
            union() {
                cyl(h=2, d=25, chamfer = 0.5);

                move([0,0,3.5]) cyl(h=9, d1=14.5, d2=11);
                move([7,0,1]) rotate([0,10,0])rounded_prismoid(size1=[11,2], size2=[7,2], h=6, r=1);
                rotate([0,0,180]) move([7,0,1]) rotate([0,10,0])rounded_prismoid(size1=[11,2], size2=[7,2], h=6, r=1);
            }

            move([0,0,6.5]) cyl(h=4.25, d1=9, d2=6);
            move([0,0,-1.75]) tube(id = 14, od = 14+6.5, h = 2);
        }

        move([0,0,0.5]) {
            threaded_rod(d=10, l=8, pitch=get_metric_iso_fine_thread_pitch(10), internal=true, orient=ORIENT_Z);
        }
    }
}

module hub_top(printMode)
{
    // Make sure the resolution is high enough to correctly
    // render the threads
    $fn=60;
    if (printMode) {
        move([0,0,1]) render_hub_top();
    } else {
        color("red") render_hub_top();
    }
}