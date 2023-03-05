$fn = 100;//detail level

panelWidth = 140;//mm
panelHeight = 110;//mm
wallThicknes = 1.2;//mm
height = 35;

screwDiameter = 3.2;
screwHeight = 15.5;
roundCornerRadious = 5;//set to zero to disable
border = 5;

/*
locations for the usb port
top
bottom
left
right
*/
usbLocation = "left";

module roundEdges(){
    translate([roundCornerRadious,roundCornerRadious,-height-1]){
        difference(){
            cylinder(height+2,roundCornerRadious*2,roundCornerRadious*2);
            cylinder(height+2,roundCornerRadious,roundCornerRadious);
            translate([-50,0,-10])  cube([100,100,100]);
            translate([0,-50,-10])  cube([100,100,100]);
        }
    }
}
module insideRoundEdges(){
    translate([border,border,-height+wallThicknes]){
        rotate([0,0,180]){
            difference(){
                cylinder(height-wallThicknes+0.01,roundCornerRadious*2,roundCornerRadious*2);
                cylinder(height+0.01,roundCornerRadious,roundCornerRadious);
                translate([-50,0,-10])  cube([100,100,100]);
                translate([0,-50,-10])  cube([100,100,100]);
            }
        }
    }
}
module screwHole(){
    translate([0,0,-screwHeight/2+0.01])
    cylinder(screwHeight,screwDiameter/2,screwDiameter/2,center=true);
}
module inside(){
    //make 2 intersecting holes in a way that doesn't cover up the screw holes
    translate([panelHeight/2,panelWidth/2,-height/2+wallThicknes])cube([panelHeight-wallThicknes*2,panelWidth-border*4,height],center=true);
    translate([panelHeight/2,panelWidth/2,-height/2+wallThicknes])cube([panelHeight-border*4,panelWidth-wallThicknes*2,height],center=true);
    //round up the edges where the screw holes are
    insideRoundEdges();
    translate([panelHeight,0,0])rotate([0,0,90])insideRoundEdges();
    translate([0,panelWidth,0])rotate([0,0,270])insideRoundEdges();
    translate([panelHeight,panelWidth,0])rotate([0,0,180])insideRoundEdges();
}
module usbPort(){
    translate([0,0,2.6/2])cube([25,7.4,2.6],center=true);
}

difference(){
    //main
    color("green")
    translate([0,0,-height])cube([panelHeight,panelWidth,height]);
    //the big hole in the middle where all of the parts go
    inside();
    //round edges
    roundEdges();
    translate([0,panelWidth,0]) rotate([0,0,270]) roundEdges();
    translate([panelHeight,0,0]) rotate([0,0,90]) roundEdges();
    translate([panelHeight,panelWidth,0]) rotate([0,0,180]) roundEdges();
    //screw holes
    translate([border,border,0]) screwHole();
    translate([border,panelWidth-border,0]) screwHole();
    translate([panelHeight-border,border,0]) screwHole();
    translate([panelHeight-border,panelWidth-border,0]) screwHole();
    //usb port hole
    if(usbLocation=="top"){
        translate([0,panelWidth/2,-height+wallThicknes+9.5])usbPort();
    }
    if(usbLocation=="bottom"){
        translate([panelHeight,panelWidth/2,-height+wallThicknes+9.5])usbPort();
    }
    if(usbLocation=="left"){
        translate([panelHeight/2,0,-height+wallThicknes+9.5])
        rotate([0,0,90])
        usbPort();
    }
    if(usbLocation=="right"){
        translate([panelHeight/2,panelWidth,-height+wallThicknes+9.5])
        rotate([0,0,90])
        usbPort();
    }
}