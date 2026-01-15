use <./utils/own/helpers.scad>

$fn = 50;

//

// Sawhorse_3();

translate([400, 200, 0]) 
Sawhorse_4();

//

module Sawhorse_3() {
  width = 800;
  height = 750;
  
  leg_angle = 13;
  leg_angle_offset = 178;
  
  leg_margin = 120/3;
  
  // top plank
  Plank(width);

  translate([-45/4, leg_margin, -height + 120 - leg_margin])
  45x70(height);

  translate([-45/4 - leg_angle_offset, width - 70 - leg_margin, -height + (120/3)*2])
  Rotate([0, leg_angle, 0], [100, 0, 0]) 
  45x70(height);

  translate([-45/4 + leg_angle_offset, width - 70 - leg_margin, -height + (120/3)*2])
  Rotate([0, -leg_angle, 0], [-100 + 45, 0, 0]) 
  45x70(height);

  // leg support
  render()
  translate([22/2 + 200/2, width - leg_margin, -120]) 
  Rotate([0, 0, 90])
  difference() {
    Plank(200);
    rotate([90-leg_angle, 0, 0]) 
    translate([0, 0, -23]) 
    Plank(200);
    translate([0, 276, 0]) 
    rotate([90+leg_angle, 0, 0]) 
    translate([0, 0, -23]) 
    Plank(200);
  }
}

module Sawhorse_4() {
  width = 800;
  height = 750;
  
  leg_angle_degrees = 13;
  leg_margin = 120;
  
  // top plank
  Plank(width);

  // legs
  translate([-45/4, width - 70 - leg_margin, -height + (120/3)*2 - 20])
  Rotate([0, leg_angle_degrees, 0], [45/2, 70/2, height]) 
  45x70(height);

  translate([-45/4, width - 70 - leg_margin, -height + (120/3)*2 - 20])
  Rotate([0, -leg_angle_degrees, 0], [45/2, 70/2, height]) 
  45x70(height);

  // leg support
  render()
  translate([22/2 + 200/2, width - leg_margin, -80]) 
  Rotate([0, 0, 90])
  difference() {
    Plank(200);
    rotate([90-leg_angle_degrees, 0, 0]) 
    translate([0, 0, -43]) 
    Plank(200);
    translate([0, 276, 0]) 
    rotate([90+leg_angle_degrees, 0, 0]) 
    translate([0, 0, -2]) 
    Plank(200);
  }
  
  // legs
  translate([-45/4, leg_margin, -height + (120/3)*2 - 20])
  Rotate([0, leg_angle_degrees, 0], [45/2, 70/2, height]) 
  45x70(height);

  translate([-45/4, leg_margin, -height + (120/3)*2 - 20])
  Rotate([0, -leg_angle_degrees, 0], [45/2, 70/2, height]) 
  45x70(height);

  // leg support
  render()
  translate([22/2 + 200/2, -22 + leg_margin, -80]) 
  Rotate([0, 0, 90])
  difference() {
    Plank(200);
    rotate([90-leg_angle_degrees, 0, 0]) 
    translate([0, 0, -43]) 
    Plank(200);
    translate([0, 276, 0]) 
    rotate([90+leg_angle_degrees, 0, 0]) 
    translate([0, 0, -2]) 
    Plank(200);
  }
}

module Plank(length) {
  Cube(22, length, 120);
}

module 45x70(length) {
  Cube(45, 70, length);
}
