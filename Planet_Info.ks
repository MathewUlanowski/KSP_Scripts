function Info{
    List Engines in myVariables.
    until false {
        CLEARSCREEN.
        print(SUN:distance).
        for planet in SUN:orbitingchildren{
            print(planet:name+"    "+Round(planet:rotationangle, 2)).
            for Sbodies in planet:orbitingchildren{
                print("->     "+Sbodies:name).
            }
            // else {

            // }
        }
        WAIT 0.5.
    }
}
info().