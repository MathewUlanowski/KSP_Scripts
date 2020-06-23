FUNCTION StaticLabel {
    LOCAL PARAMETER Parent.
    LOCAL PARAMETER Content.
    SET Content TO Parent:addlabel(Content).
    RETURN Content.
}

FUNCTION DynamicLabel {
    LOCAL PARAMETER Parent.
    PARAMETER Content.
    Local PARAMETER LabelAlign is "".
    SET Label to Parent:addlabel().
    SET Label:textupdater TO {
        RETURN Content().
    }.
    if NOT LabelAlign = "" {
        set Label:style:align to LabelAlign.
    }
    RETURN Label.
}