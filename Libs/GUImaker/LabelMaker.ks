FUNCTION StaticLabel {
    LOCAL PARAMETER Parent.
    LOCAL PARAMETER Content.
    SET ContentLabel TO Parent:addlabel(Content).
    RETURN ContentLabel.
}

FUNCTION DynamicLabel {
    LOCAL PARAMETER Parent.
    PARAMETER Content.
    Local PARAMETER LabelPrefix is "".
    SET Label to Parent:addlabel().
    SET Label:textupdater TO {
        RETURN LabelPrefix + Content().
    }.
    RETURN Label.
}