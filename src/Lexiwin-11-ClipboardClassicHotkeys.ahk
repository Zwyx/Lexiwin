; Lexiwin - Hotkeys for the Classic clipboard

#If PrfClipboardManagerActivated = "True"
    ^c::   ; Ctrl + c
        If LxwState = Normal
        {
            CmnCopy("Classic")
        }
        Else If LxwState = ClpClassic
        {
            CmnUnformatPaste("Classic")  ; Paste without formating
            CmnBackToNormalState()
        }
    Return

    ^x::   ; Ctrl + x
        If LxwState = Normal
        {
            CmnCut("Classic")
        }
        Else If LxwState = ClpClassic
        {
            CmnBackToNormalState()
        }
    Return

    <^<!x::   ; Left Ctrl + Left Alt + x (because only "^!" is equal to "Ctrl + Alt" and "AltGr")
        If LxwState = Normal
        {
            ; Send {LCtrl}{LAlt}x     ; Does not work... (tested with Notepad++, Ctrl + Alt + D)
            Send ^!x    ; Send Ctrl + Alt + x to the active window
        }
        Else If LxwState = ClpClassic
        {
            CmnBackToNormalState()
        }
    Return

    ^v::   ; Ctrl + v
        If LxwState = Normal
        {
            ClpClassicNextToPaste := ClpNextToCache     ; Paste the current clipboard content
            CmnPaste("Classic")
        }
        Else If LxwState = ClpClassic
        {
            CmnPaste("Classic")
            CmnBackToNormalState()
        }
    Return

    <^<!v::  ; Left Ctrl + Left Alt + v (because only "^!" is equal to "Ctrl + Alt" and "AltGr")
        If LxwState = Normal
        {
            ClpClassicNextToPaste := ClpNextToCache    ; Paste the current clipboard content
            CmnUnformatPaste("Classic")
        }
    Return

    ^Space::   ; Ctrl + Space
        ClpClassicSpaceOrWheel("Next")
    Return

    ^+Space::  ; Ctrl + Shift + Space
        ClpClassicSpaceOrWheel("Previous")
    Return

    ^Up::    ; Ctrl + Up
        If LxwState = Normal
        {
            Send ^{Up}
        }
        Else If LxwState = ClpClassic
        {
            ClpClassicSpaceOrWheel("Next")
        }
    Return

    ^Down::    ; Ctrl + Down
        If LxwState = Normal
        {
            Send ^{Down}
        }
        Else If LxwState = ClpClassic
        {
            ClpClassicSpaceOrWheel("Previous")
        }
    Return

    ^WheelUp:: ; Ctrl + Mouse wheel up
        If LxwState = Normal
        {
            Send ^{WheelUp}
        }
        Else If LxwState = ClpClassic
        {
            ClpClassicSpaceOrWheel("Next")
        }
    Return

    <^<!WheelUp::    ; Left Ctrl + Left Alt + Mouse wheel Up (because only "^!" is equal to "Ctrl + Alt" and "AltGr")
        ClpClassicSpaceOrWheel("Next", "Quick")
    Return

    ^WheelDown::   ; Ctrl + Mouse wheel down
        If LxwState = Normal
        {
            Send ^{WheelDown}
        }
        Else If LxwState = ClpClassic
        {
            ClpClassicSpaceOrWheel("Previous")
        }
    Return

    <^<!WheelDown::  ; Left Ctrl + Left Alt + Mouse wheel Down (because only "^!" is equal to "Ctrl + Alt" and "AltGr")
        ClpClassicSpaceOrWheel("Previous", "Quick")
    Return

    ^s::
        If LxwState = Normal
        {
            Send ^s    ; Send Ctrl + s to the active window
        }
        Else If LxwState = ClpClassic
        {
            CmnBackToNormalState()
            Send ^{Space}           ; Send Ctrl + Space to the active window
        }
    Return
#If
