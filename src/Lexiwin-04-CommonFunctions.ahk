; Lexiwin - Common functions

CmnCopy(ClipboardType)
{
    Global
    
    Clipboard =             ; Empty the clipboard
    Send ^c                 ; Send Ctrl + C
    ClipWait 0.5, 1         ; Wait until content is arrived (or timeout is reached)
    If (ErrorLevel = 0)     ; If the timeout has not been reached
    {
        CmnCacheContentAndIncrementCache(ClipboardType)
    }
}

CmnCut(ClipboardType)
{
    Global
    
    ; Used to prevent bug with Microsoft Word
    WinGetActiveTitle ActiveWindowTitle ; Retrieve active window title, which ends with " - Microsoft Word" for Word
    ; WinGetClass ActiveWindowClass, A ; Retrieve active window class name, which is "OpusApp" for Word
    WinGet ActiveWindowProcess, ProcessName, A ; Retrieve active window process name, which is "winword.exe" for Word
    
    Clipboard =             ; Empty the clipboard
    If InStr(ActiveWindowTitle, " - Microsoft Word") and (ActiveWindowProcess = "winword.exe")
    {
        Send ^c                 ; Send Ctrl + C
    }
    Else
    {
        Send ^x                 ; Send Ctrl + X
    }
    
    ClipWait 0.5, 1         ; Wait until content is arrived (or timeout is reached)
    If (ErrorLevel = 0)     ; If the timeout has not been reached
    {
        CmnCacheContentAndIncrementCache(ClipboardType)
    }
    
    If InStr(ActiveWindowTitle, " - Microsoft Word") and (ActiveWindowProcess = "winword.exe")
    {
        Send {Del}
    }
}

CmnCacheContentAndIncrementCache(ClipboardType)
{
    Global

    If ClipboardType = Registers
    {
        ClpCacheAll%ClpRegistersIndex% := ClipboardAll      ; Retrieve clipboard content
        ClpCacheUnformat%ClpRegistersIndex% := Clipboard    ; Retrieve unformatted clipboard content
        Index := ClpRegistersIndex - PrfNumberOfCaches
        FileAppend %ClipboardAll%, %PrfDataPath%\ClpReg%Index%.lxw ; Save register content in file
    }
    Else
    {
        ClpCacheAll%ClpNextToCache% := ClipboardAll     ; Retrieve clipboard content
        ClpCacheUnformat%ClpNextToCache% := Clipboard   ; Retrieve unformatted clipboard content
        
        FifoCurrently = True
        If ClipboardType = Classic
        {
            If (ClpFifoNextToPaste = ClpNextToCache)
            {
                FifoCurrently = False
            }
        }
        
        If (ClpNextToCache >= PrfNumberOfCaches)        ; If the maximum number of caches has been reached
        {
            ClpNextToCache = 1
        }
        Else
        {
            ClpNextToCache ++
        }
        
        If FifoCurrently = False
        {
            ClpFifoNextToPaste := ClpNextToCache
        }
    }
}

CmnPaste(ClipboardType)
{
    Global
    
    NextToPaste := CmnGetNextToPaste(ClipboardType)
    
    If (NextToPaste = ClpNextToCache)
    {
        Send ^v
    }
    Else
    {
        ClpClipboardSaved := ClipboardAll       ; Save original clipboard content
        Clipboard := ClpCacheAll%NextToPaste%   ; Put the cached content in the clipboard
        Send ^v                                 ; Send Ctrl + V to paste the clipboard content
        Sleep 100                               ; Wait a little to ensure pasting is terminated
        Clipboard := ClpClipboardSaved          ; Restore the original clipboard content
    }
}

CmnUnformatPaste(ClipboardType)
{
    Global
    
    NextToPaste := CmnGetNextToPaste(ClipboardType)
    
    ClpClipboardSaved := ClipboardAll               ; Save original clipboard content
    If (NextToPaste = ClpNextToCache)               ; If the current clipboard content has been selected
    {
        Clipboard := Clipboard                      ; Remove formatting of the clipboard content
    }
    Else
    {
        Clipboard := ClpCacheUnformat%NextToPaste%  ; Put the unformated cached content in the clipboard
    }
    Send ^v                         ; Send Ctrl + V to paste the clipboard content
    Sleep 100                       ; Wait a little to ensure pasting is terminated
    Clipboard := ClpClipboardSaved  ; Restore the original clipboard content
}

CmnGetNextToPaste(ClipboardType)
{
    Global
    
    If ClipboardType = Fifo
    {
        Return ClpFifoNextToPaste
    }
    Else If ClipboardType = Registers
    {
        Return ClpRegistersIndex
    }
    Else
    {
        Return ClpClassicNextToPaste
    }
}

CmnSetNextToPaste(ClipboardType, NextToPaste)
{
    Global
    
    If ClipboardType = Fifo
    {
        ClpFifoNextToPaste := NextToPaste
    }
    Else
    {
        ClpClassicNextToPaste := NextToPaste
    }
}

