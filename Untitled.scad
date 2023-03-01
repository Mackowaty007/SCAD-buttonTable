panelWidth = 200;//mm
panelHeight = 90;//mm
screwDiameter = 2;
roundEdgesRadious = 5;//set to zero to disable

border = 10;
gridSize = 25;


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
    translate([0,0,-18]) cube([20,13,25]);
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
    numberOfGridsInARowX = round(panelHeight/gridSize);
    numberOfGridsInARowY = round(panelWidth/gridSize);
    //hack (round up numbers down)
    if (numberOfGridsInARowX - panelHeight/gridSize > 1){
        numberOfGridsInARowX = numberOfGridsInARowX - 1;
    }
    if (numberOfGridsInARowY - panelWidth/gridSize > 1){
        numberOfGridsInARowY = numberOfGridsInARowY - 1;
    }
    //debug
    echo (numberOfGridsInARowX);
    //                ||          complicated shit                                                          ||
    for(x = [border : /*((panelHeight-border*2)-numberOfGridsInARowX*gridSize)/numberOfGridsInARowX */gridSize  : panelHeight-border]){
        for(y = [border : ((panelWidth-border*2)-numberOfGridsInARowY*gridSize)/numberOfGridsInARowY + gridSize : panelWidth-border]){
            #translate([x,y,0]) aGrid();
        }
    }
}
