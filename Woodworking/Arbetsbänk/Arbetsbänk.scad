$fn = 50;

debug = true;
debug = false;

include_tool_well = true;
include_tool_well = false;

total_length = 1460;
total_height = 900;
total_width = 540;

top_length = total_length;
top_width = total_width;
top_thickness = 70;

stretcher_length = top_length - 200;

foot_length = total_width;
leg_length = total_height - top_thickness;

leg_support_top_length = 45*10;
leg_support_bottom_length = total_width - 70*2 - 45*4;

top_stock_length = (top_length * 12) / 1000;
45x70_stock_length = ceil((top_stock_length + (leg_support_bottom_length / 1000)) / 3);

leg_stock_length = (foot_length*2 + leg_length*4 + leg_support_top_length*2) / 1000;
70x70_stock_length = ceil((leg_stock_length) / 3);

stretcher_stock_length = (stretcher_length*2) / 1000;
34x70_stock_length = ceil((stretcher_stock_length) / 3);

//

echo(str(""));
echo(str("Top: 45x70 = ", top_stock_length, "m"));
echo(str(""));
echo(str("leg_length = ", leg_length));
// leg = 700 1400 2100 2800 = 1x3m
// fot + support = 540 1080 + 520 1040 = 2120 = 1x3m
echo(str("Legs: 45x70 = ", (leg_support_bottom_length) / 1000, "m"));
echo(str("Legs: 70x70 = ", leg_stock_length, "m"));
echo(str(""));
echo(str("Stretchers: 34x70 = ", (stretcher_length*2*2) / 1000, "m"));
echo(str(""));
// top + one leg support
echo(str("45x70 =  ", 45x70_stock_length, "m"));
echo(str("45x70 = 2x3m = ", 45x70_stock_length * 75, "kr"));
echo(str(""));
// feet + legs + leg top supports
echo(str("70x70 =  ", 70x70_stock_length, "m"));
echo(str("70x70 =  ", 70x70_stock_length * 150, "kr (3.6m)"));
echo(str(""));
// stretchers
// 34x70 finns inte i lager, 45x70 istället?
// echo(str("34x70 =  ", 34x70_stock_length, "m"));
// echo(str("34x70 =  ", 34x70_stock_length * 51, "kr (3.6m)"));
echo(str("45x70 =  ", 34x70_stock_length, "m"));
echo(str("45x70 =  ", 34x70_stock_length * 75, "kr (3.6m)"));
echo(str(""));

//

Moravian();

translate([0, 1500, 0]) 
Scandinavian();

translate([0, 3000, 0]) 
Scandinavian_camlock();

!translate([0, 4500, 0]) 
Scandinavian_screw();


module Moravian() {
  leg_angle = 16;
  
  translate([0, 0, total_height - top_thickness]) 
  Top();

  translate([0, 70, 0]) 
  rotate([-leg_angle, 0, 0]) 
  Leg();
  translate([0, total_length, 0]) 
  rotate([leg_angle, 0, 0]) 
  Leg();

  translate([top_width - 34/2 - 34 - 45*2 - 70/4, 0, 200]) 
  Stretcher();
  translate([90, 0, 200]) 
  Stretcher();

  translate([117, -10, 120]) 
  rotate([-leg_angle, 0, 0]) 
  Tap();
  translate([407, -10, 120]) 
  rotate([-leg_angle, 0, 0]) 
  Tap();

  translate([133, top_length + 5, 120]) 
  rotate([-leg_angle, 0, 180]) 
  Tap();
  translate([422, top_length + 5, 120]) 
  rotate([-leg_angle, 0, 180]) 
  Tap();

  // Modules

  module Top() {
    difference() {
      // Cube(top_width, top_length, top_thickness);
      for (i=[0:11]) {
        translate([i*(45), 0, 0])
        45x70(top_length);

        // if (i != 11) {
        //   color("black")
        //   translate([i*45 + 45, -1, -1])
        //   Cube(1, top_length+2, top_thickness+2);
        // }
      }

      // tool well
      if (include_tool_well) {
        translate([45, 60, 30]) 
        Cube(45*4 + 1, top_length - 60*2, 100);
      }
    }
  }

