RUNPATH("0:/import", "Libs/GuiMaker").

FUNCTION MassAndOrbit {
    PARAMETER CurrentBody.
    PARAMETER CurrentContainer.

    set GravSetting to StaticLabel(CurrentContainer, "    "+CurrentBody:MU:tostring()).
    set SolarDistLabel to DynamicLabel(CurrentContainer, {
        RETURN ROUND(CurrentBody:ALTITUDE/1000,2)+"km".
    }, "    ORBIT: ").
    RETURN CurrentContainer.
}