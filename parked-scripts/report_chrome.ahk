ActivateChrome() {
    var1 := "chrome.exe" ;process name
    var2 := "00Default"    ;set the specific profile
    for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process  where Name = '" var1 "'") {
        Commandline := process.Commandline
        WinGetTitle, title, A
        MsgBox, "Commandline: %Commandline%,  title: %title% "
        IfInString, Commandline, "%var2%"
        {
            str := process.ProcessId
            StringReplace Parameters, Commandline, % Process.ExecutablePath
            StringReplace Parameters, Parameters, ""
            MsgBox, "Parameters:%Parameters%"
            ;IfInString, Parameters, %var2%
            ;{
               ;WinActivate ahk_pid %str%
               ;Break
            ;}
        }
    }
}

ActivateChrome()
