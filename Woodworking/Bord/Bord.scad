use <../utils/own/helpers.scad>

$fn = 50;

// grillbord höjd 85

//

echo(str(""));
echo(str(""));
echo(str(""));

// Brown()
// translate([0, -2000, 0]) 
// BBQ_Table();

// translate([800, 0, 0]) 
Trestle_Table();

// translate([-800, 0, 0]) 
// Trestle_Table_Wide();

// translate([0, 3000, 0]) 
// Cross_Leg_Table();

echo(str(""));
echo(str(""));
echo(str(""));

//

module BBQ_Table() {
  top_width = 800;
  top_length = 800;
  top_thickness = 70;

  leg_height = 850; // TODO: measure
  leg_thickness = 70;
  leg_offset = 100; // distance from edge

  stretcher_offset = 300; // distance from floor

  // Top
  translate([0, 0, leg_height]) 
  Cube(top_width, top_length, top_thickness);

  // Top extensions
  // translate([top_width, 0, leg_height])
  // Rotate([0, 90 - 90*sin($t*180), 0])
  // Cube(top_width/2, top_length, top_thickness);

  // translate([-top_width/2, 0, leg_height])
  // Rotate([0, -90 + 90*sin($t*180), 0], [top_width/2, 0, 0])
  // Cube(top_width/2, top_length, top_thickness);

  // Legs
  translate([leg_offset, leg_offset, 0]) 
  Cube(leg_thickness, leg_thickness, leg_height);

  translate([top_width - leg_offset - leg_thickness, leg_offset, 0]) 
  Cube(leg_thickness, leg_thickness, leg_height);

  translate([leg_offset, top_width - leg_offset - leg_thickness, 0]) 
  Cube(leg_thickness, leg_thickness, leg_height);

  translate([top_width - leg_offset - leg_thickness, top_width - leg_offset - leg_thickness, 0]) 
  Cube(leg_thickness, leg_thickness, leg_height);

  // Apron
  apron_thickness = 30; // TODO: measure
  apron_height = 60; // TODO: measure
  translate([leg_offset + leg_thickness, leg_offset + leg_thickness/2 - apron_thickness/2, leg_height - apron_height]) 
  Cube(top_width - leg_offset*2 - leg_thickness*2, apron_thickness, apron_height);

  translate([leg_offset + leg_thickness/2 - apron_thickness/2, leg_offset + leg_thickness, leg_height - apron_height]) 
  Cube(apron_thickness, top_width - leg_offset*2 - leg_thickness*2, apron_height);

  translate([leg_offset + leg_thickness, top_width - leg_offset - apron_thickness - leg_thickness/2 + apron_thickness/2, leg_height - apron_height]) 
  Cube(top_width - leg_offset*2 - leg_thickness*2, apron_thickness, apron_height);

  translate([top_width - leg_offset - apron_thickness - leg_thickness/2 + apron_thickness/2, leg_offset + leg_thickness, leg_height - apron_height]) 
  Cube(apron_thickness, top_width - leg_offset*2 - leg_thickness*2, apron_height);

  // Apron / Top connectors
  connector_width = 40;
  connector_length = 30;
  connector_height = 20;
  
  translate([300, 150, leg_height - connector_height])
  Cube(connector_width, connector_length, connector_height);
  translate([550, 150, leg_height - connector_height])
  Cube(connector_width, connector_length, connector_height);

  translate([300, top_width - 180, leg_height - connector_height])
  Cube(connector_width, connector_length, connector_height);
  translate([550, top_width - 180, leg_height - connector_height])
  Cube(connector_width, connector_length, connector_height);

  translate([150, 300, leg_height - connector_height])
  Cube(connector_length, connector_width, connector_height);
  translate([150, 550, leg_height - connector_height])
  Cube(connector_length, connector_width, connector_height);

  translate([top_width - 180, 300, leg_height - connector_height])
  Cube(connector_length, connector_width, connector_height);
  translate([top_width - 180, 550, leg_height - connector_height])
  Cube(connector_length, connector_width, connector_height);

  // Stretchers
  stretcher_thickness = 30; // TODO: measure
  stretcher_height = 60; // TODO: measure
  translate([leg_offset + leg_thickness, leg_offset + leg_thickness/2 - stretcher_thickness/2, stretcher_offset - stretcher_height]) 
  Cube(top_width - leg_offset*2 - leg_thickness*2, stretcher_thickness, stretcher_height);

  translate([leg_offset + leg_thickness/2 - stretcher_thickness/2, leg_offset + leg_thickness, stretcher_offset - stretcher_height]) 
  Cube(stretcher_thickness, top_width - leg_offset*2 - leg_thickness*2, stretcher_height);

  translate([leg_offset + leg_thickness, top_width - leg_offset - stretcher_thickness - leg_thickness/2 + stretcher_thickness/2, stretcher_offset - stretcher_height]) 
  Cube(top_width - leg_offset*2 - leg_thickness*2, stretcher_thickness, stretcher_height);

