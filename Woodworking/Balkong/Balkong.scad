$fn = 50;

debug = false;
// debug = true;

railing_plank_width = 170;
railing_plank_thickness = 22;

corner_plank_width = railing_plank_width/3;

total_width = 3000; // TODO: measure
total_depth = 1500; // TODO: measure
// total_width = 3000 + corner_plank_width * 2; // TODO: measure
// total_depth = 1500 + corner_plank_width * 2; // TODO: measure

railing_height = 1500; // TODO: measure

railing_plank_gap = 40;
nbr_of_railing_planks_front = ceil((total_width - railing_plank_gap*2)  / (railing_plank_width + railing_plank_gap)) + 1;
nbr_of_railing_planks_side = ceil((total_depth - railing_plank_gap*2) / (railing_plank_width + railing_plank_gap)) + 1;

//

echo();
echo();
echo();

//

Balkong();

//

echo();
echo();
echo();

//

module Balkong() {


  // bounding box debug
  // translate([0, -total_depth, 0]) 
  // #Cube(total_width, total_depth, railing_height);

  // Regelverk
  Foundation();

  // Trallgolv
  translate([0, 0, 140 - 11]) 
  Floor();

  // Räcke
  Railing();

  //

  module Foundation() {
    // cc = total_width/3 - 95/2;
    // cc = total_width/4 - 35;
    cc = total_width/5 - 28;

    echo();
    echo(str("foundation cc = ", cc, "mm"));
    echo();

    translate([22, 22, 0]) 
    for (i=[0:5]) {
      translate([i * cc, -total_depth, 0]) {
        95x95(total_depth - 22);

        translate([0, 0, -95]) 
        difference() {
          95x95(total_depth - 22);
          Rotate([1.8, 0, 0])
          translate([-1, -1, -95/2]) 
          scale([1.1, 1.1, 1])
          95x95(total_depth - 22);
        }
      }
    }
  }

  module Railing() {

    // stolpar

    translate([22, 0, 0]) 
    Rotate([90, 0, 0])
    95x95(railing_height);

    translate([22, -total_depth + (95 + 22), 0]) 
    Rotate([90, 0, 0])
    95x95(railing_height);

    translate([total_width - (95 + 22), 0, 0]) 
    Rotate([90, 0, 0])
    95x95(railing_height);

    translate([total_width - (95 + 22), -total_depth + (95 + 22), 0]) 
    Rotate([90, 0, 0])
    95x95(railing_height);

    // reglar

    // höger
    // translate([22, -total_depth, 240])
    translate([22, -total_depth + 22, 0])
    95x95(total_depth - 22);

    // translate([22, -total_depth, 1140]) 
    translate([22, -total_depth + 22, railing_height - 95 - 0]) 
    95x95(total_depth - 22);

    // vänster
    // translate([total_width - (95 + 22), -total_depth, 240]) 
    translate([total_width - (95 + 22), -total_depth + 22, 0]) 
    95x95(total_depth - 22);

    // translate([total_width - (95 + 22), -total_depth, 1140]) 
    translate([total_width - (95 + 22), -total_depth + 22, railing_height - 95 - 0]) 
    95x95(total_depth - 22);

    // fram
    // translate([0, -total_depth + (95 + 22), 240]) 
    translate([22, -total_depth + (95 + 22), 0]) 
    Rotate([0, 0, -90])
    95x95(total_width - 22*2);

    // translate([0, -total_depth + (95 + 22), 1140]) 
    translate([22, -total_depth + (95 + 22), railing_height - 95 - 0]) 
    Rotate([0, 0, -90])
    95x95(total_width - 22*2);


    // regelplankor

    // höger
    // translate([22, -total_depth, 1140]) 
    translate([98, -total_depth, railing_height - 0]) 
    translate([-100, -31, 8]) 
    Rotate([0, 90 - 5, 0])
    color("white")
    difference() {
      22x170(total_depth + 31);

      translate([-50, -153, 130]) 
      Rotate([-45, 0, 0])
      Cube(100, 200, 300);
    }

    // vänster

    translate([total_width - 170*1.4, -total_depth, railing_height - 0]) 
    translate([100, -31, 22]) 
    Rotate([0, 90 + 5, 0])
    color("white")
    difference() {
      22x170(total_depth + 31);

      translate([-50, 50, -163]) 
      Rotate([45, 0, 0])
      Cube(100, 200, 300);
    }

    // fram
    translate([0, -total_depth + 170*1.4, railing_height - 0]) 
    Rotate([0, 0, -90])
    translate([100, 0, 22]) 
    Rotate([0, 90 + 5, 0])
    color("white")
    difference() {
      22x170(total_width + 31);

      translate([-50, 50, -163]) 
      Rotate([45, 0, 0])
      Cube(100, 200, 300);

      translate([-50, total_width - 160, -21]) 
      Rotate([-45, 0, 0])
      Cube(100, 200, 300);
    }

    // plankor

    translate([0, -total_depth, 0]) 
    Railing_Front();

    Railing_Side_Right();

    translate([total_width, -total_depth, 0])
    Railing_Side_Left();
  }

  module Floor() {
    floor_plank_gap = 26;
    
    translate([railing_plank_thickness, 0, 0]) 
    for (i=[0:8]) {
      translate([0, -(140 + floor_plank_gap) * i, 0])
      Rotate([0, 90, -90])
      34x140(total_width - railing_plank_thickness*2);
    }
    
  }

