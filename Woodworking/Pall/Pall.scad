use <../utils/own/helpers.scad>

$fn = 50;

//

// translate([0, 0, -400]) 
// Pall();

// translate([800, 0, -60]) 
// IKEA_Pall();

// translate([1400, 0, 0]) 
AdjustableStool();

//



//

module Pall() {
  top_length = 400;
  top_width = 280;
  top_thickness = 34;
  leg_length = 400;
  leg_angle = 184;

  translate([0, -top_length/2, 0]) 
  union() {
    // Top
    render()
    difference() {
      Cube(top_length, top_width, top_thickness);
      translate([140, top_width/2, -1]) 
      cylinder(d=40, h=top_thickness+2);
      translate([top_length -140, top_width/2, -1]) 
      cylinder(d=40, h=top_thickness+2);
      translate([140, top_width/2-40/2, -1]) 
      Cube(120, 40, top_thickness+2);
    }

    render()
    difference() {
      union() {
        // Leg left
        translate([400 - 60, 40, 10]) 
        translate([0, 0, 0]) 
        Rotate([0, -leg_angle, 0])
        Cube(34, 200, leg_length);

        // Leg right
        translate([34 + 60, 40, 10]) 
        Rotate([0, leg_angle, 0])
        Cube(34, 200, leg_length);
      }

      // flatten bottom
      translate([0, 0, -leg_length - 6]) 
      Cube(top_length, top_width, 20);
      
      // cut out for the feet
      translate([0, 90, -leg_length - 6]) 
      Cube(top_length, 100, 80);
    }

    // Support
    translate([0, 280/2 - 34/2, -250]) 
    union() {
      render()
      difference() {
        Cube(400, 34, 70);

        // Tenon
        Cube(70, 34, 15);
        translate([0, 0, 70-15]) 
        Cube(70, 34, 15);

        // Tenon
        translate([top_length-70, 0, 0]) 
        Cube(70, 34, 15);
        translate([top_length-70, 0, 70-15]) 
        Cube(70, 34, 15);
      }

      translate([8, 24, -20])
      Rotate([0, 0, -90])
      Tap();

      translate([top_length - 8, 10, -20])
      Rotate([0, 0, 90])
      Tap();
    }
  }

  module Tap() {
    color("#962")
    render()
    difference() {
      width = 14;
      length = 40;
      height = 100;
      Cube(width, length, height);
      translate([0, -16, -10]) 
      scale(1.1) 
      rotate([6, 0, 0]) 
      Cube(width, length, height);
    }
  }
}

module IKEA_Pall() {
  translate([0, 0, -300])
  cylinder(d=400, h=40); // seat

  number_of_legs = 4;
  translate([-200, -20, -720]) 
  for (i=[0:number_of_legs-1]) {
    Rotate([0, 0, (360/number_of_legs) * i], [200, 20, 400])
    union() {
      Cube(20, 35, 400);
      
      translate([20, 0, 400]) 
      Cube(140, 35, 20);

      render()
      translate([20, 0, 400]) 
      Rotate([-90, 0, 0])
      difference() {
        cylinder(d=40, h=35);
        translate([20, 20, 0]) 
        cylinder(d=40, h=35);
      }
    }
  }
}

module AdjustableStool() {
  Rotate([0, 0, 60*sin($t*360)])
  translate([0, 0, -100 -120*sin($t*360)]) 
  union() {
    cylinder(d=400, h=40); // seat
    translate([0, 0, -40]) 
    cylinder(d=200, h=40); // support
    // translate([0, 0, -560]) 
    // cylinder(d=60, h=560); // screw
    translate([0, 0, -560]) 
    linear_extrude(height=560, convexity=10, twist=10000)
    translate([10, 0, 0])
    circle(d=60); // screw
  }

  translate([0, 0, -300])
  cylinder(d=260, h=40); // support
  translate([0, 0, -500]) 
  cylinder(d1=190, d2=172, h=40); // support

  difference() {
    union() {
      number_of_legs = 3;
      
      translate([0, 0, -900]) 
      for (i=[0:number_of_legs-1]) {
        Rotate([9, 9, (360/number_of_legs) * i], [0, 0, 600])
        translate([-50, 50, 0]) 
        cylinder(d=50, h=600); // leg
        // Cube(50, 50, 600); // leg
      }
    }
    translate([-500, -500, -1800]) 
    Cube(1000, 1000, 1000);
  }
}
