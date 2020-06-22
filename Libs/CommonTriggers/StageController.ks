FUNCTION LFO_Trigger {
    LOCAL PARAMETER Repeat is TRUE.
    when STAGE:LIQUIDFUEL = 0  then {
        STAGE.
        RETURN Repeat.
    }
}