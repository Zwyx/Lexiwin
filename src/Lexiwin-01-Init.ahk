; Lexiwin - Initialization (auto-execute section)

; Load general preferences
IniRead PrfLanguage, %PrfDataPath%\Lexiwin.ini, General, Language, English ; Retrieve the Language preference
IniRead PrfVerbosity, %PrfDataPath%\Lexiwin.ini, General, VerbosityLevel, 2 ; Retrieve the Verbose preference
IniRead PrfPreventLeftWinKeyToOpenStartMenu, %PrfDataPath%\Lexiwin.ini, General, PreventLeftWinKeyToOpenStartMenu, True ; Prevent the left Windows key to open the Start menu
IniRead PrfCapsLockToggleNeedTwoPresses, %PrfDataPath%\Lexiwin.ini, General, CapsLockToggleNeedTwoPresses, True ; Two presses onCapsLock to toggle it
IniRead PrfTooltipOnCoordinates, %PrfDataPath%\Lexiwin.ini, General, TooltipOnCoordinates, False ; Display tooltip on coordinates
IniRead PrfTooltipXCoordinate, %PrfDataPath%\Lexiwin.ini, General, TooltipXCoordinate, 50 ; Tooltip X position
IniRead PrfTooltipYCoordinate, %PrfDataPath%\Lexiwin.ini, General, TooltipYCoordinate, 50 ; Tooltip Y position

; Load clipboard manager preferences
IniRead PrfClipboardManagerActivated, %PrfDataPath%\Lexiwin.ini, ClipboardManager, ClipboardManagerActivated, True ; Activate, or not, the clipboard manager
IniRead PrfNumberOfCaches, %PrfDataPath%\Lexiwin.ini, ClipboardManager, NumberOfCaches, 25 ; Retrieve the number of clipboard caches desired

; Load windows manager preferences
IniRead PrfMouseWindowsManagerActivated, %PrfDataPath%\Lexiwin.ini, WindowsManager, MouseWindowsManagerActivated, True ; Activate, or not, the mouse part of the windows manager

; Configure displayed text
If PrfLanguage = French
{
    ClpTooltipManagerActivated := "Gestion des presse-papiers activée"
    ClpTooltipManagerDeactivated := "Gestion des presse-papiers désactivée"
    ClpTooltipClassic := "[Lexiwin]`n  - V : Coller`n  - C : Coller sans mise en forme`n  - X : Annuler`n  - S ou relâcher Ctrl : Envoyer Ctrl + Espace à l'application active`n"
    ClpTooltipClassicQuick := "[Lexiwin]`n  - Relâcher Alt : Coller`n  - Relâcher Ctrl : Coller sans mise en forme`n  - X : Annuler`n"
    ClpTooltipFifo := "[Lexiwin]`n  - V : Coller`n  - C : Coller sans mise en forme`n  - N : Réinitialiser la FIFO`n  - Relâcher Win : Annuler`n"
    ClpTooltipRegisters := "[Lexiwin]`n"
    ClpTooltipClipboardContent := "`nContenu du presse-papiers :`n"
    ClpTooltipCacheContent1 := "`nContenu n° "
    ClpTooltipCacheContent2 := " :`n"
    ClpTooltipRegisterContent1 := "Contenu du registre n° "
    ClpTooltipRegisterContent2 := " :`n"
    ClpTooltipEmpty := "[Vide]"
    ClpTooltipNoPlainText := "[Non convertible en texte brut]"
    ClpTooltipFifoReset := "[Lexiwin]`nFIFO réinitialisée"
    ClpTooltipFifoFull := "[Lexiwin]`nOpération non-réalisée ! La FIFO est pleine !"
    ClpTooltipRegistersStore := "[Lexiwin]`nEnregistrer dans un registre -> A, Z, E, R, T, Y, U, I, O, ou P."
    ClpTooltipRegistersDisplay := "[Lexiwin]`nAfficher le contenu d'un registre -> A, Z, E, R, T, Y, U, I, O, ou P."

    WinMouseManagerActivated := "Gestion des fenêtres avec la souris activée"
    WinMouseManagerDeactivated := "Gestion des fenêtres avec la souris désactivée"

    QlhTooltipHeader := "[Lexiwin]`n"
    MmdVolume := "Volume : "
    LxwQuit := "Lexiwin va s'arrêter..."
}
Else ; English by default
{
    ClpTooltipManagerActivated := "Clipboard manager activated"
    ClpTooltipManagerDeactivated := "Clipboard manager deactivated"
    ClpTooltipClassic := "[Lexiwin]`n  - V: Paste`n  - C: Paste without formating`n  - X: Cancel`n  - S or release Ctrl: Send Ctrl + Space to the active application`n"
    ClpTooltipClassicQuick := "[Lexiwin]`n  - Release Alt: Paste`n  - Release Ctrl: Paste without formating`n  - X: Cancel`n"
    ClpTooltipFifo := "[Lexiwin]`n  - V: Paste`n  - C: Paste without formating`n  - N: Reset FIFO`n  - Release Win: Cancel`n"
    ClpTooltipRegisters := "[Lexiwin]`n"
    ClpTooltipClipboardContent := "`nClipboard content:`n"
    ClpTooltipCacheContent1 := "`nContent "
    ClpTooltipCacheContent2 := ":`n"
    ClpTooltipRegisterContent1 := "Content of register "
    ClpTooltipRegisterContent2 := ":`n"
    ClpTooltipEmpty := "[Empty]"
    ClpTooltipNoPlainText := "[Non-convertible to plain text]"
    ClpTooltipFifoReset := "[Lexiwin]`nFIFO reset"
    ClpTooltipFifoFull := "[Lexiwin]`nNothing done! The FIFO is full!"
    ClpTooltipRegistersStore := "[Lexiwin]`nStore in a register -> A, Z, E, R, T, Y, U, I, O, or P."
    ClpTooltipRegistersDisplay := "[Lexiwin]`nDisplay the content of a register -> A, Z, E, R, T, Y, U, I, O, or P."

    WinMouseManagerActivated := "Mouse windows management activated"
    WinMouseManagerDeactivated := "Mouse windows management deactivated"

    QlhTooltipHeader := "[Lexiwin]`n"
    MmdVolume := "Volume: "
    LxwQuit := "Lexiwin is going to stop..."
}

