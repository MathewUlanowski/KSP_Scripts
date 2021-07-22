FUNCTION LFO_Trigger {
    LOCAL PARAMETER Repeat is TRUE.
    when STAGE:LIQUIDFUEL < 1  then {
        STAGE.
        RETURN Repeat.
    }
}