  module Railing_Front() {
    width = total_width + corner_plank_width * 2;
    calculated_railing_plank_gap = (width - nbr_of_railing_planks_front * railing_plank_width) / (nbr_of_railing_planks_front - 1);
    //                                                  (total gap width)            /         (number of gaps)
    

    echo();
    echo(str("Front plank gap = ", calculated_railing_plank_gap, "mm"));
    echo();

    difference() {
      translate([-corner_plank_width, 0, 0])
      for (i=[0:nbr_of_railing_planks_front - 1]) {
        translate([(railing_plank_width + calculated_railing_plank_gap) * i, 0, 0]) 
        Rotate([90, 0, 90])
        Railing_Plank(railing_height);
      }

      translate([-corner_plank_width, -corner_plank_width, -1]) 
      rotate([0, 0, 45]) 
      Cube(railing_plank_width, railing_plank_width, railing_height+2);

      translate([width, 0, 0]) 
      translate([-corner_plank_width, -corner_plank_width, -1]) 
      rotate([0, 0, 45]) 
      Cube(railing_plank_width, railing_plank_width, railing_height+2);
    }
  }

  module Railing_Side_Left() {
    difference() {
      Rotate([0, 0, -180])
      Railing_Side();

      translate([0, total_depth - corner_plank_width + corner_plank_width, 0]) 
      translate([-corner_plank_width, 0, -1]) 
      Cube(railing_plank_width, railing_plank_width, railing_height+2);

      translate([-corner_plank_width, -corner_plank_width*3.24, -1]) 
      rotate([0, 0, 45]) 
      Cube(railing_plank_width, railing_plank_width, railing_height+2);
    }
  }
  module Railing_Side_Right() {
    difference() {
      Railing_Side();

      translate([0, corner_plank_width - corner_plank_width, 0]) 
      translate([-corner_plank_width, 0, -1]) 
      Cube(railing_plank_width, railing_plank_width, railing_height+2);

      translate([corner_plank_width, -total_depth-corner_plank_width*3.24, -1]) 
      rotate([0, 0, 45]) 
      Cube(railing_plank_width, railing_plank_width, railing_height+2);
    }
  }
  
  module Railing_Side() {
    depth = total_depth + corner_plank_width * 2;
    calculated_railing_plank_gap = (depth - nbr_of_railing_planks_side * railing_plank_width) / (nbr_of_railing_planks_side - 1);
    //                                                 (total gap width)            /         (number of gaps)

    echo();
    echo(str("Side plank gap = ", calculated_railing_plank_gap, "mm"));
    echo();

    translate([0, corner_plank_width, 0])
    for (i=[0:nbr_of_railing_planks_side - 1]) {
      translate([0, -(railing_plank_width + calculated_railing_plank_gap) * i, 0]) 
      Rotate([90, 0, 0])
      Railing_Plank(railing_height);
    }
  }

  //

  module Railing_Plank(length) {
    color("white") {
      difference() {
        22x170(length);

        translate([-1, railing_height - 360, -105]) 
        Rotate([45, 0, 0])
        Cube(railing_plank_thickness + 2, 100, 100);
        translate([-1, railing_height - 360, 170 + 100/2 - 85]) 
        Rotate([45, 0, 0])
        Cube(railing_plank_thickness + 2, 100, 100);

        translate([-1, 860, 940]) 
        Rotate([0, 90, 0])
        cylinder(d=1600, h=22+2);
        translate([-1, 860, -770]) 
        Rotate([0, 90, 0])
        cylinder(d=1600, h=22+2);

        translate([-1, 350, 300]) 
        Rotate([0, 90, 0])
        cylinder(d=300, h=22+2);
        translate([-1, 350, -130]) 
        Rotate([0, 90, 0])
        cylinder(d=300, h=22+2);

        translate([-1, railing_height - 1260, -105]) 
        Rotate([45, 0, 0])
        Cube(railing_plank_thickness + 2, 100, 100);
        translate([-1, railing_height - 1260, 170 + 100/2 - 85]) 
        Rotate([45, 0, 0])
        Cube(railing_plank_thickness + 2, 100, 100);
      }
    }
  }

  module 22x170(length = 100) {
    Cube(22, length, 170);
  }

  module 34x140(length = 100) {
    Cube(34, length, 140);
  }

  module 34x120(length = 100) {
    Cube(34, length, 120);
  }

  module 34x120(length = 100) {
    Cube(34, length, 120);
  }

  module 34x70(length = 100) {
    Cube(34, length, 70);
  }

  module 45x70(length = 100) {
    Cube(45, length, 70);
  }

  module 70x70(length = 100) {
    Cube(70, length, 70);
  }

  module 95x95(length = 100) {
    Cube(95, length, 95);
  }

  module Cube(width, length, height) {
    color("#ffeb91")
    cube([width, length, height]);
  }
}

module Rotate(rotation = [0, 0, 0], originOffset = [0, 0, 0], debug = false) {
  translate(originOffset)
  rotate(rotation)
  translate(-originOffset)
  children();

  if (debug) {
    translate(originOffset) 
    #sphere(r=20);
  }
}

module Debug(hide = false, transparent = false, translate_x = false, translate_y = false, translate_z = false) {
  if (debug) {
    if (transparent) {
      %children();
    } else {
      children();
    }
  } else {
  children();
  }
}
