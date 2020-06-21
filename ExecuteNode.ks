PARAMETER StagingMode is TRUE.


if StagingMode {
    RUN StageController.
}

IF HASNODE = TRUE {
    when NEXTNODE:BURNVECTOR:MAG <= 0.0001 then {
        SET completed TO TRUE.
        LOCK THROTTLE TO 0.
        LOCK STEERING TO PROGRADE.
        SAS ON.
    }
}

WHEN NEXTNODE:eta - TIME:seconds < NEXTNODE:burnvector:mag/((ship:maxthrust/ship:mass)/2)-10 AND WARP = 0 AND VectorFacing() = TRUE THEN {
    WARPTO(Time:seconds+(NEXTNODE:eta-(NEXTNODE:burnvector:mag/(ship:maxthrust/ship:mass))/2)-30).
}

SET completed TO FALSE.

FUNCTION VectorFacing {
    SET PitchTarget to FALSE.
    set YawTarget to FALSE.
    if SHIP:FACING:PITCH - NEXTNODE:deltav:DIRECTION:PITCH < 1 {
        SET PitchTarget TO TRUE.
    }
    if SHIP:FACING:YAW - NEXTNODE:deltav:DIRECTION:YAW < 1 {
        SET YawTarget TO TRUE.
    }
    IF PitchTarget AND YawTarget {
        RETURN TRUE.
    }
    ELSE {
        RETURN FALSE.
    }
}

on ABORT {
    SET completed to TRUE.
    LOCK THROTTLE TO 0.
    LOCK STEERING TO PROGRADE.
    SAS ON.
}

function EXECUTEONENODE {
    set warp to 0.
    WAIT 2.
    until completed = true {
        print NEXTNODE:eta - TIME:second.
        print VectorFacing.
        PRINT SHIP:facing.
        PRINT NEXTNODE:deltav:direction.
        lock Steering to Nextnode:burnvector:normalized.
        CLEARSCREEN.
        SAS OFF.
        print(ROUND(NEXTNODE:burnvector:mag, 3)).
        WAIT UNTIL NEXTNODE:eta - 120.
        if NEXTNODE:ETA < (NEXTNODE:burnvector:mag/(ship:maxthrust/ship:mass))/2{
            if NEXTNODE:burnvector:mag < 30{
                lock throttle to 1*NEXTNODE:burnvector:mag/30.
            }
            else {
                LOCK throttle to 1.
            }
        }
    }
}

EXECUTEONENODE().
UNLOCK THROTTLE.
UNLOCK STEERING.
REMOVE NEXTNODE.