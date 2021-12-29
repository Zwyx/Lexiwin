; Lexiwin - Hotkeys for windows management

#w::   ; Win + w
    WinClose A ; Close the active window
Return

#<:: ; Windows + <
    WinMinimize A ; Minimize the active window
Return

#q:: ; Windows + q
    WinGet WindowState, MinMax, A
    If WindowState = 1
    {
        WinRestore A
    }
    Else
    {
        WinMaximize A
    }
Return

#s:: ; Windows + s
    WinSwitchWindow("A") ; A = Active Window
Return

#&:: ; Windows + 1
    WinRestoreWindowPosition(1)
Return

#+&:: ; Windows + Shift + 1
    WinSaveWindowPosition(1)
Return

#é:: ; Windows + 2
    WinRestoreWindowPosition(2)
Return

#+é:: ; Windows + Shift + 2
    WinSaveWindowPosition(2)
Return

#":: ; Windows + 3
    WinRestoreWindowPosition(3)
Return

#+":: ; Windows + Shift + 3
    WinSaveWindowPosition(3)
Return

#':: ; Windows + 4
    WinRestoreWindowPosition(4)
Return

#+':: ; Windows + Shift + 4
    WinSaveWindowPosition(4)
Return

#(:: ; Windows + 5
    WinRestoreWindowPosition(5)
Return

#+(:: ; Windows + Shift + 5
    WinSaveWindowPosition(5)
Return

#-:: ; Windows + 6
    WinRestoreWindowPosition(6)
Return

#+-:: ; Windows + Shift + 6
    WinSaveWindowPosition(6)
Return

#è:: ; Windows + 7
    WinRestoreWindowPosition(7)
Return

#+è:: ; Windows + Shift + 7
    WinSaveWindowPosition(7)
Return

#_:: ; Windows + 8
    WinRestoreWindowPosition(8)
Return

#+_:: ; Windows + Shift + 8
    WinSaveWindowPosition(8)
Return

#ç:: ; Windows + 9
    WinRestoreWindowPosition(9)
Return

#+ç:: ; Windows + Shift + 9
    WinSaveWindowPosition(9)
Return

#à:: ; Windows + 0
    WinRestoreWindowPosition(10)
Return

#+à:: ; Windows + Shift + 0
    WinSaveWindowPosition(10)
Return

; Removed because these shortcuts are no longer needed thanks to the mouse part of the Windows manager
; #LButton:: ; Windows + Mouse left button
;     WinCloseWindowUnderMouse()
; Return
; 
; #MButton:: ; Windows + Mouse middle button
;     WinMaximizeOrRestoreWindowUnderMouse()
; Return
; 
; #RButton:: ; Windows + Mouse right button
;     WinMinimizeWindowUnderMouse()
; Return

#If PrfMouseWindowsManagerActivated = "True"
    LButton::
        Critical

        If GetKeyState("RButton", "P") = True  ; If RButton is pressed
        {
            LxwState = WinRButtonLButton
        }
        Else
        {
            Send {LButton Down}
        }
    Return

    LButton Up::
        Critical ; Avoid LButton Up and RButton Up to be executed simultaneously

        If LxwState = WinRButtonLButton
        {
            WinCloseWindowUnderMouse()
            LxwState = WinXButtonUp
        }
        Else If LxwState = WinXButtonUp
        {
            If GetKeyState("RButton", "P") = True  ; If RButton is pressed
            {
                WinCloseWindowUnderMouse()
            }
            Else
            {
                CmnBackToNormalState()
            }
        }
        Else
        {
            ; If we just do Send {LButton Up}, combinations like Ctrl and/or Shift and left click will not work
            ; (tested with Microsoft Word 2003, by trying to move/copy an object)
            If GetKeyState("Ctrl", "P") = True
            {
                If GetKeyState("Shift", "P") = True
                {                
                    Send ^+{LButton Up}
                }
                Else
                {
                    Send ^{LButton Up}
                }
            }
            Else
            {
                If GetKeyState("Shift", "P") = True
                {                
                    Send +{LButton Up}
                }
                Else
                {
                    Send {LButton Up}
                }
            }
        }
    Return

    RButton Up::
        Critical ; Avoid LButton Up and RButton Up to be executed simultaneously

        If LxwState = WinRButtonLButton
        {
            WinMinimizeWindowUnderMouse()
            LxwState = WinXButtonUp
        }
        Else If GetKeyState("MButton", "P") = True
        {
            MouseGetPos , , , WindowId
            WinSwitchWindow("ahk_id " . WindowId)
            LxwState = WinXButtonUp
        }
        Else If LxwState = WinXButtonUp
        {
           If GetKeyState("LButton", "P") = True  ; If LButton is pressed
           {
               WinMinimizeWindowUnderMouse()
           }
           Else
           {
               CmnBackToNormalState()
           }
        }
        Else
        {
            Send {RButton}
        }
    Return

    MButton Up::
        Critical

        If GetKeyState("RButton", "P") = True
        {
            WinMaximizeOrRestoreWindowUnderMouse()
            LxwState = WinXButtonUp
        }
        Else If LxwState = WinXButtonUp
        {
            CmnBackToNormalState()
        }
        Else
        {
            Send {MButton}
        }
    Return

    WheelUp::
        Critical

        WinScrollWindowUnderMouse("Up", A_EventInfo)
    Return

    WheelDown::
        Critical

        WinScrollWindowUnderMouse("Down", A_EventInfo)
    Return

    ; Do not work very well
    ; +WheelUp::
    ;     WinScrollWindowUnderMouse("Up", A_EventInfo * 5)
    ; Return

    ; Do not work very well
    ; +WheelDown::
    ;     WinScrollWindowUnderMouse("Down", A_EventInfo * 5)
    ; Return

    ; Warning: can avoid some features in some software
    ; !WheelUp::
    ;     Critical
    ; 
    ;     WinHorizontalScroll("Left")
    ; Return

    ; Warning: can avoid some features in some software
    ; !WheelDown::
    ;     Critical
    ; 
    ;     WinHorizontalScroll("Right")
    ; Return

    MButton & WheelUp::
        Critical

        ; Send {Browser_Back}
        WinBrowseWindowUnderMouse("Backward")
    Return

    MButton & WheelDown::
        Critical

        ; Send {Browser_Forward}
        WinBrowseWindowUnderMouse("Forward")
    Return
#If
