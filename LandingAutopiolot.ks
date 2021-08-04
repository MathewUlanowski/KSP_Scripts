print("Landing Mode Engaged").
RUNPATH("0:/import","0:/Libs/CommonTriggers").
RUNPATH("0:/import","0:/Libs/Guimaker").
RUNPATH("0:/IMPORT","0:/libs/HoverLib").
RUNPATH("0:/IMPORT","0:/libs/BaseLib").

// Trigger pulled from Libs/CommonTriggers for automatic staging
LFO_Trigger().

// sets the initial state of the program
SET GroundGravV to BASIC:GroundGravV().
SET ExitCondition TO FALSE.
SET AbortCondition TO FALSE.

// sets up the SAS system just to hold the ship to surface retrograde this is later turned off and steering locks are engaged but this allows it to take over from a position of stability for the most part 
SAS ON.
SET NAVMODE TO "SURFACE".
SET SASMODE to "RETROGRADE".

// Triggers for landing the sets the exit condition to TRUE ending the loop
WHEN ship:STATUS = "LANDED" OR SHIP:STATUS = "SPLASHED" then {
    IF SHIP:status = "SPLASHED" {
        GEAR OFF.
    }
    SET ExitCondition to TRUE.
    BRAKES OFF.
    RETURN True.
}

// turns airbrakes on if there are any when entering the atmosphere and toggles AG10 which is my default for anteneas and solar panels
WHEN ALT:radar < 70000 THEN {
    BRAKES on.
    TOGGLE AG10.
}

WHEN ALT:radar < 5000 THEN{
    CHUTES ON.
}



FUNCTION DIST {
    RETURN ALT:radar-25.
}
FUNCTION ACCELERATION {
    RETURN SHIP:AVAILABLETHRUST / SHIP:MASS.
}
FUNCTION NetPositiveDv {
    RETURN ACCELERATION() - GravDeltaV().
}
FUNCTION BURNDIST {
    RETURN VERTICALSPEED^2/(2*NetPositiveDv()).
}
FUNCTION IdealThrottle {
    RETURN BURNDIST/DIST().
}





// Trigger to start running when the 0 velocity burn time = impact time 
// in short when at max thrust without factoring in decreasing mass velocity = 0 at the ground
// commonly called a suicide burn
WHEN ALT:RADAR < 50000 then {
    SAS OFF.
    if BASIC:SRFCMAG() > 1700 {
        LOCK STEERING TO SRFRETROGRADE.
        LOCK THROTTLE to 1.
    } else {
        if BURNDIST() >= DIST() AND VERTICALSPEED < 0 AND ALT:RADAR > 25{
            SAS OFF.
            LOCK STEERING TO SRFRETROGRADE.
            LOCK THROTTLE TO IdealThrottle().
        } ELSE {
            if ALT:radar < 25 {
                GEAR ON.
                LOCK STEERING to up.
                LOCK THROTTLE TO Hover_Throttle(Velocity_TWR_Offset(-1)).
            } ELSE {
                LOCK THROTTLE TO 0.
            }
        }
        
    }
    RETURN True.
}


// ABORT condition will force the loop to terminate even if not completed
on ABORT {
    SET AbortCondition TO TRUE.
}

// Creating an information GUI Functions Pulled from /Libs/Guimaker
// initiating the GUI and header
LOCAL LandingGui TO CreateGui("Landing Info").
LOCAL DistanceLabel to DynamicLabel(LandingGui, {
    RETURN ROUND(DIST(),1).
}).
LOCAL BURNDISTLabel to DynamicLabel(LandingGui, {
    RETURN BURNDIST().
}).
LOCAL VehicleAccelerationLabel to DynamicLabel(LandingGui, {
    RETURN ROUND(ACCELERATION(),1).
}).
LOCAL NetAcceleration to DynamicLabel(LandingGui, {
    RETURN ROUND(NetPositiveDv(),1).
}).
LOCAL IdealThrottleLabel TO DynamicLabel(LandingGui, {
    RETURN ROUND(IdealThrottle()*100,1)+"%".
}).
LOCAL AbortButton to CreateButton(LandingGui, "ABORT", {
    TOGGLE ABORT.
}).
// making the GUI Visible
LandingGui:show().




// Looping condition 
UNTIL AbortCondition OR ExitCondition.
// prints if the program was aborted
if AbortCondition {
    print("Program Aborted!").
}
// prints if the program ran its cours
if ExitCondition {
    print("Program Finished!").
}


// Cleaning up.
UNLOCK THROTTLE.
UNLOCK STEERING.
set ship:control:pilotmainthrottle to 0.
SAS ON.
LandingGui:Hide().
LandingGui:dispose().