  module Leg() {
    // leg
    translate([45*2, 0, 70]) 
    rotate([90, 0, 0]) 
    70x70(leg_length + 100);

    // leg
    translate([total_width - 70 - 45*2, 0, 70]) 
    rotate([90, 0, 0]) 
    70x70(leg_length + 100);

    // support bottom
    translate([leg_support_bottom_length + 45*2 + 70, -45 - 45/4, leg_length + 100]) 
    rotate([0, 0, 90]) 
    45x70(leg_support_bottom_length);

    // support middle
    translate([leg_support_bottom_length + 45*2 + 70, -45 - 45/4, 120]) 
    rotate([0, 0, 90]) 
    45x70(leg_support_bottom_length);

    // support top
    translate([leg_support_bottom_length + 45*2 + 70, -45 - 45/4, 500]) 
    rotate([0, 0, 90]) 
    45x70(leg_support_bottom_length);
  }

  module Tap() {
    color("#962")
    render()
    difference() {
      width = 14;
      length = 40;
      height = 300;
      Cube(width, length, height);
      translate([0, -16, -20]) 
      scale(1.1) 
      rotate([6, 0, 0]) 
      Cube(width, length, height);
    }
  }

  module Stretcher() {
    translate([0, -50, 0]) 
    70x70(stretcher_length + 300);
    // translate([70/2, -50, 70]) 
    // 70x70(stretcher_length + 300);
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

  module Cube(width, length, height) {
    color("#ffeb91")
    cube([width, length, height]);
  }
}

module Scandinavian() {
  translate([0, 0, total_height - top_thickness]) 
  Top();

  translate([0, 70 + 200, 0]) 
  Leg();
  translate([0, total_length - 200, 0]) 
  Leg();

  translate([top_width - 34/2 - 34 - 45*2 - 70/4, 0, 200]) 
  Stretcher();
  translate([90, 0, 200]) 
  Stretcher();

  translate([117, 160, 120]) 
  Tap();
  translate([407, 160, 120]) 
  Tap();

  translate([133, top_length-160, 120]) 
  rotate([0, 0, 180]) 
  Tap();
  translate([422, top_length-160, 120]) 
  rotate([0, 0, 180]) 
  Tap();

  // Modules

  module Top() {
    difference() {
      // Cube(top_width, top_length, top_thickness);
      for (i=[0:11]) {
        translate([i*(45), 0, 0])
        45x70(top_length);

        // if (i != 11) {
        //   color("black")
        //   translate([i*45 + 45, -1, -1])
        //   Cube(1, top_length+2, top_thickness+2);
        // }
      }

      // tool well
      if (include_tool_well) {
        translate([45, 60, 30]) 
        Cube(45*4 + 1, top_length - 60*2, 100);
      }
    }
  }

  module Leg() {
    // leg
    translate([45*2, 0, 70]) 
    rotate([90, 0, 0]) 
    70x70(leg_length);

    // leg
    translate([total_width - 70 - 45*2, 0, 70]) 
    rotate([90, 0, 0]) 
    70x70(leg_length);

    // foot
    translate([0, 0, 0]) 
    rotate([0, 0, -90]) 
    70x70(foot_length);

    // support bottom
    translate([leg_support_bottom_length + 45*2 + 70, -45 - 45/4, 500]) 
    rotate([0, 0, 90]) 
    45x70(leg_support_bottom_length);

    // support top
    translate([45, 0, total_height - 70*2]) 
    rotate([0, 0, -90]) 
    70x70(leg_support_top_length);
  }

  module Tap() {
    color("#962")
    render()
    difference() {
      width = 14;
      length = 40;
      height = 300;
      Cube(width, length, height);
      translate([0, -16, -20]) 
      scale(1.1) 
      rotate([6, 0, 0]) 
      Cube(width, length, height);
    }
  }

