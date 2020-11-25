include <basics.scad>
//include <old.scad>

row=1; // [1,2,3,4]
part="all"; //["all","arm","stem"]
cap=false;

showAllRows=false;
$fn= 400;
$stem_throw = 4;
extra_vertical=0;
space=19.04;
cherryCutOutSize=13.9954;
cherrySize=14.58;
mountHole=6;

stemPlacement=-8;

module oth(){
  d=4;
  
  as=20;
  
  cap(d,false);
  translate([0,0,-as/2])cube([d,d,as],center=true);
  
  translate([-d/2,-80/2,-as+10])
  rotate([-10,0,0])
  rotate([0,90,0])
  curve(80,16)
  square(size=[d,d]);
  
  
//  translate([0,-50-30/2,-as+10])
//  rotate([-30,0,0])
//  cube([d,30,d],center=true);
  
  
  translate([0,-50-5,-37])stem(d,h=10);
  
  translate([-d/2,-50-30-d,-as+10+d*2])
  rotate([0,90,0]){
    difference(){
      cylinder(d=12,h=d);
      translate([0,0,-1])cylinder(d=mountHole,h=d+2);
    }
    #translate([0,0,-1])cylinder(d=mountHole,h=60);
  }
}

module overOth(){
  d=4;
  as=20;
  
  cap(d,false);
  translate([0,0,-as/2])cube([d,d,as],center=true);
  
  translate([-d/2,-40/2,-as+7])
  rotate([-10,0,0])
  rotate([0,90,0])
  curve(40,8)
  square(size=[d,d]);
  
  translate([-d/2,-60.02,-as+16])
  rotate([-17,0,0])
  rotate([0,90,0])
  curve(44,-7)
  square(size=[d,d]);
  
  translate([0,-50-5,-30])stem(d,h=40);
  
  translate([-d/2,-50-30-d,-as+10+d*2])
  rotate([0,90,0]){
    difference(){
      cylinder(d=12,h=d);
      translate([0,0,-1])cylinder(d=mountHole,h=d+2);
    }
    #translate([0,0,-1])cylinder(d=mountHole,h=60);
  }
}

module fas(row=1,part="all"){
  d = 4.5;
  as=20;
  
  if(cap){
    cap(d,false);
//    cap(d,true);
  }
  if(part == "all" || part == "arm"){
    translate([0.25,0,0])tMount(d);
  }
//  translate([0,0,-as/2])cube([d,d,as],center=true);
  
  
  if(row==1){
    s = 19.5;
    m = -18;
    difference(){
      union(){
        if(part == "all" || part == "arm"){
          translate([0,0,-as/2-1.4])cube([d,d,as-1],center=true);
          
          translate([-d/2,-6,-20.7])
            rotate([18,0,0])
            rotate([0,90,0])
            curve(8,2)
            square(size=[d,d]);
          
          
          translate([-d/2,-space*2.9,-10])
            rotate([-15,0,0])
            rotate([0,90,0])
            curve(space*5,-8)
            square(size=[d,d]);
        }        
        
        if(part == "all" || part == "stem"){
          translate([0,-space*4,m])dstem(d,s);
        }
      }
      translate([0,-space*4,m])dstemHole(d,s);
    }
  } else if(row == 2){
    s = 3.3;
    m = -35.8;
    difference(){
      union(){
        if(part == "all" || part == "arm"){
          translate([0,0,-as/2-1])cube([d,d,as-1],center=true);
        
          translate([-d/2,-space*2.5,-as+11])
            rotate([-10,0,0])
            rotate([0,90,0])
            curve(space*5,25)
            square(size=[d,d]);
        
          translate([-d/2,-space*5.122,1])
            rotate([-34,0,0])
            rotate([0,90,0])
            curve(8,-1.2)
            square(size=[d,d]);
        }
        if(part == "all" || part == "stem"){
          translate([0,-space*4,m])dstem(d,s);
        }
      }
      translate([0,-space*4,m])dstemHole(d,s);
    }
  } else if(row == 3){
    s=42;
    m=-26;
    echo("BROKEN!");
    difference(){
      union(){
        if(part == "all" || part == "arm"){
          translate([0,0,-as/2+0.5])cube([d,d,as-4.5],center=true);
          
          translate([-d/2,-space*1.22,-10.55])
            rotate([-7,0,0])
            rotate([0,90,0])
            curve(space*2.45,8)
            square(size=[d,d]);
          
          translate([-d/2,-space*3.9,-as+17])
            rotate([-10,0,0])
            rotate([0,90,0])
            curve(space*3,-8)
            square(size=[d,d]);
        }
        if(part == "all" || part == "stem"){
          translate([0,-space*4,m])dstem(d,s);
        }
      }
      translate([0,-space*4,m])dstemHole(d,s);
    }
  } else if(row == 4){
    s=9.5;
    m=-51.7;
    difference(){
      union(){
        if(part == "all" || part == "arm"){
          ps=7.45;
          translate([0,0,-ps/2-2])cube([d,d,ps],center=true);
          
          translate([0,-6.25,-7.2])
          cube([d,16.5,d],center=true);
          
          translate([-d/2,-space*1.22,-as+10])
            rotate([29,0,0])
            rotate([0,90,0])
            curve(space*1.1,-3)
            square(size=[d,d]);
          
          translate([-d/2,-space*3.31,-as+11])
            rotate([-11,0,0])
            scale([1,0.8,1])
            rotate([0,90,0])
            curve(space*4.1,30)
            square(size=[d*1.2,d]);
          
          translate([-d/2,-space*5.145,-1])
            rotate([-34,0,0])
            rotate([0,90,0])
            curve(10.5,-3)
            square(size=[d,d]);
        }

        if(part == "all" || part == "stem"){
          translate([0,-space*4,m])dstem(d,s);
        }
      }
      translate([0,-space*4,m])dstemHole(d,s);
    }
  }
  if(part == "all" || part == "arm"){
    translate([-d/2,-space*5.5,0])
    rotate([0,90,0]){
      difference(){
        cylinder(d=12,h=d);
        translate([0,0,-1])cylinder(d=mountHole,h=d+2);
      }
    #translate([0,0,-1])cylinder(d=mountHole,h=60);
   }
  
  }
}

