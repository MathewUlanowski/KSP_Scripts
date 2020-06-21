DECLARE PARAMETER HovAlt.

SAS OFF.

set HeightOffset to alt:radar.

set DesiredTWR to 0.

stage.

set MissionStatus to "Starting".

function GravityDv {
    return constant:g*(ship:body:mass/((ship:body:distance)^2)).
}

function ThrottleController {
    CLEARSCREEN.
    print("Mission Status: "+MissionStatus).
    lock steering to up.
    set GDv to constant:g*(ship:body:mass/((ship:body:distance)^2)).
    set ThrotController to DesiredTWR * ship:mass * GDv/ship:availablethrust.
    lock throttle to ThrotController.
    print("Trigger Dv: "+GravityDv()*30).
    print("Alt: "+(Alt:radar - HeightOffset)).
}

// until FALSE {
until false {
    ThrottleController().
    // print("Gravitational Constant: "+constant:g).
    // print("Gravity Acc: "+GDv).
    // print(ship:body:name +" Mass:"+round(ship:body:mass,2)).
    // print("Ship Mass: "+Ship:mass).
    // print("Distance: "+Round(ship:body:distance,2)+"m").
    // print("Horizontal Speed: "+round(ship:groundspeed,2)).
    // print("vertical Speed: "+ship:verticalspeed).
    // print(GDv/ship:availablethrust).
    // print(round(throtController*100,2)+"% Thrust").
    if ship:verticalspeed > 5 and ALT:radar - HeightOffset< HovAlt {
        GEAR OFF.
        set DesiredTWR to 1.
    }
    if ALT:radar - HeightOffset> HovAlt{
        break.
    }
    if DesiredTWR = 0{
        set DesiredTWR to 1.1.
    }
    set MissionStatus to "Climbing to altitude".
}

set NeedToLand to false.

until NeedToLand = true {
    set MissionStatus to "Hovering".
    if ship:verticalspeed > 0 {
        set DesiredTWR to 1-(1*(ship:verticalspeed/5)).
    }
    else {
        if ship:VERTICALSPEED < 0 {
            set DesiredTWR to 1 + (1*(ship:verticalspeed/5)).
        }
    }

    // set DesiredTWR to 1* 1/(ship:verticalspeed/5).

    ThrottleController().
    list Engines in ShipsEngines.
    set ISPtot to 0.

    for eng in ShipsEngines {
        set ISPtot to ISPtot + eng:SLISP*(eng:maxthrust/ship:maxthrust).
    }
    if (9.8*ISPtot)*ln(ship:mass/Ship:drymass) < 300 {
        GEAR ON.
    // if (9.8*ISPtot)*ln(ship:mass/Ship:drymass) < GravityDv()*30 {
        set NeedToLand to true.
    }
}

until ship:verticalspeed <= -5 {
    set MissionStatus to "starting Deceleration".
    set DesiredTWR to 0.9.
    ThrottleController().
}

set SpeedVar to 5.

until ship:status = "LANDED" {
    if ALT:radar - HeightOffset > 10 {
        set MissionStatus to "Coasting downwards".
        set DesiredTWR to 1.
    }
    else {
        set MissionStatus to "initiating final landing sequence".
        set SpeedVar to 5 * ((ALT:radar-HeightOffset)/10).
        set DesiredTWR to SpeedVar/ship:verticalspeed.
        // if ship:verticalspeed > SpeedVar {
        //     set DesiredTWR to 1 - (1*(SpeedVar)).
        // }
        // else {
        //     if ship:VERTICALSPEED < SpeedVar {
        //         set DesiredTWR to 1 + (1*(SpeedVar)).
        //     }
        // }
    }
    ThrottleController().
}

lock throttle to 0.
lock STEERING to UP.
UNLOCK throttle.
UNLOCK STEERING.
CLEARSCREEN.
print("Congradulations you have landed. Hopefully in one piece").