  module Stretcher() {
    translate([34/2, 100, 0]) 
    difference() {
      34x70(stretcher_length);
      
    }
    translate([34/2, 100, 70]) 
    34x70(stretcher_length);
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

  module Cube(width, length, height) {
    color("#ffeb91")
    cube([width, length, height]);
  }
}

module Scandinavian_camlock() {
  translate([0, 0, total_height]) 
  Top();

  translate([0, 70 + 200, 0]) 
  Leg();
  translate([0, total_length - 200, 0]) 
  Leg();

  translate([total_width, 200 + 70, 0]) 
  translate([-70 * sin($t*360), 0, 0]) 
  LegVise_camlock();

  translate([top_width - 45, 500, 270]) 
  translate([0, 200 - 200*sin($t*360), 0]) 
  Deadmans();

  translate([top_width - 45*1.5, 0, 200]) 
  Stretcher();
  translate([0, 0, 200]) 
  Stretcher();

  translate([28, 160, 200]) 
  Tap();
  translate([497, 160, 200]) 
  Tap();

  translate([42, top_length-160, 200]) 
  rotate([0, 0, 180]) 
  Tap();
  translate([518, top_length-160, 200]) 
  rotate([0, 0, 180]) 
  Tap();

  // Shelf
  // translate([0, 270, 340]) 
  // scale([1, 0.63, 0.2]) 
  // Top();

  // Modules

  module Top() {
    difference() {
      // Cube(top_width, top_length, top_thickness);
      for (i=[0:11]) {
        translate([i*(45), 0, 0])
        45x70(top_length);

        // if (i != 11) {
        //   color("black")
        //   translate([i*45 + 45, -1, -1])
        //   Cube(1, top_length+2, top_thickness+2);
        // }
      }

      // tool well
      if (include_tool_well) {
        translate([45, 60, 30]) 
        Cube(45*4 + 1, top_length - 60*2, 100);
      }
    }
  }

  module Leg() {
    // leg
    translate([0, 0, 70]) 
    rotate([90, 0, 0]) 
    70x70(leg_length);

    // leg
    translate([total_width - 70, 0, 70]) 
    rotate([90, 0, 0]) 
    70x70(leg_length);

    // support top (bridle)
    render()
    translate([-1, 0, 0]) scale([1.002, 1, 1]) 
    translate([0, -45/4, leg_length]) 
    rotate([0, 0, -90]) 
    difference() {
      45x70(top_width);
      
      Cube(10, 70, 70);
      translate([45 - 10, 0, 0]) 
      Cube(10, 70, 70);

      translate([0, top_width - 70, 0]) 
      Cube(10, 70, 70);
      translate([45 - 10, top_width - 70, 0]) 
      Cube(10, 70, 70);
    }

    // support middle (draw bored m&t)
    // render()
    // translate([top_width, -45 - 45/4, 500]) 
    // rotate([0, 0, 90]) 
    // 45x70(top_width);

    // support bot (dovetail as traditional or draw bored m&t?)
    render()
    translate([-1, 0, 0]) scale([1.002, 1, 1]) 
    translate([0, -45/4, 120]) 
    rotate([0, 0, -90]) 
    difference() {
      45x70(top_width);

      Cube(10, 70, 70);
      translate([45 - 10, 0, 0]) 
      Cube(10, 70, 70);

      translate([0, top_width - 70, 0]) 
      Cube(10, 70, 70);
      translate([45 - 10, top_width - 70, 0]) 
      Cube(10, 70, 70);
    }
  }

  module LegVise_camlock() {

    // big block thing
    translate([70*1, 0, 0]) 
    difference() {
      union () {
        translate([0, -70 + 47, 70 + 2]) 
        rotate([90 + 3, 0, 0]) 
        45x70(total_height + 5);
        translate([0, 0, 70]) 
        rotate([90, 0, 0]) 
        45x70(total_height);
        translate([0, 70 - 47, 70-2]) 
        rotate([90 - 3, 0, 0]) 
        45x70(total_height+5);
      }
      translate([-1, -160, total_height+70]) 
      Cube(45+2, 260, 20);
      translate([-1, -160, 50]) 
      Cube(45+2, 260, 20);
      translate([52, -160, total_height-20]) 
      rotate([0, -22, 0]) 
      Cube(45, 260, 100);
    }

