; Lexiwin - Enhanced Windows Features
;
; This is an AutoHotkey_L script
;
; Language:       English
; Platform:       Windows XP
; Author:         github.com/Zwyx
;
; Copyright (C) 2012-2013 github.com/Zwyx
;
; This program is free software; you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation; either version 3 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
; GNU General Public License for more details.

; Execution configuration
#NoEnv                          ; Recommended for performance and compatibility with future AutoHotkey releases
#Warn                           ; Recommended for catching common errors (can be commented before compiling)
SendMode Input                  ; Recommended for new scripts due to its superior speed and reliability
; SendMode Play                   ; See http://www.autohotkey.com/docs/commands/SendMode.htm for limitations
SetWorkingDir %A_ScriptDir%     ; Ensures a consistent starting directory
#SingleInstance Force           ; Authorize only one running instance of this script
#NoTrayIcon                     ; Disables the showing of the tray icon
#UseHook                        ; Equivalent to using the $ prefix in the definition of each affected hotkey
#MaxHotkeysPerInterval 200      ; Prevent a warning dialog to be display while fast scrolling
CoordMode Tooltip, Screen       ; Sets the tooltip coordinate mode
CoordMode Mouse, Screen         ; Sets the mouse coordinate mode (for wheel scrolling)

; To work correctly with the presence of PKL (Portable Keyboard Layout), two solutions:
; 1 - Start Lexiwin after PKL
; 2 - Remove #UseHook and use SendMode Play instead of SendMode Input (but there are limitations)

; Definition of the path for preferences and data
PrfDataPath := A_AppData . "\Lexiwin"   ; For installed version
; PrfDataPath := A_ScriptDir              ; For portable version

; Inclusions
#Include %A_ScriptDir%                                  ; Script directory
#Include Lexiwin-01-Init.ahk                            ; Initialization (auto-execute section)
#Include Lexiwin-02-KeysWatcher.ahk                     ; KeysWatcher
#Include Lexiwin-03-CommonHotkeys.ahk                   ; Common hotkeys
#Include Lexiwin-04-CommonFunctions.ahk                 ; Common functions

#Include Lexiwin-11-ClipboardClassicHotkeys.ahk         ; Hotkeys for the Classic clipboard
#Include Lexiwin-12-ClipboardClassicFunctions.ahk       ; Functions for the Classic clipboard
#Include Lexiwin-13-ClipboardFifoHotkeys.ahk            ; Hotkeys for the FIFO clipboard
#Include Lexiwin-14-ClipboardFifoFunctions.ahk          ; Functions for the FIFO clipboard
#Include Lexiwin-15-ClipboardRegistersHotkeys.ahk       ; Hotkeys for the clipboard registers
#Include Lexiwin-16-ClipboardRegistersFunctions.ahk     ; Functions for the clipboard registers
#Include Lexiwin-17-ClipboardTooltip.ahk                ; Tooltip of clipboards

#Include Lexiwin-21-TextEditHotkeys.ahk                 ; Hotkeys for text editing
#Include Lexiwin-22-TextEditFunctions.ahk               ; Functions for text editing

#Include Lexiwin-31-WindowsHotkeys.ahk                  ; Hotkeys for windows management
#Include Lexiwin-32-WindowsFunctions.ahk                ; Functions for windows management

#Include Lexiwin-41-QuickLaunchHotkeys.ahk              ; Hotkeys for quick launch
#Include Lexiwin-42-QuickLaunchFunctions.ahk            ; Functions for quick launch

#Include Lexiwin-51-MultimediaHotkeys.ahk               ; Hotkeys for multimedia
#Include Lexiwin-52-MultimediaFunctions.ahk             ; Functions for multimedia

; Global prefixes used:
; Lxw = Lexiwin
; Prf = Preferences
; Cmn = Common
; Clp = Clipboard Manager
; Txe = TextEdit
; Win = Windows Manager
; Qlh = Quick launch
; Mmd = Multimedia
