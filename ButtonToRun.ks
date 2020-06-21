set AllFiles to OPEN("0:/").

SET COMPLETED TO FALSE.

ON AG9 {
    SET COMPLETED TO TRUE.
    CLEARGUIS().
    RETURN true.
}

// imports GUI maker function to simplify KOS's BOX model labeling system to a simple function

run import("0:/Libs/GUImaker").

SET ButtonGUI to GUI(325, 200).
SET SB TO ButtonGUI:addscrollbox().

for item in AllFiles:list:values {
    IF NOT (item = ".gitignore") {
        print item.
        CreateStaticButton(
            SB,
            // item
            item,
            {
                LOCAL IterItem to item.
                RUNPATH(IterItem).
            }
        ).
    }    
}
ButtonGUI:show().
WAIT UNTIL COMPLETED.