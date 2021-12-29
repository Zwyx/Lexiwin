; Lexiwin - Functions for quick launch

QlhDisplayTooltip(Direction)
{
    Global
    
    QlhGetCurrentListNumber()

    If LxwState = Normal
    {
        QlhItem = 1
        LxwState = QlhDisplay
    }
    Else If LxwState = QlhDisplay
    {
        If Direction = Down
        {
            QlhItem ++
        }
        Else If Direction = Up
        {
            If (QlhItem > 1)
            {
                QlhItem --
            }
        }
    }
    
    If LxwState = QlhDisplay
    {
        IniRead QlhPath, %PrfDataPath%\Lexiwin.ini, QuickLaunchList%QlhCurrentList%, Path%QlhItem%, [Nothing]
        IniRead QlhName, %PrfDataPath%\Lexiwin.ini, QuickLaunchList%QlhCurrentList%, Name%QlhItem%, [?]
        If (QlhPath = "[Nothing]")
        {
            If (QlhItem > 1)
            {
                QlhItem --
            }
            IniRead QlhPath, %PrfDataPath%\Lexiwin.ini, QuickLaunchList%QlhCurrentList%, Path%QlhItem%, [Nothing]
            IniRead QlhName, %PrfDataPath%\Lexiwin.ini, QuickLaunchList%QlhCurrentList%, Name%QlhItem%, [?]
        }
        If (QlhPath != "[Nothing]")
        {
            CmnShowTooltip(QlhTooltipHeader . QlhItem . " - " . QlhName)
        }
    }
}

QlhGetCurrentListNumber()
{
    Global

    If GetKeyState("Shift", "P") = True
    {
        QlhCurrentList = 2
    }
    Else
    {
        QlhCurrentList = 1        
    }
}

QlhLaunch()
{
    Global

    QlhGetCurrentListNumber()

    CmnBackToNormalState()

    IniRead QlhPath, %PrfDataPath%\Lexiwin.ini, QuickLaunchList%QlhCurrentList%, Path%QlhItem%, [Nothing]
    If (QlhPath != "[Nothing]")
    {
        Run %QlhPath%
    }
}