  translate([top_width - leg_offset - stretcher_thickness - leg_thickness/2 + stretcher_thickness/2, leg_offset + leg_thickness, stretcher_offset - stretcher_height]) 
  Cube(stretcher_thickness, top_width - leg_offset*2 - leg_thickness*2, stretcher_height);

  // Lower top (?)
  translate([leg_offset + leg_thickness/2, leg_offset + leg_thickness/2, stretcher_offset - 45]) 
  Cube(top_width - leg_offset*2 - leg_thickness, top_width - leg_offset*2 - leg_thickness, 45);
}

module Trestle_Table() {

  // leg material (70x70) =  
  // leg top support material (70x70) = 560
  // leg foot material (70x70) = 560

  // leg material (70x70) = 1230
  // leg top support material (70x70) = 560
  // leg foot material (70x70) = 560

  // stretcher material (45x70) = 4280

  // BOM
  // 70x70
  //   615 x 4
  //   = 2460
  //   560 x 4
  //   = 2260
  // 45x70
  //   2140 x 2
  //   = 4280

  height = 780;
  
  top_width = 880;
  top_length = 2600;
  top_thickness = 45;

  // echo(str("top: 34x70 = ", (stretcher_length*2*2) / 1000, "m"));

  leg_height = height - top_thickness;
  leg_thickness = 70;
  leg_thickness_x = 70;
  // leg_thickness_y = 45;
  leg_thickness_y = 70;
  leg_offset_x = 80; // distance from edge
  // leg_offset_y = 300; // distance from edge
  leg_offset_y = 400; // distance from edge

  stretcher_offset = 200; // distance from floor
  stretcher_width = 45;

  // top
  Brown()
  translate([0, 0, leg_height]) 
  Cube(top_width, top_length, top_thickness);

  Brown()
  translate([0, leg_offset_y, 0]) 
  Leg();
  Brown()
  translate([0, top_length - leg_thickness - leg_offset_y, 0]) 
  Leg();

  // stretcher
  translate([top_width/2 - stretcher_width/2, leg_offset_y - leg_thickness, stretcher_offset]) {
    Brown()
    difference() {
      Cube(stretcher_width, top_length - leg_offset_y*2 + leg_thickness*2, leg_thickness*2);
      echo(str("stretcher material (45x70) = ", (top_length - leg_offset_y*2 + leg_thickness*2) * 2));

      translate([-1, -1, -1]) 
      Cube(stretcher_width+2, leg_thickness*2, leg_thickness/2+2);
      translate([-1, -1, leg_thickness*2-leg_thickness/2]) 
      Cube(stretcher_width+2, leg_thickness*2, leg_thickness+1);

      translate([-1, top_length - leg_offset_y*2 + 1, -1]) 
      Cube(stretcher_width+2, leg_thickness*2, leg_thickness/2+2);
      translate([-1, top_length - leg_offset_y*2 + 1, leg_thickness*2-leg_thickness/2]) 
      Cube(stretcher_width+2, leg_thickness*2, leg_thickness+1);
    }

    translate([9, 30, -40]) 
    Tap();

    translate([25, top_length - leg_offset_y*2 + leg_thickness + 40, -40]) 
    Rotate([0, 0, 180])
    Tap();

    // translate([0, 0, 0]) 
    // Tap();
  }


  module Tap() {
    color("#631")
    render()
    difference() {
      width = 16;
      length = 40;
      height = 200;
      Cube(width, length, height);
      translate([0, -16, -20]) 
      scale(1.1) 
      rotate([6, 0, 0]) 
      Cube(width, length, height);
    }
  }

  module Leg() {
    // leg
    echo(str("leg material (70x70) = ", (leg_height-leg_thickness * 2) * 2));
    translate([top_width/2 - leg_thickness, 0, leg_thickness]) {
      Cube(leg_thickness, leg_thickness_y, leg_height-leg_thickness*2); // 615 (x 4 = 2460)
      translate([leg_thickness, 0, 0]) 
      Cube(leg_thickness, leg_thickness_y, leg_height-leg_thickness*2);
    }
    // top support
    echo(str("leg top support material (70x70) = ", top_width-leg_offset_x*2));
    translate([leg_offset_x, 0, leg_height-leg_thickness]) 
    difference() {
      Cube(top_width-leg_offset_x*2, leg_thickness_y, leg_thickness); // 

      translate([-12, -1, -30]) 
      rotate([0, 9, 0]) 
      Cube((top_width-leg_offset_x*2)/2 + 2, leg_thickness_y + 2, leg_thickness + 2);

      translate([(top_width-leg_offset_x*2) + 12, leg_thickness + 1, -30]) 
      rotate([0, 9, 180]) 
      Cube((top_width-leg_offset_x*2)/2 + 2, leg_thickness_y + 2, leg_thickness + 2);
    }
    // foot
    echo(str("leg foot material (70x70) = ", top_width-leg_offset_x*2));
    translate([leg_offset_x, 0, 0]) 
    difference() {
      Cube(top_width-leg_offset_x*2, leg_thickness_y, leg_thickness);

      translate([0, -1, 30]) 
      rotate([0, -9, 0]) 
      Cube((top_width-leg_offset_x*2)/2 + 2, leg_thickness_y + 2, leg_thickness + 2);

      translate([(top_width-leg_offset_x*2), leg_thickness + 1, 30]) 
      rotate([0, -9, 180]) 
      Cube((top_width-leg_offset_x*2)/2 + 2, leg_thickness_y + 2, leg_thickness + 2);
    }
  }
}