    // upper support thingy
    render()
    translate([-390, -45/2 - 70/2 + 45, 560]) 
    difference() {
      union() {
        rotate([0, 0, -90]) 
        45x70(560);
        translate([0, 0, -45]) 
        rotate([0, 0, -90]) 
        45x70(560);
      }
      translate([460, -45, 40]) 
      Cube(100, 45, 30);
      translate([460, -45, -45]) 
      Cube(100, 45, 30);
    }

    // lever
    union() {
      // translate([206, -12.5, 557.5]) 
      translate([10, 0, -10]) 
      translate([-10 * sin($t*360), 0, 0]) 
      translate([146, -12.5, 527.5]) 
      Rotate([-40 - 50 * sin($t*360), 0, -90], [0, 0, 45]) 
      // translate([0, 0, 0]) 
      // rotate([0, 0, -90]) 
      // translate([0, -40, 0]) 
      translate([0, 0, 20]) 
      union() {
        translate([45, 0, 0]) 
        difference() {
          45x70_rounded(120);
          translate([3, 120 + 2, -1]) 
          rotate([0, 0, -45]) 
          Cube(60, 60, 70+2);
        }
        translate([0, 35, 0]) 
        45x70_rounded(330);
        translate([-45, 0, 0]) 
        difference() {
          45x70_rounded(120);
          translate([0, 120 - 40, -1]) 
          rotate([0, 0, 45]) 
          Cube(60, 60, 70+2);
        }
        offset = 20;
        translate([45, 0, 70/2-offset/2]) 
        rotate([0, 90, 0]) 
        cylinder(d=70+offset, h=45);
        translate([-45, 0, 70/2-offset/2]) 
        rotate([0, 90, 0]) 
        cylinder(d=70+offset, h=45);
      }

      // translate([200, 200, 0]) 
      // #Rotate([0, 100*sin($t*360), 0], [0, 0, 0])
      // Cube(100, 100, 100);

      color("#962")
      translate([142, -35, 572]) 
      rotate([90, 0, 0]) 
      cylinder(d=24, h=150, center=true);
    }
  }

  module Deadmans() {
    difference() {
      union() {
        translate([0, 70, 70]) 
        rotate([90, 0, 0]) 
        45x70(560);
        translate([0, 70 + 45, 70]) 
        rotate([90, 0, 0]) 
        45x70(560);
      }

      for (i=[0:11]) {
        translate([20, i % 2 ? 33 : 80  , 100 + i * 45]) 
        rotate([0, 90, 0]) 
        cylinder(d=30, h=80, center=true);
      }
    }
  }

  module Tap() {
    color("#962")
    render()
    difference() {
      width = 14;
      length = 40;
      height = 140;
      Cube(width, length, height);
      translate([0, -16, -16]) 
      scale(1.1) 
      rotate([6, 0, 0]) 
      Cube(width, length, height);
    }
  }

  module Stretcher() {
    color("#ffeb91")
    union() {
      render()
      translate([34/2, 100, 0]) 
      difference() {
        34x70(stretcher_length);
        Cube(34, 170, 30);
        translate([0, stretcher_length - 170, 0]) 
        Cube(34, 170, 30);
      }
      render()
      translate([34/2, 100, 70]) 
      difference() {
        34x70(stretcher_length);
        translate([0, 0, 70 - 30]) 
        Cube(34, 170, 30);
        translate([0, stretcher_length - 170, 70 - 30]) 
        Cube(34, 170, 30);
      }
    }
  }

  module 34x70(length = 100) {
    Cube(34, length, 70);
  }

