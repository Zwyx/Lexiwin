; Lexiwin - Common hotkeys

CapsLock Up::  ; CapsLock released
    If (PrfCapsLockToggleNeedTwoPresses = "False") Or (LxwCapsLockToggleRequest = "True")
    {
        CmnChangeCapsLockState()
    }
    Else
    {
        LxwCapsLockToggleRequest = True
        SetTimer CmnCancelCapsLockToggleRequest, -750
    }
Return

CapsLock & WheelUp::
    ; Removed due to problem with fast scrolling.
    ; If GetKeyState("Ctrl", "P") = True
    ; {
    ;     MmdSetVolume("Up")
    ; }
    ; Else
    ; {
        QlhDisplayTooltip("Up")
    ; }
Return

CapsLock & WheelDown::
    ; Removed due to problem with fast scrolling.
    ; If GetKeyState("Ctrl", "P") = True
    ; {
    ;     MmdSetVolume("Down")
    ; }
    ; Else
    ; {
        QlhDisplayTooltip("Down")
    ; }
Return

#F1::
#h::
    Run %A_ScriptDir%\Lexiwin-QuickReference(Fr).pdf
Return

#F2::
    If PrfClipboardManagerActivated = True
    {
        PrfClipboardManagerActivated = False
        CmnShowTooltip(ClpTooltipManagerDeactivated, 1000)
    }
    Else
    {
        PrfClipboardManagerActivated = True
        CmnShowTooltip(ClpTooltipManagerActivated, 1000)
    }
Return

#F3::
    If PrfMouseWindowsManagerActivated = True
    {
        PrfMouseWindowsManagerActivated = False
        WinDeactivateMouseAltTabMenu()
        CmnShowTooltip(WinMouseManagerDeactivated, 1000)
    }
    Else
    {
        PrfMouseWindowsManagerActivated = True
        WinActivateMouseAltTabMenu()
        CmnShowTooltip(WinMouseManagerActivated, 1000)
    }
Return

#F4::
    Run %PrfDataPath%\Lexiwin.ini
Return

#F12::
    Tooltip %LxwQuit%
    Sleep 1500
    ExitApp
Return

; Allow drag and drop with RightClick + Shift in Windows Explorer, but do not work very well
; #If PrfMouseWindowsManagerActivated = "True"
;     LShift::
;         WinDeactivateMouseAltTabMenu()
;         Send {LShift Down}
;     Return
;
;     LShift Up::
;         WinActivateMouseAltTabMenu()
;         Send {LShift Up}
;     Return
;
;     RShift::
;         WinDeactivateMouseAltTabMenu()
;         Send {RShift Down}
;     Return
;
;     RShift Up::
;         WinActivateMouseAltTabMenu()
;         Send {RShift Up}
;     Return
; #If

#²::
    LxwEasterEgg = 1
    Gosub CmnEasterEgg
Return
