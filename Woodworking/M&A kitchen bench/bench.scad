$fn = 50;

debug = true;
debug = false;

depth = 330;

cabinet_height = 897;
cabinet_width = 660;
cabinet_overhang = 20;
cabinet_top_thickness = 30;

bench_height = 450 - 40;
bench_width = 1600;
bench_overhang = 50;
bench_top_thickness = 18;

plywood_thickness = 18;

//

Cabinet();
Bench();

//

module Cabinet() {
  // Skåp
  if (debug) {
    color("#80000085")
    %Cube(depth, cabinet_width, cabinet_height);
  }

    // bärlina bak uppe
    translate([0, 0, cabinet_height - 34 - cabinet_top_thickness]) 
    34x34(cabinet_width);

    // "bärlina" fram uppe
    translate([depth - 34, 0, cabinet_height - 34 - cabinet_top_thickness]) 
    34x34(cabinet_width);

    // "bärlina" fram nere
    translate([depth - 34, 0, 0]) 
    34x34(cabinet_width);

  // Väggar
  Cube(depth, plywood_thickness, cabinet_height - cabinet_top_thickness);

  translate([0, cabinet_width - plywood_thickness, 0]) 
  Cube(depth, plywood_thickness, cabinet_height - cabinet_top_thickness);

  // Skiva
  translate([0, 0, cabinet_height - cabinet_top_thickness]) 
  Cube(depth + cabinet_overhang, cabinet_width + cabinet_overhang, cabinet_top_thickness);

  // hyllplan
  translate([0, 0, 34]) 
  Cube(depth, cabinet_width, 12);

  translate([0, 0, bench_height - 12]) 
  Cube(depth, cabinet_width, 12);

  // dörr
  translate([depth, 0, 0])
  Rotate([0, 0, -45 - 45 * sin($t*360)]) 
  Cube(12, cabinet_width, cabinet_height - cabinet_top_thickness);
}

module Bench() {
  // Bänk
  translate([0, cabinet_width, 0]) {
    if (debug)
    color("#80000085")
    %Cube(depth, bench_width, bench_height);

    // skiva
    translate([0, 0, bench_height - bench_top_thickness]) 
    Cube(depth + bench_overhang, bench_width, bench_top_thickness);

    // bärlina bak uppe
    translate([0, 0, bench_height - 34 - bench_top_thickness]) 
    34x34(bench_width);

    // "bärlina" fram uppe
    translate([depth - 34, 0, bench_height - 34 - bench_top_thickness]) 
    34x34(bench_width);

    // "bärlina" fram nere
    translate([depth - 34, 0, 0]) 
    34x34(bench_width);

    // legs
    nbr_of_legs = 3;
    for (i=[0:nbr_of_legs - 1]) {
      translate([0, ((bench_width - plywood_thickness) / (nbr_of_legs-1)) * i, 0]) {
        // translate([depth - 34, 34, 0]) 
        // Rotate([90, 0, 0]) 
        // 34x34(bench_height - bench_top_thickness);

        // translate([34, 34, bench_height - 34 - bench_top_thickness]) 
        // Rotate([0, 0, -90]) 
        // 34x34(depth - 34*2);

        Cube(depth, plywood_thickness, bench_height - bench_top_thickness);
      }
    }

    // lådor
    translate([0, 0, 16]) 
    Cube(0, 0, bench_height - 16*2 - bench_top_thickness);
  }
}

module 34x34(length = 100) {
  Cube(34, length, 34);
}

module Cube(width, length, height) {
  color("#ffeb91")
  cube([width, length, height]);
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
