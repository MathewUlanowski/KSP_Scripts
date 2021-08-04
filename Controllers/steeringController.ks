RUNPATH("0:/import" ,"0:/Libs/GUImaker").


set DirString to "90".
set TiltString to "90".

Set SteeringGui to CreateGui("Steering Controller",150).

set DirectionLabel to StaticLabel(SteeringGui ,"Direction").
set DirectionLabel:style:align to "CENTER".
set DiretionField to CreateTextField( 
    SteeringGui, 
    {
        Local PARAMETER Input.
        SAS OFF.
        LOCK Steering to HEADING( Input:tonumber(), TiltString:tonumber(), -1*Input:tonumber()).
        set DirString to Input.
    },
    "90"
).




set TiltLabel to StaticLabel(SteeringGui ,"Tilt").
set TiltLabel:style:align to "CENTER".
set TiltField to CreateTextField( 
    SteeringGui, 
    {
        Local PARAMETER Input.
        SAS OFF.
        LOCK Steering to HEADING( DirString:tonumber(), Input:tonumber(), -1*DirString:tonumber() ).
        set TiltString to Input.
    },
    "90"
).


set DiretionField:style:align to "CENTER".
set TiltField:style:align to "CENTER".

SteeringGui:show().


