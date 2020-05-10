/************************************************************************

	nema17.scad
    
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
use <BOSL/nema_steppers.scad>

include <assemblies.scad>

// NEMA 17 motor and motor mount --------------------------------------------------------------------------------------
module render_nema17_motor()
{
    // Render the motor with the shaft pointing right and the cable to the back
    rotate([0,-90,180]) nema17_stepper(h=40, shaft=5, shaft_len=20, orient=ORIENT_Z);
}

// Renders a NEMA 17 sized mount designed to fit into the same
// space (and use the same mount points) as the original BBC
// Buggy Philips stepper motor.  This will also place the shaft
// at the same point to make it a one-to-one replacement.
module render_nema17_mount()
{
    move([3.5,0,0]) {
        difference() {
            union() {
                move([0,0,0]) cuboid([7,46,46], chamfer=1, edges=EDGES_ALL-EDGES_LEFT);

                // Face plate (try to make it look more like the original motor)
                rotate([90,0,0]) move([-14.75,0,0]) rotate([0,90,0]) {
                    difference() {
                        move([0,0,(33.5 / 2)]) rotate([90,0,0]) {
                            teardrop(r=54 / 2, h=3, ang=36, cap_h=40, $fn=60);
                            rotate([180,0,0]) teardrop(r=54 / 2, h=3, ang=36, cap_h=40, $fn=60);
                        }

                        move([0,33 + 4,(33.5 / 2)]) rotate([0,0,90]) slot(l=7, r1=2.2, r2=2.2, h=5);
                        move([0,-33 - 4,(33.5 / 2)]) rotate([0,0,90]) slot(l=7, r1=2.2, r2=2.2, h=5);
                    }
                }
            }
            
            // Add NEMA 17 mount holes
            rotate([0,-90,0]) nema17_mount_holes(depth=8, l=0, $fn=60);

            // Recess the mount holes
            move([5.5 - 3,31/2,31/2]) xcyl(h=4,d=6);
            move([5.5 - 3,31/2,-31/2]) xcyl(h=4,d=6);
            move([5.5 - 3,-31/2,31/2]) xcyl(h=4,d=6);
            move([5.5 - 3,-31/2,-31/2]) xcyl(h=4,d=6);

            // Chamfer the edge around the shaft
            move([7,0,0]) rotate([0,-90,0]) cyl(h=10,d=25, chamfer2=2, $fn=60);
        }
        
        // Lip to align stepper motor to mount holes
        difference() {
            move([-(7/2) - 2.5,0,0]) cuboid([5,46,46], chamfer=1, edges=EDGES_X_ALL);
            move([-(7/2) - 2.5,0,0]) cuboid([6,43,43]);
        }
    }
}

module nema17_mount(printMode)
{
    if (printMode) {
        move([0,0,7]) rotate([0,90,0]) render_nema17_mount();
    } else {
        // Rotate to about 37 degrees to match original motor's mounting position
        //rotate([45,0,0]) render_nema17_motor();
        rotate([45,0,0]) color([0.2,0.2,0.2]) render_nema17_mount();
    }
}

// NEMA 17 5mm shaft cog ----------------------------------------------------------------------------------------------

module render_nema17_cog_gear()
{
    oc1 = 17 - 2.5; // outer diameter
    cir1 = 2 * 3.1415927 * (oc1 / 2);
    nt1 = 10; // number of teeth
    difference() {
        rotate([0,0,7.5]) gear(mm_per_tooth=cir1/nt1, number_of_teeth=nt1, thickness=5, pressure_angle=20, backlash=0.1, hole_diameter=0);

        move([0,0,2]) {
            difference() {
                move([0,0,0.1]) cyl(h=1.1, d=18);
                cyl(h=1, d1=18, d2=10.75);
                cyl(h=1, d=10.75);
            }
        }

        rotate([0,180,0]) move([0,0,2]) {
            difference() {
                move([0,0,0.1]) cyl(h=1.1, d=18);
                cyl(h=1, d1=18, d2=10.75);
                cyl(h=1, d=10.75);
            }
        }
    }
}

module render_nema17_cog_top()
{
    difference() {
        union() {
            render_cog_gear();
            move([0,0,-4.75]) cyl(h=9.5+5, d=11);
        }

        // add 5mm axle hole
        move([0,0,-5]) cyl(h=20, d=5.5);

        // Add a thread
        move([0,0,-9.25]) threaded_rod(d=9, l=6.1, pitch=get_metric_iso_fine_thread_pitch(9), orient=ORIENT_Z, internal=true);

        // Add profile for the collettes
        move([0,0,-9.25 + 7]) cyl(h=15-6 - 1, d1=8.5, d2=6.8);
    }
}

module render_nema17_cog_bottom()
{
    difference() {
        union() {
            oc1 = 11 - 1; // outer diameter
            cir1 = 2 * 3.1415927 * (oc1 / 2);
            nt1 = 16; // number of teeth

            gear(mm_per_tooth=cir1/nt1, number_of_teeth=nt1, thickness=5, pressure_angle=1, backlash=0.01, hole_diameter=4);
            cyl(h=5,d=9.5);

            move([0,0,-5.5]) threaded_rod(d=9, l=6.0, pitch=get_metric_iso_fine_thread_pitch(9), orient=ORIENT_Z, internal=false);
            move([0,0,-12.5]) cyl(h=8, d2=8, d1=7);
        }

        // Add D shaped axle hole
        difference() {
            move([0,0,-7]) cyl(h=25, d=5.2);
            move([3.5 - 0.4,0,-7]) cuboid([2, 6, 25]);
        }

        // Add split
        move([0,0,-10]) cuboid([1,10,15]);
    }
}

module nema17_cog_top(printMode)
{
    if (printMode) {
        move([0,0,2.5]) rotate([180,0,0]) render_nema17_cog_top();
    } else {
        color([0.2,0.2,0.2]) render_nema17_cog_top();
    }
}

module nema17_cog_bottom(printMode)
{
    if (printMode) {
        move([0,0,2.5]) rotate([180,0,0]) render_nema17_cog_bottom();
    } else {
        color("red") render_nema17_cog_bottom();
    }
}