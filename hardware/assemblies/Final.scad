
module FinalAssembly () {

    assembly("assemblies/Final.scad", "Final Assembly", str("FinalAssembly()")) {

        // base part
        Frame_STL();

        // steps
        step(1, "Insert the motors") {
            view(t=[0,0,0], r=[52,0,218], d=400);

            for (i=[0:3])
                rotate([0,0, 45 + i*90])
                translate([ArmLength,0,0])
                attach(DefConUp, DCMotor_Con_Face)
                DCMotor(DCMotor_CL072014);
        }



    }
}
