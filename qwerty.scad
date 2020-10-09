
$fn= 400;
$stem_throw = 4;
extra_vertical=0;

// .005 purely for aesthetics, to get rid of that ugly crosshatch
function cherry_cross(slop, extra_vertical = 0) = [
  // horizontal tine
  [4.03 + slop, 1.15 + slop / 3],
  // vertical tine
  [1.25 + slop / 3, 4.23 + extra_vertical + slop / 3 + .005],
];
function outer_box_cherry_stem(slop) = [6 - slop, 6 - slop];

module inside_cherry_cross(slop) {
  // inside cross
  // translation purely for aesthetic purposes, to get rid of that awful lattice
  translate([0,0,-0.005]) {
    linear_extrude(height = $stem_throw) {
      square(cherry_cross(slop, extra_vertical)[0], center=true);
      square(cherry_cross(slop, extra_vertical)[1], center=true);
    }
  }

}

module box_cherry_stem(depth, slop) {
  difference(){
    // outside shape
    linear_extrude(height = depth) {
      offset(r=1){
        square(outer_box_cherry_stem(slop) - [2,2], center=true);
      }
    }

    // inside cross
    inside_cherry_cross(slop);
  }
}








module curve(length, dh) {
  r = (pow(length/2, 2) + pow(dh, 2))/(2*dh);
  a = 2*asin((length/2)/r);
  
  translate([-(r -dh), 0, 0])
  rotate([0, 0, -a/2])
  rotate_extrude(angle = a)
  translate([r, 0, 0])
  children();
}


module cap(d=6){
  difference(){
    minkowski(){
      cube([19,19,5],center=true);
      sphere(d=19/4);
    }
    translate([0,0,6])scale([2,2,0.25])sphere(d=19);
    translate([0,0,-3]){
      translate([0,0,0])cube([d,4,d],center=true);
      translate([-1,0,0])cube([4,11,d],center=true);
    }
  }
    
}

module stem(d=5){
//  translate([-d,0,0])rotate([0,90,0])cylinder(d=3,h=d*2);
  translate([0,0,-18]){
    e=d+4;
    f=d+0.9;
    cube([e,f,20],center=true);
    translate([-e/2,0,10])rotate([0,90,0])cylinder(d=f,h=e);
    difference(){
      union(){
        translate([(e-2)/2,0,10])cube([2,f,24],center=true);
        translate([-(e-2)/2,0,10])cube([2,f,24],center=true);
      }
      translate([-d,0,18])rotate([0,90,0])cylinder(d=3.5,d*2);
    }
    translate([0,0,-15])box_cherry_stem(6,0.1);
  }
//  translate([0,0,-27])color([0.7,0.8,0.6])import("switch_mx.stl");
}

module arm(d=5){
  // back
  translate([-d/2,-60,0])rotate([0,90,0]){
    difference(){
      cylinder(d=20,h=d);
      translate([0,0,-1])cylinder(d=7,h=d+2);
    }
  }
  
  // Where stem should attach
  translate([0,-39.62,0]){
    difference(){
      cube([d,30,d],center=true);
//      translate([-(d/2+0.1),7,0])rotate([0,90,0])cylinder(h=d/3,d1=5,d2=0);
//      translate([(d/2+0.1),7,0])rotate([0,-90,0])cylinder(h=d/3,d1=5,d2=0);
      translate([-d,7,])rotate([0,90,0])cylinder(d=3.5,h=d*2);
    }
  }
  
  // the curve
  translate([-d/2,0,-1.84])
  rotate([-10,0,0])
  rotate([0,90,0])
  curve(50, 5)
  square(size=[d,d]);
  
  // cap part
  translate([0,29,-8.68]){
    cube([d,10,d],center=true);
    translate([0,0,4])cube([d,3,d],center=true);
    translate([-1,0,4])cube([3,10,d],center=true);
  }
}

module all(){
  d=5;
//  arm(d);
//  translate([0,-32.5,0])stem(d);
  translate([0,29,0])cap(d+1); 
}

all();
//cap();