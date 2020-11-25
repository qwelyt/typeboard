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
  

//  translate([0,0,-a+1.4])color([0.7,0.8,0.6])import("switch_mx.stl");
}


module tstem(d=4,h=20){
  a = h/10*5;
  b = d+1.9;
  c = d-0.1;
  
  translate([0,0,10])difference(){
    cube([d*1.3,d*1,10],center=true);
    cube([d,d*2,12],center=true);
    translate([0,0,3])rotate([0,90,0])translate([0,0,-d*2])cylinder(d=3.5,d*4);
  }
  
  translate([-d/2,0,h/2-d/2])rotate([0,90,0])cylinder(d=d,h=d);
  translate([0,0,-h/2+8])cube([d,d,h],center=true);
  
  translate([0,0,-(a+5)])box_cherry_stem(6,0.1);
  
//  translate([0,0,-a+1.4])color([0.7,0.8,0.6])import("switch_mx.stl");
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
