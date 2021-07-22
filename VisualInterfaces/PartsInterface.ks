RUNPATH("0:/import","Libs/GuiMaker").

FUNCTION PartsInterface {
    PARAMETER Parent.
    PARAMETER theVesseL is ship.

    SET CONTAINTER TO Parent:addscrollbox().
    SET PARTSLIST TO theVesseL:PARTS.

    FOR PART IN PARTSLIST {
        set PARTBOX TO CONTAINTER:addvbox().
        set PARTBOX:style:margin:left to 10.
        set NameTag to StaticLabel(PARTBOX, PART:name).

        set ModuleList to PART:allmodules.

        for Module in ModuleList {
            set ModuleLayout to CONTAINTER:addvlayout().
            set moduleLabel to StaticLabel(ModuleLayout, Module).
            set moduleLabel:style:margin:left to 30.

            set ModuleObj to Part:getmodule(Module).

            for Event in ModuleObj:allfieldnames {
                set EventBox to ModuleLayout:addvbox().
                set EventBox:style:margin:left to 60.
                set EventLabel to StaticLabel(EventBox, Event).

                if event = "status" {
                    print("Got an antenna").
                    // print(Event).
                    StaticLabel(EventBox, ModuleObj:getfield(event)).
                }
                // print(ModuleObj:getfield(event)).
            }
        }
    }
    
    RETURN Parent.
}