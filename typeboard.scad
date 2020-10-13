
$fn= 400;
$stem_throw = 4;
extra_vertical=0;
space=19.04;
cherryCutOutSize=13.9954;
cherrySize=14.58;
mountHole=6;

stemPlacement=-8;

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


module mxSwitchCut(x=0,y=0,z=0,rotateCap=false){
  capRotation = rotateCap ? 90 : 0;
  d=14.05;
  p=14.58/2+0.3;
  translate([x,y,z]){
    translate([0,0,-3.7])
    rotate([0,0,capRotation]){
      difference(){
        cube([d,d,10], center=true);
        translate([d*0.5,0,0])cube([1,4,12],center=true);
        translate([-d*0.5,0,0])cube([1,4,12],center=true);
      }


      translate([0,-(p-0.6),1.8]) rotate([-10,0,0]) cube([cherryCutOutSize/2,1,1.6],center=true);
      translate([0,-(p-0.469),-1.95]) cube([cherryCutOutSize/2,1,6.099],center=true);

      translate([0,(p-0.6),1.8]) rotate([10,0,0]) cube([cherryCutOutSize/2,1,1.6],center=true);
      translate([0,(p-0.469),-1.95]) cube([cherryCutOutSize/2,1,6.099],center=true);
    }
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
    translate([0,0,-6]){
      scale([1.02,1.02,1])tMount(d);
    }
  }
//  import("switch_mx.stl");
}

module stem(d=5,h=20){
//  translate([-d,0,0])rotate([0,90,0])cylinder(d=3,h=d*2);
  e=d+4;
  f=d+0.9;
  cube([e,f,h],center=true);
  translate([-e/2,0,h/2])rotate([0,90,0])cylinder(d=f,h=e);
  difference(){
    union(){
      translate([(e-2)/2,0,h/2])cube([2,f,24],center=true);
      translate([-(e-2)/2,0,h/2])cube([2,f,24],center=true);
    }
    translate([-d,0,h/2+8])rotate([0,90,0])translate([0,0,-d])cylinder(d=3.5,d*4);
  }
  
  a = h/10*5;
  
  translate([0,0,-(a+5)])box_cherry_stem(6,0.1);
  

  translate([0,0,-a+1.4])color([0.7,0.8,0.6])import("switch_mx.stl");
}

module thinStem(d=5){
  e=d-1;
  f=d+0.9;
  cube([e,f,20],center=true);
  translate([-e/2,0,10])rotate([0,90,0])cylinder(d=f,h=e);
  difference(){
    union(){
      translate([d/2,0,10])cube([2,f,24],center=true);
      translate([-d/2,0,10])cube([2,f,24],center=true);
    }
    translate([-d,0,18])rotate([0,90,0])cylinder(d=3.5,d*2);
  }
  
  
  
  translate([0,0,-15])box_cherry_stem(6,0.1);
  
  
  translate([0,0,-8.6])color([0.7,0.8,0.6])import("switch_mx.stl");
}

module stem2(d=4){
//  translate([0,0,-8])cube([d,d,1],center=true);
  
  f=d+1;
  difference(){
    union(){
//      translate([d/2,0,10])cube([2,f,10],center=true);
//      translate([-d/2,0,10])cube([2,f,10],center=true);
    }
//    translate([-d,0,10])rotate([0,90,0])translate([0,0,-d])cylinder(d=3.5,h=d*4);
  }

  difference(){
    union(){
      translate([0,0,-9]){
        linear_extrude(height = 10) {
          offset(r=1){
            square(outer_box_cherry_stem(0.1) - [2,2], center=true);
          }
        }
      }
    }
    translate([-d,0,-2])rotate([0,90,0])translate([0,0,-d])cylinder(d=3.5,h=d*4);
    translate([0,0,-2])cube([d,d*3,10],center=true);
  }
  
  translate([0,0,-15])box_cherry_stem(6,0.1);
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

module arm(d=5){
  // back
  translate([-d/2,-60,0])rotate([0,90,0]){
    difference(){
      cylinder(d=12,h=d);
      translate([0,0,-1])cylinder(d=mountHole,h=d+2);
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
    tMount(d);
  }
}

module arm2(d=4){
  // back
  translate([-d/2,-60,0])rotate([0,90,0]){
    difference(){
      cylinder(d=12,h=d);
      translate([0,0,-1])cylinder(d=mountHole,h=d+2);
    }
  }
  // Where stem should attach
  translate([0,-40,0]){
    cube([d,30,d],center=true);
    translate([0,stemPlacement*-1,0]){
      difference(){
        
        translate([0,0,-11])union(){
          k=18;
          cube([d,d*1.5,k],center=true);
          translate([-d/2,0,-k/2])rotate([0,90,0])cylinder(d=d*1.5,h=d);
        }
        
        translate([-d,0,-20])rotate([0,90,0])cylinder(d=3.5,h=d*2);
      }
    }
//    difference(){
//      cube([d,30,d],center=true);
//      translate([-d,stemPlacement*-1,0])rotate([0,90,0])cylinder(d=3.5,h=d*2);
//    }
  }
  
  // the curve
  translate([-d/2,-0.37,-2.35])
  rotate([-10,0,0])
  rotate([0,90,0])
  curve(50, 8)
  square(size=[d,d]);
  
  // cap part
  translate([0,29,-8.68]){
    cube([d,10,d],center=true);
    translate([0.5,0,3])tMount(z=5);
  }
}
module armR1(d=4){
  translate([-d/2,0,-1.84])
  rotate([-10,0,0])
  rotate([0,90,0])
  curve(50, 4)
  square(size=[d,d]);

}
module armR2(d=4){
  translate([-d/2,0,-1.84])
  rotate([-10,0,0])
  rotate([0,90,0])
  curve(50,8)
  square(size=[d,d]);
}
module armR3(d=4){
  translate([-d/2,0,-1.84])
  rotate([-10,0,0])
  rotate([0,90,0])
  curve(50,12)
  square(size=[d,d]);
}


module all(){
  d=4;
//  rotate(-4, [1,0,0])
//  translate([0,-60,0])
  arm2(d);
  translate([0,(stemPlacement+40)*-1,-18]){
//    stem(d);
//    thinStem(d);
    stem2(d);
  }
  translate([0,29,-3])cap(d,false);
 
//  translate([0,-32.5,0])mount(d); 
}



module r1(d=4){
  armR1(d);
  translate([0,(stemPlacement+40)*-1,-18])stem(d,h=20);
  translate([0,29,-3])cap(d,false);
}


module r2(d=4){
  armR2(d);
  translate([0,(stemPlacement+40)*-1,-18])stem(d,h=20);
  translate([0,29,-3])cap(d,false);
}


module r3(d=4){
  armR3(d);
  translate([0,(stemPlacement+40)*-1,-18])stem(d,h=20);
  translate([0,29,-3])cap(d,false);
}


translate([-space*3,0,0])all();

translate([-space*4,0,0])stem(4,10);
translate([-space*5,0,0])stem(4,20);
translate([-space*6,0,0])stem(4,100);

for(i=[0:5]){
  color([1,0,1])translate([space*i,0,0])r3();
  color([1,1,0])translate([space*i+space*0.5,-space*1,space*0.5])r2();
  color([0,1,1])translate([space*i+space*0.75,-space*2,space*1])r1();
}

