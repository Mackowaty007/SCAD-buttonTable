$fn = 25;//detail level

panelWidth = 140;//mm
panelHeight = 110;//mm
panelThicknes = 3;//mm
screwDiameter = 2;
roundEdgesRadious = 5;//set to zero to disable

border = 10;
gridSizeX = 30;
gridSizeY = 30;

textSize = 5;
labelsEnabled = true;

numberOfGridsInARowX = 3;
numberOfGridsInARowY = 4;
/*id list: 
0 - nothing
1 - a switch
2 - a double switch
3 - a joystick
7 - 7 segment display
47- 4x 7 segment display (requires a empty space on the right
69- debug cube grid size
*/
map = [
[ 1, 2, 2, 2],
[ 7, 7, 3, 3],
[47, 0, 1, 1]
];
labelMap = [
["battery","engine","gear","other"],
["wpn","othr","cam","soi"],
["speed"," ","test","test"]
];

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
module doubleSwitch(){
    translate([-20/2,-13-1,-18]) cube([20,13,25]);
    translate([-20/2,1,-18]) cube([20,13,25]);
}
module joystick(){
    translate([0,0,2]) cylinder(10,25/2,25/2,center=true);
}
module bigButton(){}
module SSD(){//seven segment display
    cube([17.5,12.4,20],center=true);
}
module X4SSD(){//seven segment display
    translate([-19/2,-50.4/2+gridSizeY/2,-12]) cube([19,50.4,20]);
}
module LCD2inch(){}
module LCD1c3inch(){}
module aGrid(){
    translate([-gridSizeX/2,-gridSizeY/2,-1]) cube([gridSizeX,gridSizeY,10]);
}

difference(){
    color("green")
    cube([panelHeight,panelWidth,panelThicknes]);
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
    echo ("works");
    for(x=[0:1:numberOfGridsInARowX-1]){
        for(y = [0:1:numberOfGridsInARowY-1]){
            if(map[x][y]==0){}
            
            if(map[x][y]==1){
                #translate([
                border+x*(gridSizeX+((panelHeight-border*2)-(numberOfGridsInARowX*gridSizeX))/(numberOfGridsInARowX-1))+gridSizeX/2,
                border+y*(gridSizeY+((panelWidth -border*2)-(numberOfGridsInARowY*gridSizeY))/(numberOfGridsInARowY-1))+gridSizeY/2,
                0]) switch();
            }
            
            if(map[x][y]==2){
                #translate([
                border+x*(gridSizeX+((panelHeight-border*2)-(numberOfGridsInARowX*gridSizeX))/(numberOfGridsInARowX-1))+gridSizeX/2,
                border+y*(gridSizeY+((panelWidth -border*2)-(numberOfGridsInARowY*gridSizeY))/(numberOfGridsInARowY-1))+gridSizeY/2,
                0]) doubleSwitch();
            }
            
            if(map[x][y]==3){
                #translate([
                border+x*(gridSizeX+((panelHeight-border*2)-(numberOfGridsInARowX*gridSizeX))/(numberOfGridsInARowX-1))+gridSizeX/2,
                border+y*(gridSizeY+((panelWidth -border*2)-(numberOfGridsInARowY*gridSizeY))/(numberOfGridsInARowY-1))+gridSizeY/2,
                0]) joystick();
            }
            
            if(map[x][y]==7){
                #translate([
                border+x*(gridSizeX+((panelHeight-border*2)-(numberOfGridsInARowX*gridSizeX))/(numberOfGridsInARowX-1))+gridSizeX/2,
                border+y*(gridSizeY+((panelWidth -border*2)-(numberOfGridsInARowY*gridSizeY))/(numberOfGridsInARowY-1))+gridSizeY/2,
                0]) SSD();
            }
            
            if(map[x][y]==47){
                #translate([
                border+x*(gridSizeX+((panelHeight-border*2)-(numberOfGridsInARowX*gridSizeX))/(numberOfGridsInARowX-1))+gridSizeX/2,
                border+y*(gridSizeY+((panelWidth -border*2)-(numberOfGridsInARowY*gridSizeY))/(numberOfGridsInARowY-1))+gridSizeY/2,
                0]) X4SSD();
            }
            
            if(map[x][y]==69){//debugTile
                #translate([
                border+x*(gridSizeX+((panelHeight-border*2)-(numberOfGridsInARowX*gridSizeX))/(numberOfGridsInARowX-1))+gridSizeX/2,
                border+y*(gridSizeY+((panelWidth -border*2)-(numberOfGridsInARowY*gridSizeY))/(numberOfGridsInARowY-1))+gridSizeY/2,
                0]) aGrid();
            }
        }
    }
}

//labels
if(labelsEnabled==true){
    for(x=[0:1:numberOfGridsInARowX-1]){
         for(y = [0:1:numberOfGridsInARowY-1]){
             if(map[x][y]!=0){
                translate([
                    border+x*(gridSizeX+((panelHeight-border*2)-(numberOfGridsInARowX*gridSizeX))/(numberOfGridsInARowX-1))+gridSizeX/2-gridSizeX*(44/100),
                    border+y*(gridSizeY+((panelWidth -border*2)-(numberOfGridsInARowY*gridSizeY))/(numberOfGridsInARowY-1))+gridSizeY/2,
                    panelThicknes/2])
               rotate([0,0,90])
               linear_extrude(panelThicknes)
               text(text = labelMap[x][y], size = textSize,halign="center",valign="bottom");
             }
        }
    }
}
