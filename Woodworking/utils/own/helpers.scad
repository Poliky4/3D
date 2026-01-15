module Cube(width, length, height) {
  color("#ffeb91")
  cube([width, length, height]);
}

module Rotate(rotation = [0, 0, 0], origin = [0, 0, 0], debug = false) {
  translate(origin)
  rotate(rotation)
  translate(-origin)
  children();

  if (debug) {
    translate(origin) 
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
