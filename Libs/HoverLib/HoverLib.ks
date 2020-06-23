// everything is handled based on TWR
// this is because the way hover is handled is by maintainting a TWR of 1.0

set Max_TWR to ship:AVAILABLETHRUST/ship:mass.

FUNCTION GravDeltaV {
    RETURN CONSTANT:g*(ship:body:mass/((ship:body:distance)^2)).
}.
FUNCTION Current_TWR {
    Return (THROTTLE*SHIP:availablethrust) / ship:mass/(CONSTANT:G*(SHIP:body:mass/((ship:body:distance)^2))).
}

FUNCTION Hover_Angle_Offset_TWR {
    Return 1/(Cos(VECTORANGLE(Up:vector, ship:FACING:forevector))).
}


// returns a multiple of 100% (value of 1) this can be used to throttle the craft and maintain the throttle
FUNCTION Hover_Throttle {
    // optional parameter for the thrust to weight desired to maintain defaults to 1
    // if you want a perfectly level vertical hover
    Local PARAMETER Desired_Thrust_To_Weight is 1.

    return ( Desired_Thrust_To_Weight * ship:mass * GravDeltaV()/ship:availablethrust ).
}

FUNCTION Velocity_TWR_Offset {
    // this parameter is the desired velocity of the vehicle
    // it can take negative values if youd like it to lower at a specific velocity.
    PARAMETER Vertical_Velocity is 0.
    // print(Vertical_Velocity).
    // print Max_TWR.
    if Vertical_Velocity > -100 and ship:verticalspeed < -100 {
        SET vertical_velocity_TWR to Max_TWR.
    }
    else {
        SET vertical_velocity_TWR to (-0.01*Max_TWR*ship:verticalspeed+(Max_TWR*Vertical_Velocity/100))+1. 
    }

    // print vertical_velocity_TWR.
    RETURN vertical_velocity_TWR.
}

Function Altitude_TWR_Offset{
    PARAMETER Target_Altitude is 100.
    PARAMETER Mode is 1.
    if(Mode = 0){
        LOCAL TargetVelocity to ((-1*ship:ALTITUDE)+Target_Altitude)/GravDeltaV().
        RETURN Velocity_TWR_Offset(TargetVelocity).
    }
    if(Mode = 1){
        Local TargetVelocity to ((-1*ALT:radar)+Target_Altitude)/GravDeltaV().
        RETURN Velocity_TWR_Offset(TargetVelocity).
    }
}

