; Lexiwin - Hotkeys for text editing

CapsLock & Space::
    ; Do nothing, just to avoid sending Space
Return

CapsLock & f:: ; CapsLock + f
    ; Do nothing, just to avoid sending f
Return

CapsLock & h:: ; CapsLock + h
    TxeSendKey("Left")
Return

CapsLock & j:: ; CapsLock + j
    TxeSendKey("Down")
Return

CapsLock & k:: ; CapsLock + k
    TxeSendKey("Up")
Return

CapsLock & l:: ; CapsLock + l
    TxeSendKey("Right")
Return

CapsLock & m:: ; CapsLock + m
    TxeSendKey("Home")
Return

CapsLock & ù:: ; CapsLock + ù
    TxeSendKey("End")
Return

CapsLock & $:: ; CapsLock + $
    TxeSendKey("PgUp")
Return

CapsLock & *:: ; CapsLock + *
    TxeSendKey("PgDn")
Return

CapsLock & n:: ; CapsLock + n
    TxeSendKey("Backspace")
Return

CapsLock & ,:: ; CapsLock + ,
    TxeSendKey("Del")
Return

CapsLock & .:: ; CapsLock + ;
    TxeSendKey("Enter")
Return

CapsLock & c::  ; CapsLock + c
    If LxwState = Normal
    {
        CmnCopy("Classic")
    }
Return

CapsLock & x::  ; CapsLock + x
    If LxwState = Normal
    {
       CmnCut("Classic")
    }
Return

CapsLock & v::  ; CapsLock + v
    If LxwState = Normal
    {
        ClpClassicNextToPaste := ClpNextToCache     ; Paste the current clipboard content

        If GetKeyState("Alt", "P") = True
        {
            CmnUnformatPaste("Classic")
        }
        Else
        {
            CmnPaste("Classic")
        }
    }
Return