module Trestle_Table_Wide() {
  top_width = 1100;
  top_length = 2600;
  top_thickness = 45;

  // echo(str("top: 34x70 = ", (stretcher_length*2*2) / 1000, "m"));

  leg_height = 800; // TODO: measure
  leg_thickness = 70;
  leg_thickness_x = 70;
  // leg_thickness_y = 45;
  leg_thickness_y = 70;
  leg_offset_x = 160; // distance from edge
  leg_offset_y = 300; // distance from edge

  stretcher_offset = 200; // distance from floor

  // top
  Brown()
  translate([0, 0, leg_height]) 
  Cube(top_width, top_length, top_thickness);

  Brown()
  translate([0, leg_offset_y, 0]) 
  Leg();
  Brown()
  translate([0, top_length - leg_thickness - leg_offset_y, 0]) 
  Leg();

  // stretcher
  translate([top_width/2 - 34/2, leg_offset_y - leg_thickness, stretcher_offset]) {
    Brown()
    difference() {
      Cube(34, top_length - leg_offset_y*2 + leg_thickness*2, leg_thickness*2);

      translate([-1, -1, -1]) 
      Cube(34+2, leg_thickness*2, leg_thickness/2+2);
      translate([-1, -1, leg_thickness*2-leg_thickness/2]) 
      Cube(34+2, leg_thickness*2, leg_thickness+1);

      translate([-1, top_length - leg_offset_y*2 + 1, -1]) 
      Cube(34+2, leg_thickness*2, leg_thickness/2+2);
      translate([-1, top_length - leg_offset_y*2 + 1, leg_thickness*2-leg_thickness/2]) 
      Cube(34+2, leg_thickness*2, leg_thickness+1);
    }

    translate([9, 30, -40]) 
    Tap();

    translate([25, top_length - leg_offset_y*2 + leg_thickness + 40, -40]) 
    Rotate([0, 0, 180])
    Tap();

    // translate([0, 0, 0]) 
    // Tap();
  }


  module Tap() {
    color("#631")
    render()
    difference() {
      width = 16;
      length = 40;
      height = 200;
      Cube(width, length, height);
      translate([0, -16, -20]) 
      scale(1.1) 
      rotate([6, 0, 0]) 
      Cube(width, length, height);
    }
  }

  module Leg() {
    translate([top_width/2 - leg_thickness, 0, leg_thickness]) {
      Cube(leg_thickness, leg_thickness_y, leg_height-leg_thickness*2);
      translate([leg_thickness, 0, 0]) 
      Cube(leg_thickness, leg_thickness_y, leg_height-leg_thickness*2);
    }
    // top support
    translate([leg_offset_x, 0, leg_height-leg_thickness]) 
    Cube(top_width-leg_offset_x*2, leg_thickness_y, leg_thickness);
    // foot
    translate([leg_offset_x, 0, 0]) 
    Cube(top_width-leg_offset_x*2, leg_thickness_y, leg_thickness);
  }
}

module Cross_Leg_Table() {
  top_width = 1000;
  top_length = 2400;
  top_thickness = 34;
  
  // echo(str("top: 34x70 = ", (stretcher_length*2*2) / 1000, "m"));

  leg_height = 800; // TODO: measure
  leg_thickness = 70;
  leg_offset = 300; // distance from edge

  stretcher_offset = 430; // distance from floor

  // top
  translate([0, 0, leg_height]) 
  Cube(top_width, top_length, top_thickness);

  translate([0, leg_offset, 0]) 
  Leg();
  translate([0, top_length - leg_thickness - leg_offset, 0]) 
  Leg();

  // stretcher
  translate([top_width/2 - leg_thickness/2, leg_offset - leg_thickness, stretcher_offset]) 
  Cube(leg_thickness, top_length - leg_offset*2 + leg_thickness*2, leg_thickness);

  module Leg() {
    difference() {
      union() {
        translate([120, 0, 142.4]) 
        Rotate([0, 45, 0])
        Cube(leg_thickness, leg_thickness, 1000);
        translate([820, 0, 92.9]) 
        Rotate([0, -45, 0]) {
          Cube(leg_thickness, leg_thickness, 1000);
          translate([leg_thickness/2, leg_thickness/2, 500]) 
          rotate([90, 0, 0]) 
          #cylinder(r=10, h=leg_thickness+20, center=true);
        }
      }
      translate([0, -1, leg_height]) 
      Cube(top_width, leg_thickness+2, 100);
    }
  }
}

//

module Brown() {
  // color("#B84")
  color("#D93")
  children();
}
