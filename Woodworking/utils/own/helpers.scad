module Cube(width, length, height) {
  color("#ffeb91")
  cube([width, length, height]);
}

module 22x170(length = 100) {
  Cube(22, length, 170);
}

module 34x70(length = 100) {
  Cube(34, length, 70);
}

module 34x120(length = 100) {
  Cube(34, length, 120);
}

module 34x140(length = 100) {
  Cube(34, length, 140);
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

module 95x190(length = 100) {
  Cube(95, length, 195);
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

module explode(part_pos, origin=[0,0,0], mask=[1, 1, 1], factor=1.0, enable=true, debug=false) {
    // Show the origin point once (using a small sphere)
    if (enable && debug) {
        %color("red", 0.5) translate(origin) sphere(d=50, $fn=20);
    }

    if (enable) {
        // Calculate the vector from the origin to where the part "lives"
        rel_vector = part_pos - origin;

        masked_vector = [
            rel_vector[0] * mask[0], 
            rel_vector[1] * mask[1], 
            rel_vector[2] * mask[2]
        ];

        
        // Move the part: Origin + (Direction * Factor)
        // We subtract part_pos at the end because the child is usually 
        // already translated to its position in the main code.
        translate(origin + (masked_vector * factor) - part_pos)
            children();
    } else {
        children(); // Do nothing if not enabled
    }
}


// module explode( distance=[10,10,10], origin=[0,0,0], factor = 2, enable=true, debug=false ) {
//     // Debug Origin Sphere
//     if (enable && debug) {
//         %color("red", 0.5) translate(origin) sphere(d=200, $fn=20);
//     }

//     if (enable) {
//         for (i = [0 : 1 : $children-1]) {
//             // 1. We need to know where the part is 'supposed' to be.
//             // Since children(i) are just geometry, we assume their 
//             // 'base' position is their index multiplied by distance.
//             part_pos = [i * distance[0], i * distance[1], i * distance[2]];
            
//             // 2. Calculate vector from origin to the part
//             rel_vector = part_pos - origin;
            
//             // 3. Move from origin + (relative direction * offset)
//             // Note: Use a multiplier (e.g., 2) to actually see the "gap" grow
//             translate(origin + rel_vector * 2) {
//                 children(i);
//             }
//         }
//     } else {
//         // NOT ENABLED - Standard layout
//         for (i = [0 : 1 : $children-1]) {
//             translate([i * distance[0], i * distance[1], i * distance[2]])
//                 children(i);
//         }
//     }
// }

// module explode( distance, center, enable ) {
//     if ( (enable) && (!center) ) {
//       echo(str("distance = ", distance));
//       echo(str("center = ", center));
//       echo(str("enable = ", enable));

        
//      for ( i= [0:1:$children-1]) {  // step needed in case $children < 2                
//       echo(str("i = ", i));
//         translate( [i*distance[0],i*distance[1],i*distance[2]] ) {
//             children(i);
//         } 
//       } 
//     }
    
//     //CENTERED
    
//     if ( (enable) && (center) ) {
//         count = $children - 1;
//         explode_start = ( [ (count*distance[0])/2 * -1, (count*distance[1])/2 *-1,(count*distance[2])/2 * -1 ] ) ;
        


//         for ( i= [0:1:$children-1])   // step needed in case $children < 2  
//         translate( explode_start ) {
//             translate( [i*distance[0],i*distance[1],i*distance[2] ] ) {
//                 children(i);
//             }    
//         }
//     }

//     //NOT ENABLED - Include un-altered children

//     if (!enable) {        
//         for ( i= [0:1:$children-1]){   // step needed in case $children < 2     


//             children(i);
//         }         
//     }
// }