module laf(row=1){
  d = 4;
  as=20;
  
  cap(d,false);
  
  if(row == 1){
    m=space;
    
    //TODO: Should make dshemHole be paleced at the same place as dstem
    translate([0,-space*3.19,2-m])dstem(d,m);
    
    translate([0,0,-d])
    cube([d,10,d],center=true);
    translate([0.5,0,0])tMount(d);
    
    translate([-d/2,-space*1.4-0.1,-0.3])
      rotate([-5,0,0])
      rotate([0,90,0])
      curve(space*2.7,14)
      square(size=[d,d]);
    
    difference(){
      translate([0,-space*3.6,0]){
        cube([d,space*1.7,d],center=true);
      }
      translate([0,-space*3.19,2-m])
        #translate([0,7.9,-7.4])dstemHole(d,0);
      
    }
  } else if (row == 2) {
    m=space*1.6;
    translate([0,-space*3.19,7-m])dstem(d,m);
    
    translate([0,-space*3.6,0])cube([d,space*1.7,d],center=true);
  }
  
  translate([-d/2,-space*4.65,0])
    rotate([0,90,0]){
      difference(){
        cylinder(d=12,h=d);
        translate([0,0,-1])cylinder(d=mountHole,h=d+2);
      }
    #translate([0,0,-1])cylinder(d=mountHole,h=60);
    }

}

//translate([space,-space*5,0])oth();
//translate([space*1.5,-space*6,space*0.5])oth();
//translate([space*1.75,-space*7,space])oth();
//translate([space*1.75,-space*7,space])overOth();

//translate([-space*3,0,0])all();
//
//translate([-space*4,0,0])stem(4,10);
//translate([-space*5,0,0])stem(4,20);
//translate([-space*6,0,0])stem(4,100);

//for(i=[0:5]){
//  color([1,0,1])translate([space*i,0,0])r3();
//  color([1,1,0])translate([space*i+space*0.5,-space*1,space*0.5])r2();
//  color([0,1,1])translate([space*i+space*0.75,-space*2,space*1])r1();
//}

//for(i=[0:5]){
//  color([1,0,1])translate([space*i,0,0])oth();
//  color([1,1,0])translate([space*i+space*0.5,-space*1,space*0.5])oth();
//  color([0,1,1])translate([space*i+space*0.75,-space*2,space*1])overOth();
//  color([0.8,0.4,1])translate([space*i+space*1,-space*3,space*1.5])overOth();
//}

//fas();
translate([-space*5,0,0]){
  laf();
  translate([-space*0.5,-space*1,space*0.5])laf(row=2);
  translate([-space*0.5-space*0.25,-space*2,space*1])laf(row=3);
  translate([-space*0.5-space*0.5,-space*3,space*1.5])laf(row=4);
  
  #translate([-space*2,-space*6,-space*1.788])cube([space*7,space*6,1]);
}
//translate([-space*4,-space*1.5,0])all();


if(showAllRows){
  for(i=[0:5]){
    color([1,0,1])translate([space*i,0,0]){
      fas();
      
      color([0.7,0.8,0.6])
      translate([0,-space*4,-space*1.4+0.2])
      import("switch_mx.stl");
    }
    color([1,1,0])translate([space*i+space*0.5,-space*1,space*0.5]){
      fas(2);
      
      color([0.7,0.8,0.6])
      translate([0,-space*4,-space*1.4+0.2])
      translate([0,0,-space*0.5])
      import("switch_mx.stl");
    }
    color([0,1,1])translate([space*i+space*0.75,-space*2,space*1]){
      fas(3);
      
      color([0.7,0.8,0.6])
      translate([0,-space*4,-space*1.4+0.2])
      translate([0,0,-space*1])
      import("switch_mx.stl");
    }
    color([0.8,0.4,1])translate([space*i+space*0.75+space*0.5,-space*3,space*1.5]){
      fas(4);
      
      color([0.7,0.8,0.6])
      translate([0,-space*4,-space*1.4+0.2])
      translate([0,0,-space*1.5])
      import("switch_mx.stl");
    }
  }
} else {
//  fas(row,part);
//  difference(){
//    cap(4,true);
//    translate([0,0,-1])tMount(4);
//  }
}
