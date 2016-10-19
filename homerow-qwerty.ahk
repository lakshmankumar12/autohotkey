; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

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

; See http://duartes.org/gustavo/blog/home-row-computing for more information on this script
; See the AutoHotKey docs at http://www.autohotkey.com/docs/  for AutoHotKey documentation
; Most of the syntax is described at http://www.autohotkey.com/docs/Hotkeys.htm


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

AppsKey & 2::SendInput {Ctrl Down}{PgUp Down}
AppsKey & 2 up::SendInput {Ctrl Up}{PgUp Up}

AppsKey & 3::SendInput {Ctrl Down}{PgDn Down}
AppsKey & 3 up::SendInput {Ctrl Up}{PgDn Up}

AppsKey & ]::SendInput {Shift Down}{Ins Down}
AppsKey & ] up::SendInput {Shift Up}{Ins Up}


; AppsKey + xiwe pBS

AppsKey & x::SendInput {Del Down}{Del up}
AppsKey & w::SendInput {Ctrl down}{w}{Ctrl up}
AppsKey & t::SendInput {Ctrl down}{t}{Ctrl up}
AppsKey & c::SendInput {Ctrl down}{c}{Ctrl up}
AppsKey & 7::SendInput {Ctrl down}{u}{Ctrl up}

AppsKey & s::SendInput {Blind}{BS Down}{BS Up}
AppsKey & BS::SendInput {Blind}{BS Down}{BS Up}

AppsKey & p::SendInput {Ctrl down}{p}{Ctrl up}

AppsKey & q::SendInput {Esc}
AppsKey & a::SendInput {Alt down}{Esc}{Alt up}


; Make AppsKey & Enter equivalent to Control+Enter
; AppsKey & Enter::SendInput {Ctrl down}{Enter}{Ctrl up}

; Mouse scroll
AppsKey & `;::
 MouseClick,WheelUp,,,1,0,D,R
return

AppsKey & /::
 MouseClick,WheelDown,,,1,0,D,R
return

; Mouse move
AppsKey & ,::
 MouseMove, 0, -5, 0, R ;Move the mouse five pixel Up
Return

AppsKey & m::
 MouseMove, 0, 5, 0, R ;Move the mouse five pixel Down
Return

AppsKey & .::
 MouseMove, 5, 0, 0, R ;Move the mouse five pixel to the right
Return

AppsKey & n::
 MouseMove, -5, 0, 0, R ;Move the mouse five pixel to the left
Return

AppsKey & g::
 SendInput {Click,Left}
Return

AppsKey & i::
 MouseMove, 0, -25, 0, R ;Move the mouse onehundred pixel Up
Return

AppsKey & u::
 MouseMove, 0, 25, 0, R ;Move the mouse onehundred pixel Down
Return

AppsKey & o::
 MouseMove, 25, 0, 0, R ;Move the mouse onehundred pixel to the right
Return

AppsKey & y::
 MouseMove, -25, 0, 0, R ;Move the mouse onehundred pixel to the left
Return

;Scroll-lock
AppsKey & 9::SendInput {Scrolllock}

AppsKey & 8::
 SendInput {Click,Right}
Return

AppsKey & r::
 SendInput {AppsKey}
Return

AppsKey & z::
 SendInput {Ctrl Down}{Alt Down}{Tab Down}
 SendInput {Ctrl Up}{Alt Up}{Tab Up}
Return

;Activate Hangouts
AppsKey & 1::
 SendInput {LWin down}{3}
 Sleep, 200
 SendInput {LWin up}
 CoordMode, Mouse, Window
 MouseMove, 166, 135, 0
 CoordMode, Mouse, Relative
Return

#c::
  SendInput {Alt Down}{F4}
  Sleep, 100
  SendInput {Alt Up}
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

; Make Windows Key + Apps Key work like Caps Lock
#AppsKey::Capslock

;Active workrave
AppsKey & F10::
 IfWinExist Workrave
 {
   WinActivate
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

;Active Pause music india online
AppsKey & F9::
 SetTitleMatchMode, 2
 ;SetTitleMatchMode, Slow
 WinGetTitle, currWindow, A
 IfWinExist, MusicIndiaOnline
 {
   WinActivate
   SendInput {Space}
   SendInput {LWin down}{2}
   sleep, 300
   SendInput {LWin up}
   WinActivate, %currWindow%
 }
Return

;Active putty
AppsKey & F11::
 IfWinExist, lakshmankumar.ddns.net
 {
   WinActivate
 }
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

F12::
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

^SPACE::  Winset, Alwaysontop, , A

#o::
 SetTitleMatchMode, 2
 IfWinExist, Microsoft Outlook
 {
     WinActivate
     SendInput {Ctrl Down}{Shift Down}{i}
     Sleep, 100
     SendInput {Ctrl Up}{Shift Up}
     Sleep, 100
     SendInput {Home}
     Sleep, 100
     SendInput {Shift Down}{F6}
     Sleep, 100
     SendInput {Shift Up}
}
Return

ShellMessage( wParam,lParam ) {
  If ( wParam = 0x8006 ) ;  0x8006 is 32774 as shown in Spy!
    {
        global flashWinID
        flashWinID := lParam
    }
}

#h::
  WinActivate, ahk_id %flashWinID%
Return

#j::
  IfWinExist CentOS 6.x Desktop
  {
    WinActivate
  }
Return

#n::
  IfWinExist personal ubuntu
  {
    WinActivate
  }
Return

#y::
  SendInput {LWin Down}{9}{LWin Up}
  SendInput {Ctrl Down}{1}{Ctrl Up}
Return
