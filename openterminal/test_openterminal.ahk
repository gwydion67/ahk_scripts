
;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode "Input" ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_InitialWorkingDir ; Ensures a consistent starting directory.
#Requires AutoHotkey v2.0

InstallKeybdHook

F12::ToggleTerminal()
ShowAndPositionTerminal()
{
    WinShow "ahk_class CASCADIA_HOSTING_WINDOW_CLASS"
    WinActivate "ahk_class CASCADIA_HOSTING_WINDOW_CLASS"

    MonitorGetWorkArea(, , &Top,,)
    TerminalWidth := A_ScreenWidth * 0.9
    if (A_ScreenWidth / A_ScreenHeight) > 1.5 {
        TerminalWidth := A_ScreenWidth * 0.6
    }
    WinMove((A_ScreenWidth - TerminalWidth) / 2, Top - 2, TerminalWidth, A_ScreenHeight * 0.5, "ahk_class CASCADIA_HOSTING_WINDOW_CLASS")
}

ToggleTerminal()
{
    
    WinMatcher := "ahk_class CASCADIA_HOSTING_WINDOW_CLASS"

    DetectHiddenWindows true
    if WinExist(WinMatcher)
    ; Window Exists
    {
        DetectHiddenWindows False

        ; Check if its hidden
        if !WinExist(WinMatcher) || !WinActive(WinMatcher)
        {
            ShowAndPositionTerminal()
        }
        else if WinExist(WinMatcher)
        {
            ; Script sees it without detecting hidden windows, so..
            WinHide "ahk_class CASCADIA_HOSTING_WINDOW_CLASS"
            Send "{!}{Esc}"
        }
    }
    else
    {
        
         Run "wt.exe"
        Sleep(1000)
        ShowAndPositionTerminal()
    }
}