CmnGetPasteIndex(NextToPaste)
{
    Global
    
    If (NextToPaste <= ClpNextToCache)
    {
        Return ClpNextToCache - NextToPaste
    }
    Else
    {
        Return PrfNumberOfCaches - NextToPaste + ClpNextToCache
    }
}

CmnSelectNextToPaste(ClipboardType, Direction)
{
    Global
    
    NextToPaste := CmnGetNextToPaste(ClipboardType)
    
    If Direction = Next
        If (NextToPaste <= 1)
        {
            NextToPaste := PrfNumberOfCaches
        }
        Else
        {
            NextToPaste --
        }
    Else
    {
        If (NextToPaste >= PrfNumberOfCaches)
        {
            NextToPaste = 1
        }
        Else
        {
            NextToPaste ++
        }
    }
    
    CmnSetNextToPaste(ClipboardType, NextToPaste)
}

CmnCompareNextToPasteWithClipboard(ClipboardType, Direction)
{
    Global

    NextToPaste := CmnGetNextToPaste(ClipboardType)

    If (NextToPaste = ClpNextToCache)
    {
        If (NextToPaste <= 1)
        {
            Index := PrfNumberOfCaches
        }
        Else
        {
            Index := NextToPaste - 1
        }
        ClipboardNow := ClipboardAll
        ; For debug:
        ;FileAppend % ClpCacheAll%Index%, %PrfDataPath%\zcached.lxw
        ;FileAppend %ClipboardAll%, %PrfDataPath%\zcurrent.lxw
        ;If ClpCacheAll%Index% = %ClipboardNow%  ; This must be an old-style IF statement, not an expression
                                                ; (see http://www.autohotkey.com/docs/misc/Clipboard.htm)
        If (ClpCacheAll%Index% = ClipboardNow)
        {
            If Direction = Next
            {
                NextToPaste := Index
            }
            Else
            {
                If (NextToPaste >= PrfNumberOfCaches)
                {
                    NextToPaste = 1
                }
                Else
                {
                    NextToPaste ++
                }
            }
            CmnSetNextToPaste(ClipboardType, NextToPaste)
        }
    }
}

CmnBackToNormalState()
{
    Global
    
    Gosub CmnHideTooltip                ; Hide the tooltip
    LxwState = Normal                   ; Go back in Normal mode
    ClpClassicAltHasBeenDown = False    ; Used by KeysWatcher during Classic state
}

CmnCancelCapsLockToggleRequest:
    LxwCapsLockToggleRequest = False
Return

CmnChangeCapsLockState()
{
    If GetKeyState("CapsLock", "T") = True
    {
        SetCapsLockState AlwaysOff
    }
    Else
    {
        SetCapsLockState AlwaysOn
    }
}

CmnLeftWinUp:
    ; Do nothing, just avoid the start menu to appear
Return

CmnShowTooltip(Content, Time = 0)
{
    Global

    SetTimer CmnHideTooltip, Off ; Kill an eventually existing timer

    If PrfTooltipOnCoordinates = True
    {
        ToolTip %Content%, PrfTooltipXCoordinate, PrfTooltipYCoordinate
    }
    Else
    {
        ToolTip %Content%
    }

    If (Time != 0)
    {
        SetTimer CmnHideTooltip, -%Time%
    }
}

CmnHideTooltip:
    ToolTip
Return

CmnEasterEgg:
    Spaces55 := "                                                       "
    If LxwEasterEgg = 1
    {
        CmnShowTooltip("L`n`n" . Spaces55)
    }
    Else If LxwEasterEgg = 2
    {
        CmnShowTooltip("Le`n`n" . Spaces55)
    }
    Else If LxwEasterEgg = 3
    {
        CmnShowTooltip("Lex`n`n" . Spaces55)
    }
    Else If LxwEasterEgg = 4
    {
        CmnShowTooltip("Lexi`n`n" . Spaces55)
    }
    Else If LxwEasterEgg = 5
    {
        CmnShowTooltip("Lexiw`n`n" . Spaces55)
    }
    Else If LxwEasterEgg = 6
    {
        CmnShowTooltip("Lexiwi`n`n" . Spaces55)
    }
    Else If LxwEasterEgg = 7
    {
        CmnShowTooltip("Lexiwin`n`n" . Spaces55)
    }
    Else If LxwEasterEgg = 12
    {
        CmnShowTooltip("Lexiwin`nEnhanced`n" . Spaces55)
    }
    Else If LxwEasterEgg = 17
    {
        CmnShowTooltip("Lexiwin`nEnhanced Windows`n" . Spaces55)
    }
    Else If LxwEasterEgg = 22
    {
        CmnShowTooltip("Lexiwin`nEnhanced Windows Features :-)`n" . Spaces55)
    }

    If LxwEasterEgg < 30
    {
        LxwEasterEgg ++
        SetTimer CmnEasterEgg, -150
    }
    Else
    {
        Gosub CmnHideTooltip
    }
Return
