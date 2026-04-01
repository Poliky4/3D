use <../utils/own/helpers.scad>

$fn = 50;

debug = true;
debug = false;

show_walls = true;
show_walls = false;

total_length = 6000;
total_height = 2500;
total_width = 4000;

overhang = 200;

angle = 6; // https://www.jemfix.se/yttakpapp-toptite-6-graa-8-x-1-m-tecca/4210/9061238/

/*

Skivor vs spont

*/

//

echo(str(""));
// echo(str("Top: 45x70 = ", top_stock_length, "m"));
echo(str(""));

//

// Floor
color("beige")
translate([0, 0, -600]) 
Cube(total_length, total_width, 600);

// House
color("#ffe054")
translate([-1000, -10000, -600]) 
Cube(total_length + 600 + 1000, 10000, 6000);

translate([total_length, 0, -600]) 
Stairs();

Roof();

if (show_walls) Walls();

// //

module Roof() {
  color("white"){
    // Bärlina
    translate([total_length, 0, total_height + 310]) 
    Rotate([0, 0, 90])
    95x190(total_length);

    // Pillars
    translate([0, total_width, 0]) 
    Rotate([90, 0, 0])
    95x95(total_height);
    if (!show_walls) {
      translate([total_length/2.3, total_width, 0]) 
      Rotate([90, 0, 0])
      95x95(total_height);
    }
    translate([total_length - 95, total_width, 0]) 
    Rotate([90, 0, 0])
    95x95(total_height);

    // Horizontal joists
    translate([0, 0, total_height]) 
    95x95(total_width);
    translate([total_length/2.3, 0, total_height]) 
    95x95(total_width);
    translate([total_length - 95, 0, total_height]) 
    95x95(total_width);

    translate([total_length, total_width - 95, total_height]) 
    Rotate([0, 0, 90])
    95x95(total_length);
    translate([total_length, total_width - 95, total_height]) 
    Rotate([0, 0, 90])
    95x95(total_length);

    // Main/Primary roof joists - matching pillars
    // translate([0, 0, total_height + 95]) 
    // Rotate([-angle, 0, 0], [0, total_width, 0])
    // 95x190(total_width + overhang);
    // translate([total_length/2.3, 0, total_height + 95]) 
    // Rotate([-angle, 0, 0], [0, total_width, 0])
    // 95x190(total_width + overhang);
    // translate([total_length - 95, 0, total_height + 95]) 
    // Rotate([-angle, 0, 0], [0, total_width, 0])
    // 95x190(total_width + overhang);

    // Main/Primary roof joists - evenly spaced
    roof_joist_distance = 900; // cc?
    nbr_of_roof_joists = ceil(total_length / roof_joist_distance);
    echo(str("nbr_of_roof_joists = ", nbr_of_roof_joists));
    roof_joist_distance_actual = (total_length - nbr_of_roof_joists - 85) / (nbr_of_roof_joists - 1);
    echo(str("roof_joist_distance_actual = ", roof_joist_distance_actual));
    for (i=[0:nbr_of_roof_joists-1]) {
      translate([roof_joist_distance_actual * i, -44, total_height + 95]) 
      Rotate([-angle, 0, 0], [0, total_width, 0])
      difference() {
        95x95(total_width + overhang);
        Rotate([angle, 0, 0])
      translate([-1, -95 + 22, -10]) 
                        Cube(95 + 2, 95, 220);
      }
    }
  }

  // Spont / skiva
  translate([-overhang, 0, total_height + 95 + 95]) 
  Rotate([-angle, 0, 0], [0, total_width, 0]) {
    color("black")
    Cube(total_length + overhang*2, total_width + overhang, 17);
    color("white")
    translate([0, 0, -1]) 
    Cube(total_length + overhang*2, total_width + overhang, 0.1);
  }
}


module Walls() {

  // Glass wall front
  // Pillar
  translate([total_length, 0, 0]) {
    color("white")
    translate([-95, 95, 0]) 
    Rotate([90, 0, 0])
    95x95(total_height + 600);

    scale([-1, 1, 1]) {
      translate([0, 0, 0]) 
      LargeSlidingGlassDoor();
      translate([0, total_width/3, 0]) 
      LargeSlidingGlassDoor();
      translate([0, (total_width/3)*2, 0]) 
      LargeSlidingGlassDoor();
    }
  }

  // Glass wall side

  color("white") {
    translate([0, total_width - 22, 0]) 
    Cube(total_length, 22, total_height/3);
    translate([0, total_width, total_height/3]) 
    Rotate([0, 0, -90])
    95x95(total_length);
  }

  nbr_of_windows = 4;
  window_width = total_length/nbr_of_windows - 95/nbr_of_windows;
  for (i=[0:nbr_of_windows-1]) {
    translate([(window_width) * i, total_width, total_height/3 + 95]) {
      Window();
    }
  }

  // Glass wall back
  // Pillar
  translate([0, 0, 0]) {
    color("white")
    translate([0, 95, 0]) 
    Rotate([90, 0, 0])
    95x95(total_height + 600);

    translate([0, 0, 0]) 
    LargeSlidingGlassDoor();
    translate([0, total_width/3, 0]) 
    LargeSlidingGlassDoor();
    translate([0, (total_width/3)*2, 0]) 
    LargeSlidingGlassDoor();
  }

  module Window() {
    height = (total_height/3)*2 - 95;

