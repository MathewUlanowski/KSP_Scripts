stage.
CLEARSCREEN.
when STATUS = "FLYING" then{
    WAIT 0.5.
    set KUNIVERSE:timewarp:warp to 4.
}

until Alt:apoapsis > 60000 {
    LOCK STEERING TO HEADING(90, 90, -90).
    LOCK THROTTLE TO 1.
}

UNLOCK STEERING.
UNLOCK THROTTLE.
SAS ON.
set THROTTLE to 0.

set KUNIVERSE:timewarp:warp to 0.

WAIT 10.

stage.
set KUNIVERSE:timewarp:warp to 4.
print("Mission Conditions have been met").
print("Engagin Autopioleted Landing").
toggle AG10.

RUNPATH("0:/landingautopiolot").