Function CreateTextField {
    PARAMETER parent.
    PARAMETER ActionOnChange.
    LOCAL Field IS parent:addtextfield().
    set Field:onchange to ActionOnChange().
    RETURN Field.
}