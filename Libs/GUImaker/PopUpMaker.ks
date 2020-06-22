FUNCTION NewPopup {
    PARAMETER Message is "Hello World".
    PARAMETER ButtonText is "CLOSE".
    set PopUp to GUI(200).
    SET Message to PopUp:addlabel(Message).
    SET ButtonText TO PopUp:addbutton(ButtonText).
    PopUp:show().
    SET ButtonText:onclick to {
        PopUp:hide().
        PopUp:dispose().
    }.
}