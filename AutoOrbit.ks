run import("0:/Libs/CommonTriggers").
run import("0:/Libs/GUImaker").

declare parameter OrbInput is 200.
DECLARE PARAMETER inclinationParam is 90.
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
SAS off.
LFO_Trigger().
NewPopup("LFO staging enabled","OK").

WHEN SHIP:altitude > 65000 THEN {
    PANELS ON.
}

WHEN SHIP:altitude > 300 THEN {
    SET KUNIVERSE:timewarp:warp TO 4.
}

STAGE.

//  to orbit 
function Mode0 {
    Lock throttle to 1.
    Lock steering to HEADING(inclinationParam,90,0-inclinationParam).
    until ship:apoapsis > OrbInput+100 or (SHIP:ALTITUDE > 70000 and ship:apoapsis > OrbInput) {
        if ship:ALTITUDE > 300 {
            if ship:ALTITUDE < CurveOffset {
                Lock STEERING to HEADING(inclinationParam,((ship:altitude/CurveOffset)*-90)+90, 0-inclinationParam).
            }
            else {
                Lock STEERING to heading(inclinationParam,0,0-inclinationParam).
                if ship:apoapsis > OrbInput*0.9 {
                    Lock Throttle to ((OrbInput+100)-ship:apoapsis)/(OrbInput*0.1).
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
    print("Mode1").
    RUNPATH("0:/ExecuteNode",True,{
        if ship:APOAPSIS > OrbInput and SHIP:PERIAPSIS > OrbInput {
            RETURN TRUE.
        } else {
            Return False.
        }
    }).
    // set completed to false.
    // set WARP to 0.
    // wait 3.
    // WARPTO(Time:seconds+(NEXTNODE:eta-(NEXTNODE:burnvector:mag/(ship:AVAILABLETHRUST/ship:mass))/2)-30).
    // until completed = true{
    //     SAS OFF.

    //     if NEXTNODE:burnvector:mag<30{
    //         lock Steering to prograde.
    //     }
    //     else {
    //         Lock steering to nextNode:burnvector.
    //     }
    //     if nextNode:eta < (nextNode:burnvector:mag / (ship:AVAILABLETHRUST/ship:mass))/2  {
    //         if ship:apoapsis > OrbInput and ship:periapsis > OrbInput{
    //             set completed to true.
    //             LOCK throttle to 0.
    //         }
    //         else {
    //             if nextNode:burnvector:mag < 30{
    //                 LOCK throttle to NEXTNODE:burnvector:mag/30.
    //             }
    //             else{
    //                 LOCK throttle to 1.
    //             }
    //         }
    //     }
    // }
    // remove nextNode.
    // UNLOCK THROTTLE.
    // UNLOCK STEERING.
    // SAS ON.
}


Mode0().
set warp to 0.
WAIT 2.
CirNode().
Mode1().

UNLOCK THROTTLE.
UNLOCK STEERING.

set ship:control:pilotmainthrottle to 0.
SAS ON.
set NAVMODE to "ORBIT".
SET SASMODE TO "PROGRADE".
// RUN Node_Execution.ks.





