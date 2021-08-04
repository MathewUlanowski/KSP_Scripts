
RUNPATH("0:/import", "Libs/GUImaker").

set Exit to FALSE.
on ABORT {
    set Exit to TRUE.
}

set VecGui to CreateGui("Vector Gui").
set BodyVecLabel to DynamicLabel(VecGui, {
    RETURN "Body Vector: "+ship:body:position.
}).
set TargetVecLabel to DynamicLabel(VecGui, {
    RETURN "Target Vector: "+TARGET:position.
}).
set PhaseAngleLabel to DynamicLabel(VecGui, {
    RETURN round(vang(ship:position-ship:Body:position, TARGET:position-ship:body:position),1).
}).
set AbortButton to CreateButton(VecGui,"EXIT",{
    SET Exit to TRUE.
}).
VecGui:show().

VECDRAW(ship:position,{return -up:vector*20.},RED,"Down Vector",1,TRUE,0.3,FALSE).
VECDRAW(ship:position,{RETURN (TARGET:position/TARGET:distance)*20.},BLUE,"Target",1,TRUE,0.3,FALSE).

VECDRAW(ship:position,{RETURN SHIP:SRFPROGRADE:Vector*(SHIP:airspeed/100).},YELLOW,"Forward Vec",1,TRUE,0.3,TRUE).


wait UNTIL Exit.

CLEARVECDRAWS().
CLEARGUIS().