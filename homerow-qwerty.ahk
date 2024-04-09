; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

;###
;### After lots of trouble, finally got the selected chrome-profile working
;### You will have to find the profile-name (Default/Profile 1/Profile N)
;### by studying the Preferences file under the profile director as give
;### post this open_chrome_with_profile() definition - and set that
;### to the call.
;###
;### For whatever reason, this has to be first. Otherwise this doesn't
;### work.
;###
; Source: https://gist.github.com/hubisan/5981dcf2a8560df9b434dd3b7d8e357b
open_chrome_with_profile(profile_name:="Default", url:="", wait_for:=5) {
    static chrome_profiles := {}
    chrome_path := "C:\Program Files\Google\Chrome\Application\chrome.exe"

    ; Check if profile is stored already and the hwnd still exists if no url is
    ; specified.
    if !url {
        profile_hwnd := chrome_profiles[profile_name]
        if (profile_hwnd && WinExist("ahk_id " . profile_hwnd)) {
            WinActivate, % "ahk_id " . profile_hwnd
            return profile_hwnd
        }
    }

    ; Build the target.
    run_target := """" . chrome_path """"
    run_target .= "--profile-directory=""" . profile_name . """"

    WinGet, current_process, ProcessName, A
    if (current_process = "chrome.exe") {
        ; Focus the tray to be able to wait for chrome.exe to get active later on.
        WinActivate, % "ahk_class Shell_TrayWnd"
        WinWaitActive, % "ahk_class Shell_TrayWnd", , 1
    }

    if url {
        ; If an url is specified just run the profile with that url and wait for
        ; chrome to be active.
        run_target .= " " . url
        Run, % run_target
        WinWaitActive, % "ahk_exe chrome.exe", , wait_for
        if ErrorLevel {
            return 0
        } else {
            WinGet, chrome_hwnd, ID, A
            chrome_profiles[profile_name] := chrome_hwnd
            return chrome_hwnd
        }
    } else {
        ; The seconds loops is only needed in case chrome with that profile
        ; didn't exist before and the session doesn't have any other tabs as
        ; this code will close the new tab opened and therefore also close the
        ; chrome instance. In that case a 2nd iteration is needed which opens
        ; chrome with a new tab.
        Loop, 2 {
            if (A_Index = 1) {
                Run, % run_target . " example.com"
            } else {
                Run, % run_target
            }
            WinWaitActive, % "ahk_exe chrome.exe", , wait_for
            if ErrorLevel {
                return 0
            } else {
                ; Get the hwnd of the window and close the fake tab.
                WinGet, chrome_hwnd, ID, A
                ; Only close the tab on the first iteration.
                if (A_Index = 1) {
                    SendInput, ^w
                    Sleep 50
                }
                ; Check if the window handle still exists. If chrome with that
                ; profile was not open before closing the tab closes chrome as well
                ; and the hwnd will not exist anymore.
                if WinExist("ahk_id " . chrome_hwnd) {
                    chrome_profiles[profile_name] := chrome_hwnd
                    return chrome_hwnd
                }
            }
        }
    }
}
; cat /Users/laksh/AppData/Local/Google/Chrome/User Data/Profile 4/Preferences | python3 -m json.tool | grep email
MsgBox, "Fetching Chrome Instances"
chrome_hwnd_default := open_chrome_with_profile("Default", "www.google.com")
MsgBox, "Got ahk_id Default: %chrome_hwnd_default% "

chrome_hwnd_profile4 := open_chrome_with_profile("Profile 4", "www.google.com")
MsgBox, "Got ahk_id Profile4: %chrome_hwnd_profile4% "

AppsKey & F9::
    WinActivate, % "ahk_id " . chrome_hwnd_profile4
Return

AppsKey & F10::
    WinActivate, % "ahk_id " . chrome_hwnd_default
Return

;###
;### Ends the chrome_profiles activation
;###

; Source: https://autohotkey.com/board/topic/54990-find-the-blinking-window-on-the-taskbar/
; **************************************
; *** Switch to Last Flashing Window ***
; **************************************
; set trigger for flashing window
InitFlashingWinTrigger:
  flashWinID =
  Gui +LastFound
  hWnd := WinExist() , DllCall( "RegisterShellHookWindow", UInt,hWnd )
  MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
  OnMessage( MsgNum, "ShellMessage" )
Return

; AppsKey + hjkl

Appskey & k::Send {Blind}{Up DownTemp}
AppsKey & k up::Send {Blind}{Up Up}

AppsKey & j::Send {Blind}{Down DownTemp}
AppsKey & j up::Send {Blind}{Down Up}

AppsKey & h::Send {Blind}{Left DownTemp}
AppsKey & h up::Send {Blind}{Left Up}

AppsKey & l::Send {Blind}{Right DownTemp}
AppsKey & l up::Send {Blind}{Right Up}

; AppsKey + df0$

AppsKey & d::SendInput {Blind}{PgUp Down}
AppsKey & d up::SendInput {Blind}{PgUp Up}

AppsKey & f::SendInput {Blind}{PgDn Down}
AppsKey & f up::SendInput {Blind}{PgDn Up}

AppsKey & 0::SendInput {Blind}{Home Down}
AppsKey & 0 up::SendInput {Blind}{Home Up}

AppsKey & 4::SendInput {Blind}{End Down}
AppsKey & 4 up::SendInput {Blind}{End Up}

AppsKey & v::SendInput {Shift Down}{Ins Down}
AppsKey & v up::SendInput {Shift Up}{Ins Up}

AppsKey & ]::SendInput {Ctrl down}{Tab Down}
AppsKey & ] up::SendInput {Ctrl Up}{Tab Up}

AppsKey & [::SendInput {Ctrl down}{Shift Down}{Tab Down}
AppsKey & [ up::SendInput {Ctrl Up}{Shift Up}{Tab Up}


; AppsKey + these combo's mostly just do ctrl-key action

AppsKey & x::SendInput {Del Down}{Del up}
AppsKey & w::SendInput {Ctrl down}{w}{Ctrl up}
AppsKey & t::SendInput {Ctrl down}{t}{Ctrl up}
AppsKey & c::SendInput {Ctrl down}{c}{Ctrl up}
AppsKey & p::SendInput {Ctrl down}{p}{Ctrl up}
AppsKey & q::SendInput {Alt down}{q}{Alt up}

AppsKey & BS::SendInput {Blind}{BS Down}{BS Up}

AppsKey & a::SendInput {Alt down}{Esc}{Alt up}

; Mouse scroll
AppsKey & `;::
 MouseClick,WheelUp,,,1,0,D,R
return

AppsKey & /::
 MouseClick,WheelDown,,,1,0,D,R
return

AppsKey & g::
 SendInput {Click,Left}
Return

AppsKey & 8::
 SendInput {Click,Right}
Return

; Mouse move
AppsKey & ,::
 CoordMode, Mouse, Screen
 MouseGetPos, X, Y
 Y -= 5
 DllCall("SetCursorPos", "int", X, "int", Y)
 ;Move the mouse five pixel Up
Return

AppsKey & m::
 CoordMode, Mouse, Screen
 MouseGetPos, X, Y
 Y += 5
 DllCall("SetCursorPos", "int", X, "int", Y)
 ;Move the mouse five pixel Down
Return

AppsKey & .::
 CoordMode, Mouse, Screen
 MouseGetPos, X, Y
 X += 5
 DllCall("SetCursorPos", "int", X, "int", Y)
 ;Move the mouse five pixel to the right
Return

AppsKey & n::
 CoordMode, Mouse, Screen
 MouseGetPos, X, Y
 X -= 5
 DllCall("SetCursorPos", "int", X, "int", Y)
 ;Move the mouse five pixel to the left
Return

AppsKey & i::
 CoordMode, Mouse, Screen
 MouseGetPos, X, Y
 Y -= 25
 DllCall("SetCursorPos", "int", X, "int", Y)
 ;Move the mouse 25 pixel Up
Return

AppsKey & u::
 CoordMode, Mouse, Screen
 MouseGetPos, X, Y
 Y += 25
 DllCall("SetCursorPos", "int", X, "int", Y)
 ;Move the mouse 25 pixel Down
Return

AppsKey & o::
 CoordMode, Mouse, Screen
 MouseGetPos, X, Y
 X += 25
 DllCall("SetCursorPos", "int", X, "int", Y)
 ;Move the mouse 25 pixel Right
Return

AppsKey & y::
 CoordMode, Mouse, Screen
 MouseGetPos, X, Y
 X -= 25
 DllCall("SetCursorPos", "int", X, "int", Y)
 ;Move the mouse 25 pixel Left
Return

;Scroll-lock
AppsKey & 9::SendInput {Scrolllock}

AppsKey & r::
 SendInput {AppsKey}
Return

AppsKey & z::
 SendInput {Ctrl Down}{Alt Down}{Tab Down}
 SendInput {Ctrl Up}{Alt Up}{Tab Up}
Return

AppsKey & e::
 FileRead, clipboard, C:\Users\laksh\Documents\cliptest.txt
Return

;Active putty - work
AppsKey & 1::
 IfWinExist moshHetz
 {
   WinActivate
 }
Return

;Active putty - local
AppsKey & 2::
 IfWinExist, MyVMFirst
 {
   WinActivate
 }
Return

AppsKey & 3::
 IfWinExist, MyVMSecond
 {
   WinActivate
 }
Return

AppsKey & 7::
 SetTitleMatchMode, 2
 IfWinExist, Visual Studio Code
 {
   WinActivate
 }
Return

;Activate Adobe
AppsKey & b::
 SetTitleMatchMode, 2
 IfWinExist, Adobe Acrobat Reader
 {
   WinActivate
 }
Return

;Activate slack
AppsKey & s::
  SetTitleMatchMode, 2
  IfWinExist Slack
  {
      WinActivate
  }
Return

;Activate YTM
AppsKey & F11::
  IfWinExist YouTube Music
  {
      WinActivate
  }
Return

;Activate WorkRave
AppsKey & F3::
  IfWinExist WorkRave
  {
      WinActivate
  }
Return

; switch window with asking
AppsKey & 5::
  InputBox, WindowTitleToMatch, Window Title, Enter a title string., , 275, 120
  if ErrorLevel {

  }
  else {
     SetTitleMatchMode, 2
     IfWinExist %WindowTitleToMatch%
     {
       WinActivate
     }
     else
     {
        MsgBox, Couldnt find "%WindowTitleToMatch%"
     }
  }
Return

AppsKey & F4::
  Send {Media_Play_Pause}
Return

AppsKey & F5::
  Send {Volume_Down}
Return

AppsKey & F6::
  Send {Volume_Up}
Return

AppsKey & F7::
  Send {Browser_Back}
Return

AppsKey & F8::
  Send {Browser_Forward}
Return

;Show where the mouse is
AppsKey & 6::
       delay := 200
       MouseGetPos, value_x, value_y
       Gui, 5: +AlwaysOnTop -Caption +LastFound +ToolWindow
       Gui, 5: Color, FF3333
       WinSet, TransColor, %color% %transparency%
       Gui,5: Show, x%value_x% y%value_y% w20 h20 noactivate
       Loop, 1
       {
           Sleep, %delay%
           WinHide
           Sleep, %delay%
           WinShow
       }
       Sleep, %delay%
       Gui, 5: Destroy
Return

AppsKey & F12::
WinGetTitle, title, A
WinGetTitle, text, A
WinGetClass, class, A
MsgBox, "title:%title%,\ntext:%text%,\nclass %class%"
return

^!c::
  IfWinExist Calculator
  {
    WinActivate
  }
  else
  {
    Run calc.exe
    WinWait Calculator
    WinActivate
  }
Return

; **** Mark Mouse Positions

mouseSaveXposA = 0
mouseSaveYposA = 0

^!m::
  MouseGetPos, mouseSaveXposA, mouseSaveYposA
Return

^!g::
  MouseMove, %mouseSaveXposA%, %mouseSaveYposA%, 0
Return

^!r::Reload

^!SPACE::  Winset, Alwaysontop, , A

ShellMessage( wParam,lParam ) {
  If ( wParam = 0x8006 ) ;  0x8006 is 32774 as shown in Spy!
    {
        global flashWinID
        flashWinID := lParam
    }
}

; Make Windows Key + Apps Key work like Caps Lock
#AppsKey::Capslock

#c::
  SendInput {Alt Down}{F4}
  Sleep, 100
  SendInput {Alt Up}
Return

#h::
  WinActivate, ahk_id %flashWinID%
Return

#j::
  MouseClick
  SendInput {Ctrl Down}{WheelUp 20}{Ctrl Up}
Return