; Check verbosity level
If (PrfVerbosity < 0)
{
    PrfVerbosity = 0
}
Else If (PrfVerbosity > 2)
{
    PrfVerbosity = 2
}

; Check number of caches
If (PrfNumberOfCaches < 1)
{
    PrfNumberOfCaches = 1
}
Else If (PrfNumberOfCaches > 50)
{
    PrfNumberOfCaches = 50
}
PrfNumberOfCaches ++    ; There is one cache more, representing the current clipboard

ClpClipboardSaved := ClipboardAll ; Save original clipboard content
Loop % PrfNumberOfCaches + 10 ; 10 = Number of registers
{
    if (A_Index > PrfNumberOfCaches)
            And FileExist(PrfDataPath . "\ClpReg" . (A_Index - PrfNumberOfCaches) . ".lxw")
    {
        Index := A_Index - PrfNumberOfCaches
        FileRead Clipboard, *c %PrfDataPath%\ClpReg%Index%.lxw
        ClpCacheAll%A_Index% := ClipboardAll
        ClpCacheUnformat%A_Index% := Clipboard
    }
    else
    {
        ClpCacheAll%A_Index% =
        ClpCacheUnformat%A_Index% =
    }
}
Clipboard := ClpClipboardSaved ; Restore the original clipboard content

; Configure left Windows key
If PrfPreventLeftWinKeyToOpenStartMenu = True
{
    Hotkey ~LWin Up, CmnLeftWinUp
}

; Global variable initialization
LxwState = Normal
LxwCapsLockToggleRequest = False
ClpClassicAltHasBeenDown = False    ; Used by KeysWatcher during Classic state
ClpNextToCache = 1                  ; ClpNextToCache always represents the current clipboard
ClpFifoNextToPaste := ClpNextToCache

; Configure CapsLock key
If GetKeyState("CapsLock", "T") = True
{
    SetCapsLockState AlwaysOn
}
Else
{
    SetCapsLockState AlwaysOff
}

; Activate mouse hotkeys for the AltTab menu
If PrfMouseWindowsManagerActivated = True
{
    WinActivateMouseAltTabMenu()
}

; Activate Win + Left/Right for the AltTab menu
; Because of a bug (Win stays down after Win + L), this features has been completely removed
; Hotkey LWin & Left, ShiftAltTab, On
; Hotkey LWin & Right, AltTab, On
; Hotkey RWin & Left, ShiftAltTab, On
; Hotkey RWin & Right, AltTab, On

; Activate Win + Wheel hotkeys for the AltTab menu
; Because of a bug (Win stays down after Win + L), this features has been completely removed
; Hotkey >#WheelUp, ShiftAltTab, On
; Hotkey >#WheelDown, AltTab, On
; WinActivateAltTabMenu()

; Set the KeyWatcher timer
SetTimer KeysWatcher, 50