  module 45x70(length = 100) {
    Cube(45, length, 70);
  }
  
  module 45x70_rounded(length = 100) {
    union() {
      radius = 4;
      translate([0, 0, 70]) 
      rotate([-90, 0, 0]) 
      translate([radius, radius, 0]) 
      minkowski() {
        cylinder(r=radius,h=2);
        Cube(45-radius*2, 70-radius*2, length);
      }
      // rotate([45, 0, 0]) 
      // translate([0, 0, -70]) 
      // #45x70(length);
    }
  }

  module 70x70(length = 100) {
    Cube(70, length, 70);
  }

  module Cube(width, length, height) {
    color("#ffeb91")
    cube([width, length, height]);
  }
}

module Scandinavian_screw() {
  translate([0, 0, total_height]) 
  Top();

  translate([0, 70 + 200, 0]) 
  Leg();
  translate([0, total_length - 200, 0]) 
  Leg();

  translate([total_width, 200 + 70, 0]) 
  LegVise_screw();

  translate([top_width - 45, 500, 270]) 
  translate([0, 200 - 200*sin($t*360), 0]) 
  Deadmans();

  translate([top_width - 45*1.5, 0, 200]) 
  Stretcher();
  translate([0, 0, 200]) 
  Stretcher();

  translate([28, 160, 200]) 
  Tap();
  translate([497, 160, 200]) 
  Tap();

  translate([42, top_length-160, 200]) 
  rotate([0, 0, 180]) 
  Tap();
  translate([518, top_length-160, 200]) 
  rotate([0, 0, 180]) 
  Tap();

  // Shelf
  // translate([0, 270, 340]) 
  // scale([1, 0.63, 0.2]) 
  // Top();

  // Modules

  module Top() {
    difference() {
      // Cube(top_width, top_length, top_thickness);
      for (i=[0:11]) {
        translate([i*(45), 0, 0])
        45x70(top_length);

        // if (i != 11) {
        //   color("black")
        //   translate([i*45 + 45, -1, -1])
        //   Cube(1, top_length+2, top_thickness+2);
        // }
      }

      // tool well
      if (include_tool_well) {
        translate([45, 60, 30]) 
        Cube(45*4 + 1, top_length - 60*2, 100);
      }
    }
  }

  module Leg() {
    // leg
    translate([0, 0, 70]) 
    rotate([90, 0, 0]) 
    70x70(leg_length);

    // leg
    translate([total_width - 70, 0, 70]) 
    rotate([90, 0, 0]) 
    70x70(leg_length);

    // support top (bridle)
    render()
    translate([-1, 0, 0]) scale([1.002, 1, 1]) 
    translate([0, -45/4, leg_length]) 
    rotate([0, 0, -90]) 
    difference() {
      45x70(top_width);
      
      Cube(10, 70, 70);
      translate([45 - 10, 0, 0]) 
      Cube(10, 70, 70);

      translate([0, top_width - 70, 0]) 
      Cube(10, 70, 70);
      translate([45 - 10, top_width - 70, 0]) 
      Cube(10, 70, 70);
    }

    // support middle (draw bored m&t)
    // render()
    // translate([top_width, -45 - 45/4, 500]) 
    // rotate([0, 0, 90]) 
    // 45x70(top_width);

    // support bot (dovetail as traditional or draw bored m&t?)
    render()
    translate([-1, 0, 0]) scale([1.002, 1, 1]) 
    translate([0, -45/4, 120]) 
    rotate([0, 0, -90]) 
    difference() {
      45x70(top_width);

      Cube(10, 70, 70);
      translate([45 - 10, 0, 0]) 
      Cube(10, 70, 70);

      translate([0, top_width - 70, 0]) 
      Cube(10, 70, 70);
      translate([45 - 10, top_width - 70, 0]) 
      Cube(10, 70, 70);
    }
  }

  module LegVise_screw() {

