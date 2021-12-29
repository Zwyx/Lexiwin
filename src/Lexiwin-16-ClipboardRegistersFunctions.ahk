; Lexiwin - Functions for the clipboard registers

ClpRegisters(RegisterIndex)
{
    Global
    
    ClpRegistersIndex := PrfNumberOfCaches + RegisterIndex
    
    If LxwState = Normal
    {
        If GetKeyState("Alt", "P") = True
        {
            CmnUnformatPaste("Registers")
        }
        Else
        {
            CmnPaste("Registers")
        }
        CmnBackToNormalState()
    }
    Else If LxwState = ClpRegistersStore
    {
        ClpClipboardSaved := ClipboardAll ; Save original clipboard content
        
        CmnCopy("Registers")
        
        Clipboard := ClpClipboardSaved ; Restore the original clipboard content
        
        CmnBackToNormalState()
    }
    Else If LxwState = ClpRegistersDisplay
    {
        ClpDisplayTooltip("Registers")
    }
}
