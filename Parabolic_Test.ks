
declare parameter OrbInput.
stage.
set throttle to 0.
// locks the steering while below 1km or until airodynamic forces become significant to provide control
set MaxIndicator to 0.

//  to orbit 
function Mode0{
    until ship:apoapsis > OrbInput {
        if MaxIndicator = 0{
            set MaxIndicator to ship:maxthrust.
        }
        lock throttle to 1.
        print(round(maxThrust)+"/"+round(availableThrust)).
        if ship:maxthrust = 0 {
            stage.
        }
        until ship:altitude > 300 {
            lock steering to up.
        }

        until ship:apoapsis > OrbInput * 0.6{
            if ship:maxthrust = 0 {
                stage.
            }
            if ship:maxthrust < MaxIndicator {
                stage.
                set MaxIndicator to ship:maxthrust.
            }
            
            print("Mode0").
            print(round(maxThrust)+"/"+round(availableThrust)).
            print("Apoapsis: "+round(ship:apoapsis)).
            print("Altitude: "+round(ship:altitude)).
            if ship:altitude / 35000 < 1{
                set Diff to ship:altitude / 35000.
            }
            else {
                set Diff to 1.
            }
            lock steering to up + R(0,Diff*-90, 0).
            clearScreen.
        }
    }

    set throttle to 0.
    until ship:altitude > 70000 {
            print("mode0").
            print("Apoapsis: "+round(ship:apoapsis)).
            print("Periapsis: "+round(ship:periapsis)).
            print("Altitude: "+round(ship:altitude)).
        clearScreen.
        set throttle to 0.
        lock steering to up + R(0,-90,0).
        until ship:apoapsis > OrbInput {
            print("Apoapsis: "+round(ship:apoapsis)).
            print("Periapsis: "+round(ship:periapsis)).
            print("Altitude: "+round(ship:altitude)).
            clearScreen.
            set throttle to 0.1.
        }
    }
    unlock throttle.
    unlock steering.
}

// function that creates a circular node.
function CirNode{
    set BurnV to 0.
    Set NewNode to node(time:seconds + eta:apoapsis, 0,0, BurnV).
    add NewNode.
    until NewNode:obt:periapsis > 0.99*OrbInput or NewNode:obt:apoapsis > 1.02*OrbInput {
        set NewNode:prograde to NewNode:prograde + 1.
    }
}

function Mode1{
    set completed to false.
    until completed = true{
        clearScreen.
        print("mode1").
        print("Max Thrust: "+ round(ship:maxthrust)).
        print("Apoapsis: "+ round(ship:apoapsis)).
        print("Periapsis: "+ round(ship:periapsis)).
        print(maxThrust+"/"+availableThrust).
        if ship:maxthrust = 0 {
            wait 0.5.
            stage.
        }
        lock steering to nextNode:burnvector.
        if nextNode:eta <= nextNode:deltav:z / (ship:maxThrust/ship:mass){
            if ship:periapsis >= OrbInput{
                set completed to true.
                set throttle to 0.
                unlock throttle.
            }
            else {
                lock throttle to 1.
            }
        }

        // clearScreen.
        // set Burn_duration to nextNode:deltav:z / (ship:maxThrust/ship:mass).
        // set NodeVel to nextNode:deltav:z.
        // lock steering to nextNode:burnvector.
        // print(Burn_duration).
        // print("Apoapsis: "+ship:apoapsis).
        // print("Periapsis: "+ship:periapsis).
        // print("Altitude: "+ship:altitude).
        // if nextNode:eta < Burn_duration / 2 {
        //     if ship:periapsis >= OrbInput or ship:apoapsis >= OrbInput+2000 {
        //         clearScreen.
        //         print(Burn_duration).
        //         print("Apoapsis: "+ship:apoapsis).
        //         print("Periapsis: "+ship:periapsis).
        //         print("Altitude: "+ship:altitude).
        //         set Burn_duration to nextNode:deltav:z / (ship:maxThrust/ship:mass).
        //         lock throttle to 1.
        //     }
        //     else {
        //         set completed to true.
        //         set throttle to 0.
        //     }
        // }
    }
    remove nextNode.
    unlock throttle.
    unlock steering.
}


Mode0().
CirNode().
// Mode1().
clearScreen.





