run import("0:/Libs/CommonTriggers").
run import("0:/Libs/GUImaker").

declare parameter OrbInput is 200.
DECLARE PARAMETER Class is 0.
set OrbInput to OrbInput*1000.
lock throttle to 0.
// locks the steering while below 1km or until airodynamic forces become significant to provide control

if Class = 0 {
    SET CurveOffset to 35000.
} else {
    if Class = 1 {
        SET CurveOffset to 40000.
    } else {
        SET CurveOffset to 45000.
    }
}

LFO_Trigger().
NewPopup("LFO staging enabled").

WHEN SHIP:altitude > 65000 THEN {
    TOGGLE AG10.
}

STAGE.

//  to orbit 
function Mode0 {
    Lock throttle to 1.
    Lock steering to up.
    until ship:apoapsis > OrbInput+100 {
        CLEARSCREEN.
        if ship:ALTITUDE > 300 {
            print("Above 300m").
            if ship:ALTITUDE < CurveOffset {
                Lock STEERING to up + R(0,(ship:altitude/CurveOffset)*-90, 0).
            }
            else {
                print("Above 35km").
                Lock STEERING to up + R(0,-90,0).
                if ship:apoapsis > OrbInput*0.9 {
                    Lock Throttle to 0.1.
                }
            }
        }
    }
    until ship:altitude > 70000 {
        if ship:APOAPSIS < OrbInput+100 {
            lock Throttle to 0.1.
        }
        else {
            Lock Throttle to 0.
        }
    }
    print("Mode0 Completed").
    lock Throttle to 0.
    UNLOCK THROTTLE.
}



// function that creates a circular node.
function CirNode{
    set BurnV to 0.
    Set NewNode to node(time:seconds + eta:apoapsis, 0,0, BurnV).
    add NewNode.
    until NewNode:obt:periapsis > OrbInput-100{
            if NewNode:obt:periapsis < OrbInput*0.9{
                set NewNode:prograde to NewNode:prograde + 1.
            }
            else {
                set NewNode:prograde to NewNode:prograde + 0.1.
            }
    }
    print("Node Created with a Delta V of "+NewNode:burnvector:Mag+"m/s").
}

// RUN ExecuteNode.ksm.

function Mode1{
    set completed to false.
    set WARP to 0.
    wait 3.
    WARPTO(Time:seconds+(NEXTNODE:eta-(NEXTNODE:burnvector:mag/(ship:AVAILABLETHRUST/ship:mass))/2)-30).
    until completed = true{
        SAS OFF.

        if NEXTNODE:burnvector:mag<30{
            lock Steering to prograde.
        }
        else {
            Lock steering to nextNode:burnvector.
        }
        clearScreen.
        print("mode1").
        print("Max Thrust: "+ round(ship:maxthrust)).
        print("Apoapsis: "+ round(ship:apoapsis)).
        print("Periapsis: "+ round(ship:periapsis)).
        print(nextNode:burnvector:mag).
        if nextNode:eta < (nextNode:burnvector:mag / (ship:AVAILABLETHRUST/ship:mass))/2  {
            if ship:apoapsis > OrbInput and ship:periapsis > OrbInput{
                set completed to true.
                LOCK throttle to 0.
            }
            else {
                if nextNode:burnvector:mag < 30{
                    LOCK throttle to NEXTNODE:burnvector:mag/30.
                }
                else{
                    LOCK throttle to 1.
                }
            }
        }

//         // clearScreen.
//         // set Burn_duration to nextNode:deltav:z / (ship:maxThrust/ship:mass).
//         // set NodeVel to nextNode:deltav:z.
//         // lock steering to nextNode:burnvector.
//         // print(Burn_duration).
//         // print("Apoapsis: "+ship:apoapsis).
//         // print("Periapsis: "+ship:periapsis).
//         // print("Altitude: "+ship:altitude).
//         // if nextNode:eta < Burn_duration / 2 {
//         //     if ship:periapsis >= OrbInput or ship:apoapsis >= OrbInput+2000 {
//         //         clearScreen.
//         //         print(Burn_duration).
//         //         print("Apoapsis: "+ship:apoapsis).
//         //         print("Periapsis: "+ship:periapsis).
//         //         print("Altitude: "+ship:altitude).
//         //         set Burn_duration to nextNode:deltav:z / (ship:maxThrust/ship:mass).
//         //         lock throttle to 1.
//         //     }
//         //     else {
//         //         set completed to true.
//         //         set throttle to 0.
//         //     }
//         // }
    }
    remove nextNode.
    UNLOCK THROTTLE.
    UNLOCK STEERING.
    SAS ON.
}


Mode0().
CirNode().
Mode1().
clearScreen.
// RUN Node_Execution.ks.





