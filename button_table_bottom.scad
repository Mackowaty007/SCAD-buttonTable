$fn = 100;//detail level

panelWidth = 140;//mm
panelHeight = 110;//mm
wallThicknes = 1.2;//mm
panelThicknes = 3;//mm
height = 35;

//joystick support 
joystickSupport = true;
joystickScrewHeight = 15;
joystickScrewDiameter = 3.2;
howMuchShouldTheJoystickStandOut = 12.6;


screwHeight = 15.5;
roundCornerRadious = 5;//set to zero to disable


/*
locations for the usb port
top
bottom
left
right
*/
usbLocation = "left";

//copy this from the button_table.scad file
border = 5;
gridSizeX = 30;
gridSizeY = 30;
screwDiameter = 3.2;
numberOfGridsInARowX = 3;
numberOfGridsInARowY = 4;
map = [
[ 1, 2, 2, 2],
[47, 0, 3, 3],
[ 7, 5, 6, 4]
];


    module joystickScrewHole(){
        translate([0,0,-joystickScrewHeight/2])
        #cylinder(joystickScrewHeight,joystickScrewDiameter/2,joystickScrewDiameter/2,center=true);
    }
    module joystickStand(){
        baseWidth = 26.1;
        baseHeight= 34.1;
        rotate([0,0,270])
        translate([-baseWidth/2,-baseHeight/2,-(height+panelThicknes-(32.5-howMuchShouldTheJoystickStandOut)-wallThicknes)])
        difference(){
        translate([0,0,-(height+panelThicknes-(32.5-howMuchShouldTheJoystickStandOut)-wallThicknes)])
        cube([baseWidth,baseHeight,height+panelThicknes-(32.5-howMuchShouldTheJoystickStandOut)-wallThicknes]);
        
        //screw holes
        translate([2+joystickScrewDiameter/2,1+joystickScrewDiameter/2,0.01])
        joystickScrewHole();
        translate([2+joystickScrewDiameter/2,baseHeight-3.7-joystickScrewDiameter/2,0.01])
        joystickScrewHole();
        translate([baseWidth-2-joystickScrewDiameter/2,1+joystickScrewDiameter/2,0.01])
        joystickScrewHole();
        translate([baseWidth-2-joystickScrewDiameter/2,baseHeight-3.7-joystickScrewDiameter/2,0.01])
        joystickScrewHole();
        }
}

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

if(joystickSupport==true){
    for(x=[0:1:numberOfGridsInARowX-1]){
        for(y = [0:1:numberOfGridsInARowY-1]){
            if(map[x][y]==0){}
                
            translate([
                border+x*(gridSizeX+((panelHeight-border*2)-(numberOfGridsInARowX*gridSizeX))/(numberOfGridsInARowX-1))+gridSizeX/2,
                border+y*(gridSizeY+((panelWidth -border*2)-(numberOfGridsInARowY*gridSizeY))/(numberOfGridsInARowY-1))+gridSizeY/2,
                0]){

               if(map[x][y]==3){//joystick
                    joystickStand();
               }
            }
        }
    }
}


