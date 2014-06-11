//===========================================
//   Public Domain Roots Blower in OpenSCAD
//   version 1.0
//   by Matt Moses, 2011, mmoses152@gmail.com
//   http://www.thingiverse.com/thing:8068
//
//   This file is public domain.  Use it for any purpose, including commercial
//   applications.  Attribution would be nice, but is not required.  There is
//   no warranty of any kind, including its correctness, usefulness, or safety.
//
//   See http://en.wikipedia.org/wiki/Roots_type_supercharger
//
//   This file uses code appropriated from 
//   Leemon Baird's PublicDomainGearV1.1.scad
//   which can be found here:
//   http://www.thingiverse.com/thing:5505
//
//===========================================


//===========================================
// General stuff
pi = 3.1415926;
$fn = 30; // facet resolution
alpha = 180 * $t; // for animation
//===========================================


//===========================================
// Note: The gears are offset by 90 degrees.  
// For them to mesh with this phasing, they need to have
// number of teeth = 4*n + 2, where n is an integer.  
// First few options are 6, 10, 14, 18, 22, 26, 30...
//
// The gear parameters determine the rotor parameters, 
// so let's start by defining them:
//
mm_per_tooth = 5; // for timing gears
number_of_teeth = 22; // for timing gears, pick one: 6, 10, 14, 18, 22, 26, etc.
thickness = 6; 
hole_diameter = 0;
twist = 0;
teeth_to_hide = 0;
pressure_angle = 28;
clearance = 0.3;
backlash = 0.2;
//===========================================


//===========================================
// Now determine and/or set the rotor parameters
r =  mm_per_tooth * number_of_teeth / pi / 8; // this is one quarter of pitch radius of timing gears
R = 4*r; // big R for eip- and hypo- trochoid shapes in rotor

echo(6*R); // this is the length of the long side of the housing (assumed to be in mm)

rotor_thickness = 8;
n_wedge = 20; // number of wedges in a rotor quadrant
r_bore = 4; // half-side of square rotor bore
rotor_twist = 10;
shaft_dia = 12;
shaft_length = 3;
//===========================================


//===========================================
// Now let's assemble the mechanism.
//
// First the Left Rotor
//
/*color([0.2, 0.7, 0.2])
translate([-R, 0, 0]) // shaft_length]) 
	rotate([0, 0, alpha]) 
		rootsRotor(R, r, r, 4*n_wedge, n_wedge, rotor_thickness, r_bore,  rotor_twist);

// Next the Right Rotor
//
color([0.2, 0.5, 0.5])
translate([R, 0, 0]) // shaft_length]) 
	rotate([0, 0, -alpha]) 
		rootsRotor(R, r, r, 4*n_wedge, n_wedge, rotor_thickness, r_bore,  -rotor_twist);
*/
// Now place the Timing Gears
//
//color([0.3, 0.3, 0.5]){
//translate([R, 0, -thickness/2]) {
/*difference(){
  translate([0, 0, thickness/2]) {
          rotate([0, 0, 90-alpha]) {
                  gearshaft ( mm_per_tooth, number_of_teeth, thickness,  
                          hole_diameter, twist, teeth_to_hide,   
                          pressure_angle, clearance, backlash,
                          shaft_dia, shaft_length, r_bore, rotor_thickness);
          }
  }
  difference(){
    translate([0, 0, -0.1]) cylinder(r = 2.65, h = 30, $f = 100); // motor shaft hole
    translate([1.65, -4, -0.15]) cube([10,10,thickness-2]); // key of shaft hole
  }
}

translate([-R, 0, -thickness/2]) {
	rotate([0, 0, alpha]) {
		gearshaft ( mm_per_tooth, number_of_teeth, thickness,  
			hole_diameter, twist, teeth_to_hide,   
			pressure_angle, clearance, backlash,
			shaft_dia, shaft_length, r_bore, rotor_thickness);
	}
}
}

// And last the housing and coverplate (if desired)
//
housing(R, shaft_length, shaft_dia, rotor_thickness);
*/
difference(){
  translate([0, 0, -1.01*rotor_thickness - 0.99*shaft_length]) coverplate(R, shaft_length, shaft_dia, rotor_thickness);
  translate([R, 0, -0.1]) cylinder(r = 2.65, h = 10, $f = 100); // place a hole for the shaft of the motor
  translate([R, 0, 1]) cylinder(r = 11, h = 2.01, $f = 100); // place a 2mm hole for the shoulder of the motor (plate is 3mm thick)

  translate([R + 31/2, 31/2, -0.01]) cylinder(r = 1.75, h = 10, $f = 100); // motor screwholes are on a 31mm square, 3.5mm diameter (body holes)
  translate([R + 31/2, -31/2, -0.01]) cylinder(r = 1.75, h = 10, $f = 100); // motor screwholes are on a 31mm square, 3.5mm diameter (body holes)
  translate([R - 31/2, 31/2, -0.01]) cylinder(r = 1.75, h = 10, $f = 100); // motor screwholes are on a 31mm square, 3.5mm diameter (body holes)
  translate([R - 31/2, -31/2, -0.01]) cylinder(r = 1.75, h = 10, $f = 100); // motor screwholes are on a 31mm square, 3.5mm diameter (body holes)

  translate([R + 31/2, 31/2, -0.01]) cylinder(r1 = 3.0, r2 = 1.75, h = 1.6, $f = 100); // panhead screws are 5.8mm dia. max and 1.5mm deep pan
  translate([R + 31/2, -31/2, -0.01]) cylinder(r1 = 3.0, r2 = 1.75, h = 1.6, $f = 100); // panhead screws are 5.8mm dia. max and 1.5mm deep pan
  translate([R - 31/2, 31/2, -0.01]) cylinder(r1 = 3.0, r2 = 1.75, h = 1.6, $f = 100); // panhead screws are 5.8mm dia. max and 1.5mm deep pan
  translate([R - 31/2, -31/2, -0.01]) cylinder(r1 = 3.0, r2 = 1.75, h = 1.6, $f = 100); // panhead screws are 5.8mm dia. max and 1.5mm deep pan
}
//
//===========================================


