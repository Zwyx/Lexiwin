; Lexiwin - Functions for the FIFO clipboard

ClpIsFifoFull()
{
    Global
    
    Index := CmnGetPasteIndex(ClpFifoNextToPaste)
    
    If (Index >= PrfNumberOfCaches - 1)
    {
        SoundPlay *-1 ; Beep
        CmnShowTooltip(ClpTooltipFifoFull, 2000)
        Return True
    }

    Return False
}

ClpFifoSpaceOrWheel(Direction)
{
    Global
    
    If LxwState = Normal
    {
        ; WinDeactivateAltTabMenu()
        LxwState = ClpFifo
    }
    Else If LxwState = ClpFifo
    {
        CmnSelectNextToPaste("Fifo", Direction)
    }
    
    If LxwState = ClpFifo
    {
        CmnCompareNextToPasteWithClipboard("Fifo", Direction)
        ClpDisplayTooltip("Fifo")
    }
}
