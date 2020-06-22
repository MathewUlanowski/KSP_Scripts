set AllFiles to OPEN("0:/").

PARAMETER Handup is FALSE.

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
    IF NOT (item = ".gitignore") 
    AND NOT (item = ".git") 
    AND not (item = "boot")
    AND NOT (item = "Libs"){
        LOCAL ItemIter to item.
        CreateStaticButton(
            SB,
            item,
            {
                RUNPATH(ItemIter).
            }
        ).
    }    
}
ButtonGUI:show().
WAIT UNTIL COMPLETED or Handup.
