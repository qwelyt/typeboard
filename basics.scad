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

module roundedCube(depth, slop, remover=[2,2]){
  linear_extrude(height = depth) {
      offset(r=1){
        square(outer_box_cherry_stem(slop) - remover, center=true);
      }
    }
}

module box_cherry_stem(depth, slop) {
  difference(){
    // outside shape
    roundedCube(depth,slop);

    // inside cross
    inside_cherry_cross(slop);
  }
}

module switch(x=0,y=0,z=0){
  translate([x,y,z])import("switch_mx.stl");
}

module curve(length, dh) {
  if(dh == 0){
    rotate([90,0,0])
    linear_extrude(length,center=true)
    children();
  } else {
    r = (pow(length/2, 2) + pow(dh, 2))/(2*dh);
    a = 2*asin((length/2)/r);
    
    translate([-(r -dh), 0, 0])
    rotate([0, 0, -a/2])
    rotate_extrude(angle = a)
    translate([r, 0, 0])
    children();
  }
}

module tMount(z=10,x1=1.5,y1=3,x2=2.5,y2=10){
  translate([x1/2,0,0])cube([x1,y1,z],center=true);
  translate([-x2/2,0,0])cube([x2,y2,z],center=true);
}

module cap(d=5,real=true){

  difference(){
    if(real){
      minkowski(){
        cube([10,10,3],center=true);
        sphere(d=10/4);
      }
    } else {
//      translate([15,0,0])
      cube([14,14,5],center=true);
    }
    
    if(real){
      translate([0,0,5])scale([0.9,0.9,0.35])sphere(d=19);
    }
    translate([0.5,0,-1]){
      scale([1.02,1.02,1])tMount(d);
    }
  }
//  import("switch_mx.stl");
}

module dstemHole(d,h){
  translate([-d,0,h/2+8])rotate([0,90,0])translate([0,0,-d])cylinder(d=3.5,d*4);
}

module dstem(d=5,h=20){
  e=d+3;
  f=d+0.9;
  
    
  cube([d,f,h],center=true);
  translate([-d/2,0,h/2])rotate([0,90,0])cylinder(d=f,h=d);
  difference(){
    translate([0,0,h/2+3])union(){
      translate([(e-2)/2,0,0])cube([1,f,15],center=true);
      translate([-(e-2)/2,0,0])cube([1,f,15],center=true);
      
      translate([(e-2)/2-0.8,-f/2,-8.25])
      rotate([0,90,90])
      cylinder(d=3,h=f,$fn=3);
      
      translate([-(e-2)/2+0.8,-f/2,-8.25])
      rotate([0,90,90])
      cylinder(d=3,h=f,$fn=3);
    }
//    translate([-d,0,h/2+8])rotate([0,90,0])translate([0,0,-d])cylinder(d=3.5,d*4);
    dstemHole(d,h);
  }
  
  a = h/10*5;
  
  translate([0,0,-(a+5)])box_cherry_stem(6,0.1);
  

//  translate([0,0,-a+1.4])color([0.7,0.8,0.6])import("switch_mx.stl");
}

module mount(d=5){
  translate([0,0,-40]){
    difference(){
      translate([0,-space/4,-4])cube([space,space*1.5, 9],center=true);
      mxSwitchCut();
    }
  }
  
  e=d+4;
  f=d+0.9;
  translate([0,-27.5,-18.5]){
    difference(){
      cube([space,space,60],center=true);
      translate([0,0,10])cube([d+2,space+2,41],center=true);
      translate([-space,0,18.5])rotate([0,90,0])cylinder(d=mountHole,h=space*2);
    }
  }
}
