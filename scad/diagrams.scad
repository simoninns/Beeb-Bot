/************************************************************************

	diagrams.scad
    
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

include <mini_switch.scad>

// Mini-Switch exploded diagram
module diagram_mini_switch()
{
    rotate([90,0,0]) {
        mini_switch_base(false);
        move([0,25,0]) mini_switch_top(false);
        move([0,20,0]) mini_switch_plunger(false);
        move([0,10,0]) mini_switch_micro_switch(false);
    }
}

// Caster ball exploded diagram
module diagram_ball_caster()
{
    rotate([0,180,0]) {
    caster_ball_base(false);
    move([0,0,30]) caster_ball_top(false);
    move([0,0,13]) caster_ball_bearing(false);
    }
}

// Block hinge exploded diagram
module diagram_block_hinge()
{
    color("lightgrey") {
        move([-5,0,0]) render_hinged_block_body_front();
        move([0,0,0]) render_hinged_block_body_back();
        move([0,0,-15]) render_hinge_pin_base();

        move([0,0,10]) rotate([180,0,180]) {
            move([-5,0,5]) render_hinged_block_body_front();
            move([0,0,5]) render_hinged_block_body_back();
            move([0,0,-10]) render_hinge_pin_top();
        }
    }
}