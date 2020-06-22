run import("0:/Libs/GUImaker").

LOCAL TestGui to GUI(200).
TestGui:show().
on ABORT {
    set Completed to True.
}
Set Completed to FALSE.



// testing static label maker
StaticLabel(TestGui, "Tester GUI").
CreateTextField(TestGui, {
    PARAMETER str.
    print(str).
    RETURN str.
}).
// testing dynamic label maker
DynamicLabel(TestGui, {
    RETURN round(ALT:radar).
}).
// testing button maker
// creating a single button
set ButtonNames to LIST("BUTTON 1", "BUTTON 2"). 
SET ButtonCommands to LIST(
    {
        print("Button 1 was pressed").
    },
    {
        print("Button 2 was pressed").
        SET Completed to TRUE.
    }
).
CreateButtonList(TestGui, ButtonNames, ButtonCommands).

when Completed then {
    TestGui:hide().
    TestGui:dispose().
}

until Completed.
