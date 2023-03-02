panelWidth = 150;//mm
panelHeight = 100;//mm
screwDiameter = 2;
roundEdgesRadious = 5;//set to zero to disable

border = 10;
gridSize = 25;

numberOfGridsInARowX = 3;
numberOfGridsInARowY = 7;

module roundEdges(){
    translate([roundEdgesRadious,roundEdgesRadious,-1]){
        difference(){
            cylinder(50,roundEdgesRadious*2,roundEdgesRadious*2);
            cylinder(50,roundEdgesRadious,roundEdgesRadious);
            translate([-50,0,-10])  cube([100,100,100]);
            translate([0,-50,-10])  cube([100,100,100]);
        }
    }
}
module screwHole(){
    cylinder(25,screwDiameter,screwDiameter,center=true);
}
module switch(){
    translate([-20/2,-13/2,-18]) cube([20,13,25]);
}
module SSD(){//seven segment display
    
}
module aGrid(){
    translate([0,0,-1]) cube([gridSize,gridSize,gridSize]);
}

difference(){
    cube([panelHeight,panelWidth,5]);
    //round edges
    roundEdges();
    translate([0,panelWidth,0]) rotate([0,0,270]) roundEdges();
    translate([panelHeight,0,0]) rotate([0,0,90]) roundEdges();
    translate([panelHeight,panelWidth,0]) rotate([0,0,180]) roundEdges();
    //screw holes
    translate([border/2,border/2,0]) screwHole();
    translate([border/2,panelWidth-border/2,0]) screwHole();
    translate([panelHeight-border/2,border/2,0]) screwHole();
    translate([panelHeight-border/2,panelWidth-border/2,0]) screwHole();
    //all of the other holes
    for(x=[0:1:numberOfGridsInARowX-1]){
        for(y = [0:1:numberOfGridsInARowY-1]){
            #translate([
            border+x*(gridSize+((panelHeight-border*2)-(numberOfGridsInARowX*gridSize))/(numberOfGridsInARowX-1))+gridSize/2,
            border+y*(gridSize+((panelWidth -border*2)-(numberOfGridsInARowY*gridSize))/(numberOfGridsInARowY-1))+gridSize/2,
            0]) switch();
        }
    }
}
