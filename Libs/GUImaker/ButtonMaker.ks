// creates a label where the value does not change
FUNCTION CreateButton {
    // pass in the GUI your going to put this button into for more info please see KOS Doucmentation on Box's
    PARAMETER ParreentBox.
    // name of the button or what the button text will say
    PARAMETER BTNName.
    // this should be a function that the button will execute when it is clicked.
    PARAMETER ButtonAction is {
        print("you pressed the "+BTNname+" Button").
    }.
    LOCAL thisButton IS ParreentBox:addbutton(""+BTNName).
    SET thisButton:onclick TO {
        ButtonAction().
    }.
    RETURN thisButton.
}

// creates a label where a delegate is passed in
FUNCTION CreateButtonList {
    // the name of the box or container your putting the list of buttons in
    PARAMETER Parent.
    // list of button names to be used for the text value of the button
    PARAMETER NamesList.
    // must have a list of actions to perform with each button
    PARAMETER ActionList.
    LOCAL i is 0.
    for name in NamesList {
        LOCAL action to ActionList[i].
        CreateButton(Parent, name, action).
        set i to i+1.
    }
}