//===========================================
// This section places individual parts so they can be 
// easily exported as STL.  Comment or uncomment each 
// sub-section as needed.
// NOTE: The twisted rotors crash OpenSCAD during "Compile and Render"
// There are probably not unioned correctly...
// The no-twist rotor exports to STL fine.


// Left Rotor
//rootsRotor(R, r, r, 4*n_wedge, n_wedge, rotor_thickness, r_bore,  rotor_twist);

// Right Rotor
//rootsRotor(R, r, r, 4*n_wedge, n_wedge, rotor_thickness, r_bore,  -rotor_twist);

// No-Twist Rotor
//rootsRotor(R, r, r, 4*n_wedge, n_wedge, rotor_thickness, r_bore,  0);

//// Gearshaft
//translate([0, 0, thickness/2])
//gearshaft ( mm_per_tooth, number_of_teeth, thickness,  
//	hole_diameter, twist, teeth_to_hide,   
//	pressure_angle, clearance, backlash,
//	shaft_dia, shaft_length, r_bore, rotor_thickness);

// Housing
//housing(R, shaft_length, shaft_dia, rotor_thickness);

//// Coverplate
//translate([0, 0, -1.01*rotor_thickness - 0.99*shaft_length])
//coverplate(R, shaft_length, shaft_dia, rotor_thickness);

//===========================================


//===========================================
// Gearshaft Module
//
module gearshaft ( mm_per_tooth, number_of_teeth, thickness,  
			hole_diameter, twist, teeth_to_hide,   
			pressure_angle, clearance, backlash,
			shaft_dia, shaft_length, r_bore, rotor_thickness){
union() {
	gear ( mm_per_tooth, number_of_teeth, thickness,  
	hole_diameter, twist, teeth_to_hide,   
	pressure_angle, clearance, backlash);
	
	translate([0, 0, thickness/2 + shaft_length/2]) 
		cylinder (h = shaft_length, r = shaft_dia/2, center = true);

	translate([0, 0, thickness/2 + shaft_length + rotor_thickness/2])
		rotate([0, 0, 45])
			cube([0.98 * 2 * r_bore, 0.98 * 2 * r_bore, rotor_thickness], center = true);

}
}
//===========================================