    Rotate([90, 0, 0])
    color("white") {
      95x95(height);

      translate([window_width, 0, 0]) 
      95x95(height);
    }

    color("#00e1ff59")
    translate([95, -22, 0]) 
    Cube(window_width - 95, 22, height);
  }

  module LargeSlidingGlassDoor() {
    Rotate([90, 0, 0])
    color("white") {
      95x95(total_height);

      translate([0, 0, -total_width/3]) 
      95x95(total_height);
    }

    color("#00e1ff59")
    Cube(22, total_width/3 - 95, total_height);
  }
}

module Stairs() {
  step_height = 200;
  upper_step_depth = 400;
  // lower_step_depth = 300;
  lower_step_depth = 295;

  plank_thickness = 28;
  
  total_width = 1600;  
  total_height = step_height * 2;
  // total_depth = 600;
  total_depth = upper_step_depth + lower_step_depth;

  stair_plank_overhang = 15;

  plank_width = 145;
  plank_distance = 5;
  offset_upper = 73 - 28 - stair_plank_overhang;
  offset_lower = 0;

  show_planks = false;
  show_planks = true;


  nbr_joists = 4;

  distance = (((total_width - 70 - plank_thickness*2 - stair_plank_overhang*2) / (nbr_joists - 1)));
  echo(str("Stair joist distance = ", distance));

  color("beige") {


    // base joint front supported by plinths?
    // whole length
    translate([total_depth - 70 - plank_thickness, plank_thickness + stair_plank_overhang, 32]) 
    70x70(total_width - plank_thickness*2 - stair_plank_overhang*2);

    translate([0, 70 + plank_thickness + stair_plank_overhang, 0]) 
    for (i=[0:nbr_joists - 1]) {

      // back
      translate([0, distance * i, 0]) 
      rotate([90, 0, 0]) 
      70x70(total_height - plank_thickness);
      // lower support
      translate([0, distance * i, step_height - 70 - plank_thickness]) 
      rotate([0, 0, -90]) 
      70x70(total_depth - plank_thickness);
      // upper support
      translate([0, distance * i, total_height - 70 - plank_thickness]) 
      rotate([0, 0, -90]) 
      70x70(upper_step_depth - plank_thickness);
      // lower leg
      // translate([total_depth - 70 - plank_thickness, distance * i, 0]) 
      // rotate([90, 0, 0]) 
      // 70x70(step_height - plank_thickness);
      // upper leg
      translate([upper_step_depth - 70 - plank_thickness, distance * i, step_height - plank_thickness]) 
      rotate([90, 0, 0]) 
      70x70(step_height - plank_thickness);
    }


    if (show_planks) {
      // planks upper step
      translate([0, 0, total_height - 28]) 
      Cube(plank_width - offset_upper, total_width, 28);
      translate([plank_width + plank_distance - offset_upper, 0, total_height - 28]) 
      Cube(plank_width, total_width, 28);
      translate([(plank_width + plank_distance) * 2 - offset_upper, 0, total_height - 28]) 
      Cube(plank_width, total_width, 28);
      // front
      translate([upper_step_depth, stair_plank_overhang, total_height - plank_width - 28 - stair_plank_overhang]) 
      rotate([0, -90, 0]) 
      Cube(plank_width, total_width - stair_plank_overhang*2, 28);
      // side left
      translate([0, stair_plank_overhang, total_height - plank_width - 28 - stair_plank_overhang]) 
      rotate([0, -90, -90]) 
      Cube(plank_width, upper_step_depth - 28, 28);
      translate([0, stair_plank_overhang, total_height - plank_width - 28 - stair_plank_overhang - 50]) 
      rotate([0, -90, -90]) 
      Cube(45, upper_step_depth - 28, 28);
      // side right
      translate([0, total_width - 28 - stair_plank_overhang, total_height - plank_width - 28 - stair_plank_overhang]) 
      rotate([0, -90, -90]) 
      Cube(plank_width, upper_step_depth - 28, 28);
      translate([0, total_width - 28 - stair_plank_overhang, total_height - plank_width - 28 - stair_plank_overhang - 50]) 
      rotate([0, -90, -90]) 
      Cube(45, upper_step_depth - 28, 28);

      // planks lower step
      translate([upper_step_depth - 28, 0, step_height - 28]) 
      Cube(plank_width - offset_lower + 28, total_width, 28);
      translate([upper_step_depth + plank_width - offset_lower + plank_distance, 0, step_height - 28]) 
      Cube(plank_width, total_width, 28);
      // front
      translate([total_depth, stair_plank_overhang, step_height - plank_width - 28 - stair_plank_overhang]) 
      rotate([0, -90, 0]) 
      Cube(plank_width, total_width - stair_plank_overhang*2, 28);
      // side left
      translate([0, stair_plank_overhang, step_height - plank_width - 28 - stair_plank_overhang]) 
      rotate([0, -90, -90]) 
      Cube(plank_width, total_depth - 28, 28);
      // side right
      translate([0, total_width - 28 - stair_plank_overhang, step_height - plank_width - 28 - stair_plank_overhang]) 
      rotate([0, -90, -90]) 
      Cube(plank_width, total_depth - 28, 28);
    }
  }

  // debug
  // color("#F005")
  // union() {
  //   Cube(total_depth, total_width, step_height);
    
  //   translate([0, -1, step_height]) 
  //   Cube(upper_step_depth, total_width, step_height + 1);
  // }
}
