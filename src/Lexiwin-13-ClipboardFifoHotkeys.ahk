; Lexiwin - Hotkeys for the FIFO clipboard

#If PrfClipboardManagerActivated = "True"
    #c::   ; Win + c
        If LxwState = Normal
        {
            If ClpIsFifoFull() = False
            {
                CmnCopy("Fifo")
            }
        }
        Else If LxwState = ClpFifo
        {
            CmnUnformatPaste("Fifo")   ; Paste without formating
            CmnBackToNormalState()
        }
    Return

    #x::   ; Win + x
        If LxwState = Normal
        {
            If ClpIsFifoFull() = False
            {
                CmnCut("Fifo")
            }
        }
    Return

    #v::   ; Win + v
        CmnPaste("Fifo")
        
        If (ClpFifoNextToPaste != ClpNextToCache)
        {
            CmnSelectNextToPaste("Fifo", "Previous")
        }
        
        If LxwState = ClpFifo
        {
            CmnBackToNormalState()
        }
    Return

    #!v::   ; Win + Alt + v
        CmnUnformatPaste("Fifo")
        
        If (ClpFifoNextToPaste != ClpNextToCache)
        {
            CmnSelectNextToPaste("Fifo", "Previous")
        }
        
        If LxwState = ClpFifo
        {
            CmnBackToNormalState()
        }
    Return

    #n::
        ClpFifoNextToPaste := ClpNextToCache    ; Reset the FIFO

        If LxwState = ClpFifo
        {
            CmnBackToNormalState()
        }

        CmnShowTooltip(ClpTooltipFifoReset, 1000)
    Return

    #Space::   ; Win + Space
        ClpFifoSpaceOrWheel("Next")
    Return

    #+Space::  ; Win + Shift + Space
        ClpFifoSpaceOrWheel("Previous")
    Return

    #Up::    ; Win + Up
        ClpFifoSpaceOrWheel("Next")
    Return

    #Down::    ; Win + Down
        ClpFifoSpaceOrWheel("Previous")
    Return

    #WheelUp:: ; Win + Mouse wheel up
        ClpFifoSpaceOrWheel("Next")
    Return

    #WheelDown::   ; Win + Mouse wheel down
        ClpFifoSpaceOrWheel("Previous")
    Return
#If
