; Lexiwin - Functions for text editing

TxeSendKey(KeyName)
{
    If GetKeyState("Ctrl", "P") = True Or GetKeyState("Space", "P") = True
    {
        If GetKeyState("Shift", "P") = True Or GetKeyState("f", "P") = True
        {
            Send ^+{%KeyName%}
        }
        Else
        {
            Send ^{%KeyName%}
        }
    }
    Else
    {
        If GetKeyState("Shift", "P") = True Or GetKeyState("f", "P") = True
        {
            Send +{%KeyName%}
        }
        Else
        {
            Send {%KeyName%}
        }
    }
}
