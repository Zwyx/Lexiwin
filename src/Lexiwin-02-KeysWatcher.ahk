; Lexiwin - KeysWatcher

KeysWatcher:
    If LxwState = ClpClassic
    {
        If ClpClassicAltHasBeenDown = False
        {
            If GetKeyState("Alt") = True  ; If the Alt key is down
            {
                ClpClassicAltHasBeenDown = True
                ClpDisplayTooltip("Classic", "Quick")
            }
        }
        Else
        {
            If GetKeyState("Alt") = False     ; If the Alt key has just been released
            {
                CmnPaste("Classic")
                CmnBackToNormalState()
            }
        }
        
        If GetKeyState("Ctrl") = False    ; If the Ctrl key has just been released
        {
            If ClpClassicAltHasBeenDown = False
            {
                CmnBackToNormalState()
                Send ^{Space}           ; Send Ctrl + Space to the active window
            }
            Else
            {
                CmnUnformatPaste("Classic")
                CmnBackToNormalState()
            }
        }
    }
    Else If LxwState = ClpFifo
    {
        If (GetKeyState("LWin") = False) And (GetKeyState("RWin") = False) ; If the Win key has just been released
        {
            CmnBackToNormalState()
            ; WinActivateAltTabMenu()
        }
    }
    Else If (LxwState = "ClpRegistersStore")
            Or (LxwState = "ClpRegistersDisplay")
    {
        If GetKeyState("CapsLock", "P") = False  ; If the CapsLock key has just been released
        {
            CmnBackToNormalState()
        }
    }
    Else If LxwState = QlhDisplay
    {
        If GetKeyState("CapsLock", "P") = False  ; If the CapsLock key has just been released
        {
            QlhLaunch()
        }
        Else If (GetKeyState("Shift", "P") = True And QlhCurrentList != 2)
                Or (GetKeyState("Shift", "P") = False And QlhCurrentList != 1)
        {
            Gosub CmnHideTooltip
            QlhItem = 1
            QlhDisplayTooltip("NoMove")
        }
    }
Return
