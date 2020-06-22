FUNCTION StaticLabel {
    LOCAL PARAMETER Parent.
    LOCAL PARAMETER Content.
    SET Content TO Parent:addlabel(Content).
    RETURN Content.
}

FUNCTION DynamicLabel {
    LOCAL PARAMETER Parent.
    PARAMETER Content.
    SET Label to Parent:addlabel().
    SET Label:textupdater TO {
        RETURN Content().
    }.
    RETURN Label.
}