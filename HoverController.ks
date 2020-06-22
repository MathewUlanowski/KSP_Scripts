
stage.
// Import the functions from the HoverLib
run import("0:/Libs/HoverLib").
run import("0:/Libs/GUImaker").

// optional parameter to set the desired altitude upon calling the function
PARAMETER DesiredAltitude is 0.

// hovermode tells the program weather it is in Sea Level or Radar Mode
PARAMETER HoverMode is 1.

// Optional parameter to be able to set the altitude lock to true
PARAMETER AltLock IS false.

// sets landing mode to false by default once this is triggered it cannot be untriggered
set LandingMode to FALSE.

Local ExitCondition to FALSE.

set Tilt to 85.

set HomePos to GEOPOSITION.

LOCAL AngleChangeHolder to {
    return VECTORANGLE(up:vector, SHIP:facing:forevector).
}.
// GUI controller
// most if not all of displayed values are displayed asynchronousely so ti will update as the value updates
LOCAL HoverGui is GUI(400).

set Header to StaticLabel(HoverGui, "hOVER GUI").
set Header:style:align to "CENTER".
set Header:style:hstretch to TRUE.


// LOCAL Header is HoverGui:addlabel("Hover GUI").
//     set Header:style:align to "CENTER".
//     set Header:style:hstretch to TRUE.
// displays the current altitude on the GUI 
DynamicLabel(HoverGui, {
    RETURN "Target Alt: " + round(ALT:radar) + "/" + round(DesiredAltitude,5).
}).
// LOCAL TargetAlt is HoverGui:addlabel("Target ALT: " + round(DesiredAltitude,5)).
// set TargetAlt:textupdater to {RETURN "Target ALT: " + round(ALT:radar) + "/" + round(DesiredAltitude,5).}.
// shows the altitude mode 
LOCAL ModeLabel is HoverGui:addlabel("Mode: ").
set ModeLabel:textupdater to {
    if(HoverMode = 1){
        RETURN "Mode: Radar".
    }
    else {
        Return "Mode: SeaLevel".
    }
}.
// shows the status of ALtitude Lock
LOCAL AltitudeLockLabel is HoverGui:addlabel("").
set AltitudeLockLabel:textupdater to {
    if(AltLock = TRUE){
        RETURN "Altitude Lock: ON".
    }
    else {
        RETURN "Altitude Lock: OFF".
    }
}.
// prints the ship Bearing
LOCAL BearingLabel is HoverGui:addlabel().
set BearingLabel:textupdater to {
    RETURN "Bearing: "+round(ship:bearing,1).
}.
// prints the value of the surgace prograde vector
Local SProVec is HoverGui:addlabel().
set SProVec:textupdater to {
    LOCAL VecX to ROUND(SHIP:srfprograde:vector:x,1).
    LOCAL VecY to ROUND(SHIP:srfprograde:vector:y,1)*0.
    LOCAL VecZ to ROUND(SHIP:srfprograde:vector:z,1).
    RETURN "X: "+VecX+" Y: "+VecY+" Z: "+VecZ.
}.

Local Cords is HoverGui:addlabel().
set Cords:textupdater to {
    RETURN "Lat: "+round(GEOPOSITION:LAT,4) +" Lng: "+ round(GEOPOSITION:lng,4).
}.


// Exit Button this kills the program and closes the GUI
LOCAL ExitBTN to HoverGui:addbutton("STOP").
SET ExitBTN:onclick to {
    set ExitCondition to TRUE.
}.

HoverGui:show().




// action triggers pressing a button changes the mode
on AG1 {
    print("moving up").
    set DesiredAltitude to DesiredAltitude + 5.
    RETURN true.
}
on AG2 {
    print("moving down").
    set DesiredAltitude to DesiredAltitude -5.
    RETURN TRUE.
}
on AG3{
    if(HoverMode = 1){
        set HoverMode to 0.
        RETURN true. 
    }
    else {
        set HoverMode to 1.
        RETURN true.
    }
}
on AG4 {
    if AltLock = FALSE{
        set AltLock to TRUE.
        set LockSnapshot to lex("Altitude",DesiredAltitude, "HoverMode",HoverMode).
        set DesiredAltitude to ship:altitude.
        set HoverMode to 0.
        RETURN TRUE.
    }
    else {
        set AltLock to FALSE.
        set DesiredAltitude to LockSnapshot:Altitude.
        set HoverMode to LockSnapshot:HoverMode.
        RETURN TRUE.
    }
}
on AG5 {
    TOGGLE LandingMode.
    RETURN TRUE.
}

// Control Triggers



// repeating loop controlling the craft and its TWR and thrust to keep it hovering
until ExitCondition {
    CLEARSCREEN.

    set TWR to (THROTTLE * SHIP:MAXTHRUST)/ ship:MASS/(CONSTANT:g*(ship:body:mass/((ship:body:distance)^2))).

    // [WIP] detects if the brakes are on and attemts to arrest all horizontal velocity if they are
    if(BRAKES){
        print "the brakes are on".

        print( round( 1/arcsin(1/Max_TWR)*(180/CONSTANT:pi) , 2 ) ).
        Print "Landing Mode: "+LandingMode.
        if(LandingMode){
            SAS OFF.
            set DesiredAltitude to -10.
            if(ALT:radar < 100){
                GEAR on.
            }
            if(ship:groundspeed > 0.5){
                lock steering to ship:srfretrograde.
            }
            else {
                lock steering to up.
            }
            if(ship:STATUS = "landed"){
                set DesiredAltitude to -1000.
                REBOOT.
            }
        }
    }
    else {
        UNLOCK steering.
        CLEARVECDRAWS().
    }

    // runs from the external lib functions
    if((VELOCITY:surface:mag > 1700) and (LandingMode = TRUE) and (ALTITUDE < 70000)){
        lock THROTTLE to 1.
    }
    else {
        lock Throttle to Hover_Throttle(Hover_Angle_Offset_TWR()*Altitude_TWR_Offset(DesiredAltitude,HoverMode)).
    }
}

HoverGui:hide().
HoverGui:dispose().