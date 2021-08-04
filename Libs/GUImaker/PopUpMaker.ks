FUNCTION NewPopup {
    PARAMETER Message is "Hello World".
    PARAMETER ButtonText is "CLOSE".
    PARAMETER ButtonAction is {}.
    set PopUp to GUI(200).
    SET Message to PopUp:addlabel(Message).
    SET Message:style:align to "CENTER".
    SET ButtonText TO PopUp:addbutton(ButtonText).
    PopUp:show().
    SET ButtonText:onclick to {
        ButtonAction@:call().
        PopUp:hide().
        PopUp:dispose().
    }.
}