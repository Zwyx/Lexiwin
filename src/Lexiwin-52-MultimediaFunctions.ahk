; Lexiwin - Functions for multimedia

MmdSetVolume(Direction)
{
    Global
    
    If Direction = Up
    {
        Send {Volume_Up}
    }
    Else
    {
        Send {Volume_Down}
    }

    Sleep 50
    SoundGet SoundInformation
    SoundInformation := Round(SoundInformation)

    CmnShowTooltip(MmdVolume . SoundInformation, 1000)
}
