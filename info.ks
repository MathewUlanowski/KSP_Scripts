run import("Libs/BaseLib").

on ABORT {
    SET completed TO TRUE.
    InfoGui:hide().
    InfoGui:dispose().
}

SET completed TO FALSE.

SET InfoGui TO GUI(200).
SET Header TO InfoGui:addlabel("Basic Info").
    SET Header:style:align TO "CENTER".
    SET Header:style:hstretch TO TRUE.

FUNCTION CreateInfoUpdater {
    PARAMETER DelegateInfo.
    PARAMETER Title is "".
    SET fieldContainer TO InfoGui:addlabel().
    SET fieldContainer:textupdater TO {
        RETURN Title +": "+ DelegateInfo.
    }.
}

SET Max_TWR TO InfoGui:addlabel().
SET Max_TWR:textupdater TO {
    RETURN "MAX TWR: "+ROUND(BASIC:TWR:MAX(),3).
}.
SET Current_TWR TO InfoGui:addlabel().
SET Current_TWR:textupdater TO {
    RETURN "CURRENT TWR: "+ROUND(BASIC:TWR:CURRENT(),3).
}.
SET Current_Pe TO InfoGui:addlabel().
SET Current_Pe:textupdater TO {
    RETURN "Pe: "+ROUND(ALT:PERIAPSIS,3).
}.
SET Current_Ap TO InfoGui:addlabel().
SET Current_Ap:textupdater TO {
    RETURN "Ap: "+ROUND(ALT:APOAPSIS,3).
}.
SET FacingRot TO InfoGui:addlabel().
SET FacingRot:textupdater TO {
    RETURN SHIP:FACING.
}.

InfoGui:show().

until Completed {

}