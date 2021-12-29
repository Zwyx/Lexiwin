; Lexiwin - Functions for windows management

; WinActivateAltTabMenu()
; {
;     Hotkey <#WheelUp, ShiftAltTab, On
;     Hotkey <#WheelDown, AltTab, On
; }

; WinDeactivateAltTabMenu()
; {
;     Hotkey <#WheelUp, Off
;     Hotkey <#WheelDown, Off
; }

WinActivateMouseAltTabMenu()
{
    Hotkey RButton & WheelUp, ShiftAltTab, On
    Hotkey RButton & WheelDown, AltTab, On
}

WinDeactivateMouseAltTabMenu()
{
    Hotkey RButton & WheelUp, ShiftAltTab, Off
    Hotkey RButton & WheelDown, AltTab, Off
}

WinCloseWindowUnderMouse()
{
    MouseGetPos , , , locWindowId
    WinClose ahk_id %locWindowId%
}

WinMaximizeOrRestoreWindowUnderMouse()
{
    MouseGetPos , , , locWindowId
    WinGet locWindowState, MinMax, ahk_id %locWindowId%
    If locWindowState = 1
    {
        WinRestore ahk_id %locWindowId%
    }
    Else
    {
        WinMaximize ahk_id %locWindowId%
    }
}

WinMinimizeWindowUnderMouse()
{
    MouseGetPos , , , locWindowId
    WinMinimize ahk_id %locWindowId%
}

WinSwitchWindow(WindowToSwitch)
{
    SysGet locNumberOfMonitors, MonitorCount

    If (locNumberOfMonitors > 1)
    {
        WinGet locWindowState, MinMax, %WindowToSwitch%

        If locWindowState = 1
        {
            WinRestore %WindowToSwitch%
        }

        WinGetPos locX, locY, locWidth, locHeight, %WindowToSwitch%

        locIndex = 1
        locCurrentMonitor = 0
        While (locCurrentMonitor = 0)
        {
            SysGet locMonitor, Monitor, %locIndex%
            ; MsgBox Left: %locMonitorLeft% - Top: %locMonitorTop% - Right: %locMonitorRight% - Bottom %locMonitorBottom%

            If (locX >= locMonitorLeft) And (locX < locMonitorRight)
                    And (locY >= locMonitorTop) And (locY < locMonitorBottom)
            {
                locCurrentMonitor := locIndex
            }
            Else
            {
                If (locIndex >= locNumberOfMonitors)
                {
                    locCurrentMonitor = 1
                }
                Else
                {
                    locIndex ++
                }
            }
        }

        locOffsetX := locX - locMonitorLeft
        locOffsetY := locY - locMonitorTop

        If (locIndex >= locNumberOfMonitors)
        {
            locIndex = 1
        }
        Else
        {
            locIndex ++
        }

        SysGet locMonitor, Monitor, %locIndex%

        If (locMonitorLeft + locOffsetX >= locMonitorLeft) And (locMonitorLeft + locOffsetX < locMonitorRight)
                And (locMonitorTop + locOffsetY >= locMonitorTop) And (locMonitorTop + locOffsetY < locMonitorBottom)
        {
            locNewX := locMonitorLeft + locOffsetX
            locNewY := locMonitorTop + locOffsetY
        }
        Else
        {
            locNewX := locMonitorLeft + (locMonitorRight - locMonitorLeft - locWidth) / 2
            locNewY := locMonitorTop + (locMonitorBottom - locMonitorTop - locHeight) / 2
        }

        WinMove %WindowToSwitch%, , locNewX, locNewY

        If locWindowState = 1
        {
            WinMaximize %WindowToSwitch%
        }
    }
}

WinSaveWindowPosition(PositionNumber)
{
    Global PrfDataPath

    WinGet locWindowState, MinMax, A

    If locWindowState = 1
    {
        WinRestore A
        locWindowState = True
    }
    Else
    {
        locWindowState = False
    }

    WinGetPos locX, locY, locWidth, locHeight, A

    IniWrite % locX . ";" . locY . ";" . locWidth . ";" . locHeight . ";" . locWindowState, %PrfDataPath%\Lexiwin.ini, WindowsManager, WinPos%PositionNumber%
    
    If locWindowState = True
    {
        WinMaximize A
    }
}

WinRestoreWindowPosition(PositionNumber)
{
    Global PrfDataPath

    IniRead locWindowPosition, %PrfDataPath%\Lexiwin.ini, WindowsManager, WinPos%PositionNumber%, Unavailable

    If locWindowPosition != Unavailable
    {
        WinGet locWindowState, MinMax, A

        If locWindowState = 1
        {
            WinRestore A
        }

        StringSplit locWindowPosition, locWindowPosition, ";", %A_Space%%A_Tab%
        WinMove A, , %locWindowPosition1%, %locWindowPosition2%, %locWindowPosition3%, %locWindowPosition4%

        If locWindowPosition5 = True
        {
            WinMaximize A
        }
    }
}

WinScrollWindowUnderMouse(Direction, Speed)
{
    ; WM_MOUSEWHEEL = 0x020A, WHEEL_DELTA = 120
    
    MouseGetPos MousePosX, MousePosY
    locWindowId := DllCall("WindowFromPoint", "int", MousePosX, "int", MousePosY)

    locWheelDelta := 120 * Speed
    If Direction = Down
    {
        locWheelDelta := -locWheelDelta
    }
    
    SendMessage 0x020A, locWheelDelta << 16, (MousePosY << 16) | MousePosX, , ahk_id %locWindowId%
}

; WinHorizontalScroll(Direction)
; {
;     ; WM_HSCROLL = 0x0114, SB_LINERIGHT = 1, SB_LINELEFT = 0
; 
;     If Direction = Right
;     {
;         locScroll = 1
;     }
;     Else
;     {
;         locScroll = 0
;     }
; 
;     ControlGetFocus locControl, A
; 
;     Loop 3  ; To scroll faster
;     {
;         SendMessage 0x0114, locScroll, 0, %locControl%, A 
;     }
; }

WinBrowseWindowUnderMouse(Direction)
{
    ; WM_APPCOMMAND = 0x0319, APPCOMMAND_BROWSER_BACKWARD = 1, APPCOMMAND_BROWSER_FORWARD = 2
    
    MouseGetPos MousePosX, MousePosY
    locWindowId := DllCall("WindowFromPoint", "int", MousePosX, "int", MousePosY)

    If Direction = Backward
    {
        SendMessage 0x0319, 0, 1 << 16, , ahk_id %locWindowId%
    }
    Else
    {
        SendMessage 0x0319, 0, 2 << 16, , ahk_id %locWindowId%
    }
}
