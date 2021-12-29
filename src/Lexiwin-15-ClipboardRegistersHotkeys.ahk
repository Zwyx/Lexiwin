; Lexiwin - Hotkeys for the clipboard registers

#If PrfClipboardManagerActivated = "True"
    CapsLock & S::  ; CapsLock + S
        LxwState = ClpRegistersStore
        CmnShowTooltip(ClpTooltipRegistersStore)
    Return

    CapsLock & D::  ; CapsLock + D
        LxwState = ClpRegistersDisplay
        CmnShowTooltip(ClpTooltipRegistersDisplay)
    Return

    CapsLock & A::  ; CapsLock + A
        ClpRegisters(1)
    Return

    CapsLock & Z::  ; CapsLock + Z
        ClpRegisters(2)
    Return

    CapsLock & E::  ; CapsLock + E
        ClpRegisters(3)
    Return

    CapsLock & R::  ; CapsLock + R
        ClpRegisters(4)
    Return

    CapsLock & T::  ; CapsLock + T
        ClpRegisters(5)
    Return

    CapsLock & Y::  ; CapsLock + Y
        ClpRegisters(6)
    Return

    CapsLock & U::  ; CapsLock + U
        ClpRegisters(7)
    Return

    CapsLock & I::  ; CapsLock + I
        ClpRegisters(8)
    Return

    CapsLock & O::  ; CapsLock + O
        ClpRegisters(9)
    Return

    CapsLock & P::  ; CapsLock + P
        ClpRegisters(10)
    Return
#If