    translate([-70 * sin($t*360), 0, 0]) 
    union() {
      // big block thing
      translate([70*1, -55, 0]) 
      difference() {
        union () {
          translate([0, -70 + 47, 70 + 2]) 
          rotate([90 + 3, 0, 0]) 
          45x70(total_height + 5);
          translate([0, 0, 70]) 
          rotate([90, 0, 0]) 
          45x70(total_height);
          translate([0, 70 - 47, 70-2]) 
          rotate([90 - 3, 0, 0]) 
          45x70(total_height+5);
        }
        translate([-1, -160, total_height+70]) 
        Cube(45+2, 260, 20);
        translate([-1, -160, 50]) 
        Cube(45+2, 260, 20);
        translate([52, -160, total_height-20]) 
        rotate([0, -22, 0]) 
        Cube(45, 260, 100);
      }

      // screw
      // render()
      // translate([-190, -70 - 45/2, 700]) 
      // Rotate([0, 90, 0])
      // cylinder(d=40, h=360);
      render()
      translate([110, -70 - 45/2, 700]) 
      Rotate([0, 90, 0])
      cylinder(d=40, h=60);
      translate([-190, -70 - 45/2, 700]) 
      Rotate([0, 90, 0])
      linear_extrude(height=300, convexity=10, twist=5000)
      translate([5, 0, 0])
      circle(d=40); // screw

      // lever
      translate([140, -45*2, 620]) 
      Rotate([(360*3) * sin($t*360), 0, 0], [0, 0, 80]) 
      union() {
        cylinder(d=24, h=200, center=true);

        translate([0, 0, 110]) 
        sphere(d=35);

        translate([0, 0, -110]) 
        sphere(d=35);
      }

      // bottom support
      translate([-200, -93, 135]) 
      union() {
        Cube(280, 45/2, 45);
      }
    }

    // screw hol(e)der
    translate([-50, -125, 635]) 
    Cube(35, 55, 140);

    // bottom support holder
    translate([-55, -105, 120]) 
    Cube(35, 35, 70);
  }

  module Deadmans() {
    difference() {
      union() {
        translate([0, 70, 70]) 
        rotate([90, 0, 0]) 
        45x70(560);
        translate([0, 70 + 45, 70]) 
        rotate([90, 0, 0]) 
        45x70(560);
      }

      for (i=[0:11]) {
        translate([20, i % 2 ? 33 : 80  , 100 + i * 45]) 
        rotate([0, 90, 0]) 
        cylinder(d=30, h=80, center=true);
      }
    }
  }

  module Tap() {
    color("#962")
    render()
    difference() {
      width = 14;
      length = 40;
      height = 140;
      Cube(width, length, height);
      translate([0, -16, -16]) 
      scale(1.1) 
      rotate([6, 0, 0]) 
      Cube(width, length, height);
    }
  }

  module Stretcher() {
    color("#ffeb91")
    union() {
      render()
      translate([34/2, 100, 0]) 
      difference() {
        34x70(stretcher_length);
        Cube(34, 170, 30);
        translate([0, stretcher_length - 170, 0]) 
        Cube(34, 170, 30);
      }
      render()
      translate([34/2, 100, 70]) 
      difference() {
        34x70(stretcher_length);
        translate([0, 0, 70 - 30]) 
        Cube(34, 170, 30);
        translate([0, stretcher_length - 170, 70 - 30]) 
        Cube(34, 170, 30);
      }
    }
  }

  module 34x70(length = 100) {
    Cube(34, length, 70);
  }

  module 45x70(length = 100) {
    Cube(45, length, 70);
  }
  
  module 45x70_rounded(length = 100) {
    union() {
      radius = 4;
      translate([0, 0, 70]) 
      rotate([-90, 0, 0]) 
      translate([radius, radius, 0]) 
      minkowski() {
        cylinder(r=radius,h=2);
        Cube(45-radius*2, 70-radius*2, length);
      }
      // rotate([45, 0, 0]) 
      // translate([0, 0, -70]) 
      // #45x70(length);
    }
  }

  module 70x70(length = 100) {
    Cube(70, length, 70);
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
