FUNCTION CreateStaticButton {
    // pass in the GUI your going to put this button into for more info please see KOS Doucmentation on Box's
    PARAMETER AttatchToGui.
    // name of the button or what the button text will say
    PARAMETER BTNName.
    // this should be a function that the button will execute when it is clicked.
    // make sure to return true if you want it to be repeatable I think
    PARAMETER ButtonAction is {
        print("you pressed the "+BTNname+" Button").
        RETURN TRUE.
    }.
    LOCAL thisButton IS AttatchToGui:addbutton(""+BTNName).
    SET thisButton:onclick TO {
        ButtonAction().
    }.
    RETURN thisButton.
}