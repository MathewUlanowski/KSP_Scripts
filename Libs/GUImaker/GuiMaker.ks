FUNCTION CreateGui {
    PARAMETER Header.
    PARAMETER width is 200.
    PARAMETER Height is 200.
    LOCAL NewGui to GUI(width, Height).
    set Header to NewGui:addlabel(Header).
    set Header:style:align to "CENTER".
    set Header:style:hstretch to TRUE.
    RETURN NewGui.
}