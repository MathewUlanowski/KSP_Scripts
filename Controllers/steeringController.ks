RUNPATH("0:/import" ,"0:/Libs/GUImaker").

PARAMETER Submit is FALSE.

set DirString to "90".
set TiltString to "90".

Set SteeringGui to CreateGui("Steering Controller",150).

set DirectionLabel to StaticLabel(SteeringGui ,"Direction").
set DirectionLabel:style:align to "CENTER".

if Submit {
    lock steering to heading(90,90,-90).
    set DirectionField to CreateTextField( 
        SteeringGui, 
        {
        Local PARAMETER Input.
        set DirString to Input.
        },
        "90"
    ).
}
else {
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
}



set TiltLabel to StaticLabel(SteeringGui ,"Tilt").
set TiltLabel:style:align to "CENTER".

if Submit {
    set TiltField to CreateTextField( 
        SteeringGui, 
        {
        Local PARAMETER Input.
        set TiltString to Input.
        },
        "90"
    ).
    set SubmitBtn TO CreateButton(SteeringGui, "Change", {
        SAS OFF.
        LOCK Steering to HEADING( DirString:tonumber(), TiltString:tonumber(), -1*DirString:tonumber() ).
        RETURN TRUE.
    }).
}
else {
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
}

set DirectionField:style:align to "CENTER".
set TiltField:style:align to "CENTER".

SteeringGui:show().


