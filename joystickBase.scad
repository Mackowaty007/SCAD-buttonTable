$fn = 100;
wallThicknes = 1.2;//mm
panelThicknes = 3;//mm
height = 35;

joystickScrewHeight = 15;
joystickScrewDiameter = 3.2;
howMuchShouldTheJoystickStandOut = 12.6;

module joystickScrewHole(){
    translate([0,0,-joystickScrewHeight/2])
    #cylinder(joystickScrewHeight,joystickScrewDiameter/2,joystickScrewDiameter/2,center=true);
}

difference(){
    baseWidth = 26.1;
    baseHeight= 34.1;
    
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