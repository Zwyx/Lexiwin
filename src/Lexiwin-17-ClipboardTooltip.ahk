; Lexiwin - Tooltip for clipboards

ClpDisplayTooltip(ClipboardType, MenuType = "Complete")
{
    Global

    If (PrfVerbosity = 2)
    {
        If LxwState = ClpFifo
        {
            TlpCaption1 := ClpTooltipFifo
        }
        Else If LxwState = ClpRegistersDisplay
        {
            TlpCaption1 := ClpTooltipRegisters
        }
        Else
        {
            If MenuType = Quick
            {
                TlpCaption1 := ClpTooltipClassicQuick
            }
            Else
            {
                TlpCaption1 := ClpTooltipClassic
            }
        }
    }
    Else
    {
        TlpCaption1 := ""
    }
    
    NextToPaste := CmnGetNextToPaste(ClipboardType)
    
    If (NextToPaste = ClpNextToCache)
    {
        If (PrfVerbosity = 2)
        {
            TlpCaption2 := ClpTooltipClipboardContent
        }
        Else If (PrfVerbosity = 1)
        {
            TlpCaption2 := "[0]`n"
        }
        Else
        {
            TlpCaption2 := ""
        }
        
        ClipboardNow := ClipboardAll
        If ClipboardNow =
        {
            TlpContent := ClpTooltipEmpty
        }
        Else
        {
            If Clipboard =
            {
                TlpContent := ClpTooltipNoPlainText
            }
            Else
            {
                TlpContent := Clipboard
            }
        }
    }
    Else
    {
        If LxwState = ClpRegistersDisplay
        {
            Index := ClpRegistersIndex - PrfNumberOfCaches
        }
        Else
        {
            Index := CmnGetPasteIndex(NextToPaste)
        }
        
        If (PrfVerbosity = 2)
        {
            If LxwState = ClpRegistersDisplay
            {
                TlpCaption2 := ClpTooltipRegisterContent1 . Index . ClpTooltipRegisterContent2
            }
            Else
            {
                TlpCaption2 := ClpTooltipCacheContent1 . Index . ClpTooltipCacheContent2
            }                
        }
        Else If (PrfVerbosity = 1)
        {
            TlpCaption2 := "[" . Index . "]`n"
        }
        Else
        {
            TlpCaption2 := ""
        }

        If ClpCacheAll%NextToPaste% =
        {
            TlpContent := ClpTooltipEmpty
        }
        Else
        {
            If ClpCacheUnformat%NextToPaste% =
            {
                TlpContent := ClpTooltipNoPlainText
            }
            Else
            {
                TlpContent := ClpCacheUnformat%NextToPaste%
            }
        }
    }
    
    CmnShowTooltip(TlpCaption1 . TlpCaption2 . TlpContent, 0)
}