//===========================================
// Housing Module
//
module housing (R, shaft_length, shaft_dia, rotor_thickness) {
l_housing = 6*R;
w_housing = 4*R;
h_housing = 1.01 * rotor_thickness;
h_backplate = 0.99 * shaft_length;
h_total = h_housing + h_backplate;

color([0.7, 0, 0.4]) {
difference() {
	union() {
		translate([0, 0, h_backplate/2])
			cube([l_housing, w_housing, h_backplate], center = true);

		difference(){
			translate([0, 0, h_housing/2 + h_backplate])
				cube([l_housing, w_housing, h_housing], center = true);
			translate([-R, 0, h_housing/2 + h_backplate]) 
				cylinder(h = 1.1*rotor_thickness, r = 1.01*1.5*R, center = true);
			translate([R, 0, h_housing/2 + h_backplate]) 
				cylinder(h = 1.1*rotor_thickness, r = 1.01*1.5*R, center = true);
		}
	}
	//translate([0, sqrt( 1.01*1.01*1.5*1.5 - 1)*R, h_total/2])
	//	cylinder(r = R/6, h = 1.1*h_total, center = true);
	translate([0, 0,1.1* h_housing/2 + h_backplate])
		cube([R/6, 1.1*w_housing, 1.1*h_housing], center = true);
	translate([-R, 0, h_backplate/2 ])
		cylinder(r = 1.05 * shaft_dia/2, h = 1.1*h_backplate, center = true);
	translate([R, 0, h_backplate/2 ])
		cylinder(r = 1.05 * shaft_dia/2, h = 1.1*h_backplate, center = true);
	
}
}
}
//===========================================


//===========================================
// Coverplate Module
//
module coverplate (R, shaft_length, shaft_dia, rotor_thickness) {
l_housing = 6*R;
w_housing = 4*R;
h_housing = 1.01 * rotor_thickness;
h_backplate = 0.99 * shaft_length;
h_total = h_housing + h_backplate;
h_coverplate = 3;

color([0.2, 0.5, 0.3]) 
translate([0, 0, h_coverplate/2 + h_total])
	cube([l_housing, w_housing, h_coverplate], center = true);
}
//===========================================


//===========================================
// Roots Rotor Module
//
module rootsRotor(R, r, d, n, p, thickness, rad_bore, twist) {
	difference() {
	union() {
		hypotrochoidLinear(R, r, d, n, p, thickness, twist);
		rotate([0, 0, 90]) epitrochoidLinear(R, r, d, n, p, thickness, twist);
		rotate([0, 0, 180]) hypotrochoidLinear(R, r, d, n, p, thickness, twist);
		rotate([0, 0, 270]) epitrochoidLinear(R, r, d, n, p, thickness, twist);
	}
	translate([0, 0, thickness/2]) rotate([0, 0, 45]) cube([2*rad_bore,2* rad_bore, 1.1*thickness], center = true);
}
}
//===========================================


//===========================================
// Epitrochoid Wedge, Linear Extrude
//
module epitrochoidLinear(R, r, d, n, p, thickness, twist) {
	dth = 360/n;
	linear_extrude(height = thickness, convexity = 10, twist = twist) {
	union() {
	for ( i = [0:p-1] ) {
			polygon(points = [[0, 0], 
			[(R+r)*cos(dth*i) - d*cos((R+r)/r*dth*i), (R+r)*sin(dth*i) - d*sin((R+r)/r*dth*i)], 
			[(R+r)*cos(dth*(i+1)) - d*cos((R+r)/r*dth*(i+1)), (R+r)*sin(dth*(i+1)) - d*sin((R+r)/r*dth*(i+1))]], 
			paths = [[0, 1, 2]], convexity = 10); 
	}
	}
	}
}
//===========================================


//===========================================
// Hypotrochoid Wedge, Linear Extrude
//
module hypotrochoidLinear(R, r, d, n, p, thickness, twist) {
	dth = 360/n;
	linear_extrude(height = thickness, convexity = 10, twist = twist) {
	union() {
	for ( i = [0:p-1] ) {
			polygon(points = [[0, 0], 
			[(R-r)*cos(dth*i) + d*cos((R-r)/r*dth*i), (R-r)*sin(dth*i) - d*sin((R-r)/r*dth*i)], 
			[(R-r)*cos(dth*(i+1)) + d*cos((R-r)/r*dth*(i+1)), (R-r)*sin(dth*(i+1)) - d*sin((R-r)/r*dth*(i+1))]],
			paths = [[0, 1, 2]], convexity = 10); 
	}
	}
	}
}
//===========================================


