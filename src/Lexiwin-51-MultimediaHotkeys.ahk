; Lexiwin - Hotkeys for multimedia

CapsLock & Tab:: ; CapsLock + Tab
    If (GetKeyState("Shift", "P") = True)
    {
        MmdSetVolume("Down")
    }
    Else
    {
        Send {Media_Play_Pause}
    }
Return

CapsLock & ²:: ; CapsLock + ²
    If (GetKeyState("Shift", "P") = True)
    {
        MmdSetVolume("Up")
    }
    Else
    {
        Send {Media_Stop}
    }
Return

CapsLock & <:: ; CapsLock + <
    If (GetKeyState("Shift", "P") = True)
    {
        Send {Media_Prev}
    }
    Else
    {
        Send {Media_Next}
    }
Return

; CapsLock & WheelUp:: See Lexiwin-03-CommonHotkeys.ahk

; CapsLock & WheelDown:: See Lexiwin-03-CommonHotkeys.ahk
