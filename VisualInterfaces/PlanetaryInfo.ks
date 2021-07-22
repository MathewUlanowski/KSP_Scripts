RUNPATH("0:/import","Libs/GUImaker").
RUNPATH("0:/import","Libs/BaseLib").
RUNPATH("0:/VisualInterfaces/InfoConstructors").

function RecursivePlanetTree {

    // takes in a variable where the GUI is stored in it will create one and return a GUI if there is none defined
    // it will return what ever GUI object is put in regardless 
    PARAMETER ParentGui is CreateGui("PlanetaryGui").
    PARAMETER CurrentBody is SUN.
    PARAMETER Recurse is FALSE.
    PARAMETER AutoVisualize is FALSE.
    // this value should be set to a function that takes a body and parent box or gui object
    // will then do what ever you write that function to do what ever you want recursively for every child of the sun but not the sun
    PARAMETER RecursiveFunction is {parameter p1. parameter p2.}.

    if CurrentBody = SUN {
        set HolderBox to ParentGui:addvbox().

        set SunLabel to StaticLabel(HolderBox, CurrentBody:Name).
        set SunLabel:style:font to "HEADINGFONT".

        set Slider to HolderBox:ADDSCROLLBOX().

    } else {
        set ParentGui:style:padding:right to 0.
        if RecursiveFunction:istype("userDelegate") {
            RecursiveFunction:call(CurrentBody, ParentGui).
        }
    }
    
    set ChildrenList to CurrentBody:ORBITINGCHILDREN.

    for BODYI in ChildrenList {
        if CurrentBody = SUN {
            set Container to Slider.
        } else {
            set Container to ParentGui:addvbox().
        }

        set Container:style:margin:left to 30.
        set Container:style:margin:right to 0.

        set BodyLabel to StaticLabel(Container, BODYI:NAME).
        if Recurse {
            RecursivePlanetTree(Container, BODYI, Recurse, TRUE, RecursiveFunction).
        }
    }

    if AutoVisualize {
        ParentGui:show().
    }

    RETURN ParentGui.
}