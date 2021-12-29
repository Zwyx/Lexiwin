; Lexiwin - Functions for the Classic clipboard

ClpClassicSpaceOrWheel(Direction, MenuType = "Complete")
{
    Global
    
    If LxwState = Normal
    {
        ClpClassicNextToPaste := ClpNextToCache
        LxwState = ClpClassic
    }
    Else If LxwState = ClpClassic
    {
        CmnSelectNextToPaste("Classic", Direction)
    }
    
    If LxwState = ClpClassic
    {
        CmnCompareNextToPasteWithClipboard("Classic", Direction)
        ClpDisplayTooltip("Classic", MenuType)
    }
}
