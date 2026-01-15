use <../utils/own/helpers.scad>
use <../utils/3rd party/roundedcube_simple.scad>

$fn = 50;

//

echo(str(""));
echo(str(""));
echo(str(""));

GuitarStand();

echo(str(""));
echo(str(""));
echo(str(""));

//

module GuitarStand() {
  front_piece_thickness = 40;
  front_piece_length = 500;
  front_piece_height = 100;
  
  front_piece_rotation = 127/5;

  back_piece_thickness = 55;
  back_piece_length = 600;
  
  rotate([0, 2, front_piece_rotation]) 
  Front_Piece();
  rotate([0, -2, -front_piece_rotation]) 
  Front_Piece();

  Back_Piece();

  module Front_Piece() {
    render()
    // rotate([-11, 0, 0]) 
    rotate([-5.5, 0, 0]) 
    // translate([0, 0, 108])
    translate([0, 0, 60])
    translate([-front_piece_thickness/2, 10, 0]) 
    difference() {
      Cube(front_piece_thickness, front_piece_length, front_piece_height);
      translate([-8, -10, front_piece_height/2+8]) 
      roundedcube_simple([front_piece_thickness+16, front_piece_length - 30, front_piece_height/2], radius=8);
    }
  }

  // module Front_Piece() {
  //   render()
  //   rotate([-11, 0, 0]) 
  //   translate([0, 0, 108]) 
  //   translate([-front_piece_thickness/2, 0, 0]) 
  //   difference() {
  //     Cube(front_piece_thickness, front_piece_length, front_piece_height);

  //     // cut out for guitar
  //     rotate([90, 0, 90]) 
  //     translate([front_piece_length/2, front_piece_length/2 + front_piece_height/4, -1]) 
  //     linear_extrude(front_piece_thickness+2)
  //     circle(d=front_piece_length, $fn=100);

  //     // rounded bottom front corner
  //     front_corner_size = front_piece_height/4;
  //     front_corner_offset = 25;
  //     rotate([90, 0, 90]) 
  //     translate([front_piece_length - front_corner_size, 0, 0]) 
  //     difference() {
  //       Cube(front_corner_size, front_corner_size, front_piece_thickness+2);
  //       // linear_extrude(front_piece_thickness+2)
  //       // circle(d=front_corner_size, $fn=100);
  //       translate([front_corner_size/2-front_corner_offset, front_corner_size/2+front_corner_offset, -1]) 
  //       linear_extrude(front_piece_thickness+4)
  //       circle(d=front_corner_size*2, $fn=100);
  //     }
  //   }
  // }
  module Back_Piece() {
    translate([-back_piece_thickness/2, 0, 0]) 
    rotate([-5.5, 0, 0]) 
    Cube(back_piece_thickness, back_piece_thickness, back_piece_length);
  }
}
