/************************************************************************

	cogs_and_wheels.scad
    
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
use <BOSL/involute_gears.scad>

include <common.scad>

// Large Pully Wheel - 60mm diameter, 5.5mm height --------------------------------------------------------------------

module render_large_pulley_wheel()
{

}

module large_pulley_wheel(printMode)
{

}

// Cog Wheel Z10, m 1.5 with collett ----------------------------------------------------------------------------------

module render_cog_wheel()
{

}

module cog_wheel(printMode)
{

}

// Gear wheel Z30, m 1.5 ----------------------------------------------------------------------------------------------

module inner_hub()
{
    rotate([0,0,45]) difference() {
        union() {
            oc1 = 24; // outer diameter
            cir1 = 2 * 3.141 * ((oc1 - 2) / 2);
            nt1 = 24; // number of teeth

            difference() {
                cyl(h=1, d=oc1 - 2);
                gear(mm_per_tooth=cir1/nt1, number_of_teeth=nt1, thickness=2, pressure_angle=25, backlash=0.1, hole_diameter=0, interior=true); 

                rotate([0,0,45]) cuboid([30,5,5]);
                rotate([0,0,-45]) cuboid([30,5,5]);
            }

            move([0,0,0]) tube(h = 5, od=25, id=22, center=true);
        }

        move([0,0,1]) cyl(h=1, d1=22, d2=25);
        move([0,0,2.5]) cyl(h=2.1, d=25);

        rotate([0,180,0]){
            move([0,0,1]) cyl(h=1, d1=22, d2=25);
            move([0,0,2.5]) cyl(h=2.1, d=25);
        }

        rotate([0,0,45]) cuboid([30,3,6]);
        rotate([0,0,-45]) cuboid([30,3,6]);
    }
}

module render_gear_wheel()
{
    oc1 = 47 - 3; // outer diameter
    cir1 = 2 * 3.1415927 * (oc1 / 2);
    nt1 = 30; // number of teeth
    difference() {
        gear(mm_per_tooth=cir1/nt1, number_of_teeth=nt1, thickness=5, pressure_angle=25, backlash=0.1, hole_diameter=25);  

        // 3x 4mm holes around the circumference of the gear
        move([0,0,0]) zrot_copies(rots=[0,120,240], r=16, subrot=false) {
            zcyl(h=6, d=4);

            // Bevel the top and bottom of the hole
            move([0,0,-2.5]) zcyl(h=.51, d1=5,d2=4);
            move([0,0,2.5]) zcyl(h=.51, d1=4,d2=5);
        }

        // The arcs are slow to plot, so use render() to speed up preview
        render() move([0,0,6 - 4]) {
            rotate([0,0,20]) arced_slot(d=32, h=7, sd=3.5, sa=0, ea=80);
            rotate([0,0,140]) arced_slot(d=32, h=7, sd=3.5, sa=0, ea=80);
            rotate([0,0,260]) arced_slot(d=32, h=7, sd=3.5, sa=0, ea=80);
        }

        // Upper bevel edge (on gear teeth)
        move([0,0,2]) {
            difference() {
                move([0,0,0.1]) cyl(h=1.1, d=47);
                cyl(h=1, d1=47, d2=40.5);
                cyl(h=1, d=40.5);
            }
        }

        // Lower bevel edge (on gear teeth)
        rotate([0,180,0]) move([0,0,2]) {
            difference() {
                move([0,0,0.1]) cyl(h=1.1, d=47);
                cyl(h=1, d1=47, d2=40.5);
                cyl(h=1, d=40.5);
            }
        }
    }

    // Render the inner hub
    move([0,0,0]) inner_hub();
}

module gear_wheel(printMode)
{
    $fn=60;

    if (printMode) {
        render_gear_wheel();
    } else {
        color([0.2,0.2,0.2]) render_gear_wheel();
    }
}

// 4mm axel locking washer --------------------------------------------------------------------------------------------

module render_locking_washer()
{

}

module locking_washer(printMode)
{

}