//===========================================
//   This gear() module is from 
//   Leemon Baird's PublicDomainGearV1.1.scad
//   which can be found here:
//   http://www.thingiverse.com/thing:5505
//An involute spur gear, with reasonable defaults for all the parameters.
//Normally, you should just choose the first 4 parameters, and let the rest be default values.
//Meshing gears must match in mm_per_tooth, pressure_angle, and twist,
//and be separated by the sum of their pitch radii, which can be found with pitch_radius().
module gear (
	mm_per_tooth    = 3,    //this is the "circular pitch", the circumference of the pitch circle divided by the number of teeth
	number_of_teeth = 11,   //total number of teeth around the entire perimeter
	thickness       = 6,    //thickness of gear in mm
	hole_diameter   = 3,    //diameter of the hole in the center, in mm
	twist           = 0,    //teeth rotate this many degrees from bottom of gear to top.  360 makes the gear a screw with each thread going around once
	teeth_to_hide   = 0,    //number of teeth to delete to make this only a fraction of a circle
	pressure_angle  = 28,   //Controls how straight or bulged the tooth sides are. In degrees.
	clearance       = 0.0,  //gap between top of a tooth on one gear and bottom of valley on a meshing gear (in millimeters)
	backlash        = 0.0   //gap between two meshing teeth, in the direction along the circumference of the pitch circle
) {
	assign(pi = 3.1415926)
	assign(p  = mm_per_tooth * number_of_teeth / pi / 2)  //radius of pitch circle
	assign(c  = p + mm_per_tooth / pi - clearance)        //radius of outer circle
	assign(b  = p*cos(pressure_angle))                    //radius of base circle
	assign(r  = p-(c-p)-clearance)                        //radius of root circle
	assign(t  = mm_per_tooth/2-backlash/2)                //tooth thickness at pitch circle
	assign(k  = -iang(b, p) - t/2/p/pi*180) {             //angle to where involute meets base circle on each side of tooth
		difference() {
			for (i = [0:number_of_teeth-teeth_to_hide-1] )
				rotate([0,0,i*360/number_of_teeth])
					linear_extrude(height = thickness, center = true, convexity = 10, twist = twist)
						polygon(
							points=[
								[0, -hole_diameter/10],
								polar(r, -181/number_of_teeth),
								polar(r, r<b ? k : -180/number_of_teeth),
								q7(0/5,r,b,c,k, 1),q7(1/5,r,b,c,k, 1),q7(2/5,r,b,c,k, 1),q7(3/5,r,b,c,k, 1),q7(4/5,r,b,c,k, 1),q7(5/5,r,b,c,k, 1),
								q7(5/5,r,b,c,k,-1),q7(4/5,r,b,c,k,-1),q7(3/5,r,b,c,k,-1),q7(2/5,r,b,c,k,-1),q7(1/5,r,b,c,k,-1),q7(0/5,r,b,c,k,-1),
								polar(r, r<b ? -k : 180/number_of_teeth),
								polar(r, 181/number_of_teeth)
							],
 							paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]]
						);
			cylinder(h=2*thickness+1, r=hole_diameter/2, center=true, $fn=20);
		}
	}
};	
//these 4 functions are used by gear
function polar(r,theta)   = r*[sin(theta), cos(theta)];                            //convert polar to cartesian coordinates
function iang(r1,r2)      = sqrt((r2/r1)*(r2/r1) - 1)/3.1415926*180 - acos(r1/r2); //unwind a string this many degrees to go from radius r1 to radius r2
function q7(f,r,b,r2,t,s) = q6(b,s,t,(1-f)*max(b,r)+f*r2);                         //radius a fraction f up the curved side of the tooth 
function q6(b,s,t,d)      = polar(d,s*(iang(b,d)+t));                              //point at radius d on the involute curve
//===========================================
