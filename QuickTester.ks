lock steering to up.

run HoverLib.

LOCAL MyGui IS GUI(200).
LOCAL label IS MyGui:addlabel("Info Panel").
set label:style:align TO "CENTER".
SET label:style:hstretch to TRUE.

local RadarALT IS MyGui:addlabel("Radar ALT: "+round(ALT:radar, 2)).
set RadarALT:textupdater to {return "Radar ALT: " + round(ALT:Radar,2).}.

LOCAL TWR is MyGui:addlabel("TWR: "+ (THROTTLE*SHIP:maxthrust)/ship:mass/GravDeltaV).
set TWR:textupdater to {RETURN "TWR: " + round((THROTTLE*ship:maxthrust)/ship:mass/GravDeltaV, 3).}.



LOCAL Exit to MyGui:addbutton("EXIT").
set Exit:tooltip to "Exits and destroys the current GUI".


MyGui:show().

LOCAL IsDone IS FALSE.
SET Exit:onclick to {
    set IsDone to True.
}.

WAIT until IsDone.

MyGui:hide().
MyGui:dispose().
