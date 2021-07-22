RUN import("0:/VisualInterfaces").
RUN import("0:/Libs/GuiMaker").

SET ExitCondition to FALSE.
ON ABORT {
    SET ExitCondition to TRUE.
}


set OutGui to CreateGUI(" Part Gui ",300,300).
PartsInterface(OutGui).
OutGui:show().



WAIT UNTIL ExitCondition.
CLEARGUIS().