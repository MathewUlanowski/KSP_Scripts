Function CreateTextField {
    // this is the parent Box the field will be inside of
    PARAMETER parent.
    // this is a non optional delegate for what happens when you press enter leave the box etc
    // WARNING: it must have one parameter the first parameter represents the value that it has been changed to.
    PARAMETER ActionDelegate.
    PARAMETER Default.
    LOCAL Field IS parent:addtextfield(Default).
    set Field:onconfirm to ActionDelegate@.
    RETURN Field.
}