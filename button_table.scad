$fn = 100;//detail level

panelWidth = 140;//mm
panelHeight = 110;//mm
panelThicknes = 3;//mm
screwDiameter = 3.2;
roundCornerRadious = 5;//set to zero to disable

border = 5;
gridSizeX = 30;
gridSizeY = 30;

textSize = 5;
labelsEnabled = true;
isLabelPositive = false;

numberOfGridsInARowX = 3;
numberOfGridsInARowY = 4;

/*id list: 
0 - nothing
1 - a switch
2 - a double switch
3 - a joystick
4 - a potentiometer
5 - small buttons in a group
6 - LED
26- double LED
36- tripple LED
46- quadruple LED
56- qintiple? LED
66- hex LED
86- octo LED?
7 - 7 segment display
47- 4x 7 segment display (requires a empty space on the right
69- debug cube grid size
*/
map = [
[ 1, 2, 2, 2],
[47, 0, 3, 3],
[ 7, 5, 6, 4]
];
labelMap = [
["battery","engines","gear","other"],
["speed"," ","cam","soi"],
["sel","autopilot","LED","power"]
];

module roundEdges(){
    translate([roundCornerRadious,roundCornerRadious,-1]){
        difference(){
            cylinder(50,roundCornerRadious*2,roundCornerRadious*2);
            cylinder(50,roundCornerRadious,roundCornerRadious);
            translate([-50,0,-10])  cube([100,100,100]);
            translate([0,-50,-10])  cube([100,100,100]);
        }
    }
}
module screwHole(){
    cylinder(25,screwDiameter/2,screwDiameter/2,center=true);
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
module potentiometer(){
    cylinder(10,6/2,6/2,center=true);
}
module bigButton(){}
module smallButtons(){
    distanceBetweenButtons = 8;
    for(x=[-distanceBetweenButtons:distanceBetweenButtons:distanceBetweenButtons]){
        for(y=[-distanceBetweenButtons:distanceBetweenButtons:distanceBetweenButtons]){
            translate([x,y,0])
            cube([6,6,10],center=true);
        }
    }
}

module LED(){
    cylinder(10,5/2,5/2,center=true);
}
module SSD(){//seven segment display
    cube([17.5,12.4,20],center=true);
}
module X4SSD(){//seven segment display
    translate([-19/2,-50.4/2+gridSizeY/2,-12]) cube([19,50.4,20]);
}
module LCD2inch(){}
module LCD1c3inch(){}
module aGrid(){//for debug purpouses
    translate([-gridSizeX/2,-gridSizeY/2,-1]) cube([gridSizeX,gridSizeY,10]);
}

module labels(){
    if(labelsEnabled==true){
        for(x=[0:1:numberOfGridsInARowX-1]){
             for(y = [0:1:numberOfGridsInARowY-1]){
                 if(map[x][y]==0){}
                 
                 translate([
                        border+x*(gridSizeX+((panelHeight-border*2)-(numberOfGridsInARowX*gridSizeX))/(numberOfGridsInARowX-1))+gridSizeX/2-gridSizeX/2,
                        border+y*(gridSizeY+((panelWidth -border*2)-(numberOfGridsInARowY*gridSizeY))/(numberOfGridsInARowY-1))+gridSizeY/2,
                        panelThicknes/2])
                 rotate([0,0,90]){
                     if(map[x][y]==1||map[x][y]==2){
                        translate([0,-1,0])
                        linear_extrude(panelThicknes)
                        text(text = labelMap[x][y], size = textSize,halign="center",valign="center");
                     }  
                     
                     if(map[x][y]==3){
                        translate([0,0,0])
                        linear_extrude(panelThicknes)
                        text(text = labelMap[x][y], size = textSize,halign="center",valign="center");
                     }
                     
                     if(map[x][y]==4){
                        translate([0,-8,0])
                        linear_extrude(panelThicknes)
                        text(text = labelMap[x][y], size = textSize,halign="center",valign="center");
                     }  
                     
                     if(map[x][y]==5){
                        translate([0,0,0])
                        linear_extrude(panelThicknes)
                        text(text = labelMap[x][y], size = textSize,halign="center",valign="center");
                     } 
                     
                     if(map[x][y]==6||map[x][y]==26||map[x][y]==36||map[x][y]==46){
                        translate([0,-8,0])
                        linear_extrude(panelThicknes)
                        text(text = labelMap[x][y], size = textSize,halign="center",valign="center");
                     } 
                     
                     if(map[x][y]==7){
                        translate([0,-2,0])
                        linear_extrude(panelThicknes)
                        text(text = labelMap[x][y], size = textSize,halign="center",valign="center");
                     }  
                     
                     if(map[x][y]==47){
                        translate([gridSizeX/2,-1,0])
                        linear_extrude(panelThicknes)
                        text(text = labelMap[x][y], size = textSize,halign="center",valign="center");
                     }  
                }
            }
        }
    }
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
    translate([border,border,0]) screwHole();
    translate([border,panelWidth-border,0]) screwHole();
    translate([panelHeight-border,border,0]) screwHole();
    translate([panelHeight-border,panelWidth-border,0]) screwHole();
    //all of the other holes
    echo ("works");
    for(x=[0:1:numberOfGridsInARowX-1]){
        for(y = [0:1:numberOfGridsInARowY-1]){
            if(map[x][y]==0){}
            
            translate([
                border+x*(gridSizeX+((panelHeight-border*2)-(numberOfGridsInARowX*gridSizeX))/(numberOfGridsInARowX-1))+gridSizeX/2,
                border+y*(gridSizeY+((panelWidth -border*2)-(numberOfGridsInARowY*gridSizeY))/(numberOfGridsInARowY-1))+gridSizeY/2,
                0]){
                if(map[x][y]==1){
                    switch();
                }
                
                if(map[x][y]==2){
                    doubleSwitch();
                }
                
                if(map[x][y]==3){//joystick
                    joystick();
                }
                
                if(map[x][y]==4){//potentiometer
                    potentiometer();
                }
                
                if(map[x][y]==5){//small buttons
                    smallButtons();
                }
                
                if(map[x][y]==6){//LED
                    LED();
                }
                
                if(map[x][y]==7){//seven segment
                    SSD();
                }
                
                if(map[x][y]==47){//4x seven segment
                    X4SSD();
                }
                
                if(map[x][y]==69){//debugTile
                    #aGrid();
                }
            }
        }
    }
    
    //make negative labels
    if (isLabelPositive==false){
        labels();
    }
}

//make labels
if (isLabelPositive==true){
    labels();
}
