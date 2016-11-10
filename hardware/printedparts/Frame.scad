// Connectors

Frame_Con_Def = [[0,0,0], [0,0,-1], 0,0,0];


module Frame_STL() {

    printedPart("printedparts/Frame.scad", "Frame", "Frame_STL()") {

        view(t=[0,0,0],r=[72,0,130],d=400);

        if (DebugCoordinateFrames) frame();
        if (DebugConnectors) {
            connector(Frame_Con_Def);
        }

        color(Level3PlasticColor) {
            if (UseSTL) {
                import(str(STLPath, "Frame.stl"));
            } else {
                Frame_Model();
            }
        }
    }
}


module Frame_Model()
{
    l = ArmLength;
    aid = DCMotor_RearCan_OD(DCMotor_CL072014) + 0.5;  // dia of motors, inc tolerance
    aod = aid + 2 * 2.5; // outer dia of motor holders
    ll = 15;  // leg length
    w = 25;  // width of central plate

    difference() {
        union() {

            // arms
            for (i=[0:3])
                rotate([0,0,45 + i*90]) {
                    // Nice rounded end
                    hull() {
                        translate([l, 0, -tw])
                            cylinder(r=aod/2, h=tw);

                        translate([l-aod, -tw/2, -tw])
                            cube([1, tw, tw]);
                    }

                    // Rest of the arm
                    translate([0, -tw/2, -tw])
                        cube([l, tw, tw]);

                    // basic landing leg
                    translate([l-aod, -tw/2, -ll])
                        cube([tw, tw, ll]);
                }

            // central plate for fixing battery and flight controller to
            translate([-w/2, -w/2, -tw])
                cube([w, w, tw]);
        }

        // holes for motors
        for (i=[0:3])
            rotate([0,0,45 + i*90])
            translate([l, 0, 0])
                cylinder(r=aid/2, h=100, center=true);


    }
}
