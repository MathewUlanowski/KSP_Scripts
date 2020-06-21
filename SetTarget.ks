DECLARE PARAMETER ParTarg.

set TARGET to ParTarg.
until false {
    CLEARSCREEN.
    print(TARGET:name).
    // print(round(Target:obt:periapsis,2)).
    // print(round(target:obt:apoapsis,2)).
    // print(round(target:altitude,2)).
    // print(round(target:distance/1000,2)+"km").
    // print(round(target:obt:inclination,3)).
    if ship:ORBIT:hasNextPatch {
        print(ship:nextpatch).
    }
    if HASNODE {
        print(Nextnode:burnvector:mag).
    }
    wait 0.5.
}