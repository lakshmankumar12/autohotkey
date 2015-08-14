; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

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

AppsKey & x::SendInput {Blind}{Del Down}
AppsKey & [::SendInput {Blind}{Ins Down}
AppsKey & w::SendInput {Ctrl down}{F4}{Ctrl up}
AppsKey & t::SendInput {Alt down}{F4}{Alt up}

AppsKey & p::SendInput {Blind}{BS Down}
AppsKey & BS::SendInput {Blind}{BS Down}

; Make AppsKey & Enter equivalent to Control+Enter
; AppsKey & Enter::SendInput {Ctrl down}{Enter}{Ctrl up}

; Make AppsKey & Alt Equivalent to Control+Alt
AppsKey::SendInput {Ctrl down}{Alt Down}
AppsKey up::SendInput {Ctrl up}{Alt up}

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

AppsKey & 6::
 SendInput {Click down,Left} 
Return

AppsKey & 7::
 SendInput {Click up,Left} 
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

Appskey & F6::Send {Blind}{F6 Down}
AppsKey & F6 up::Send {Blind}{F6 Up}

AppsKey & z::
 SendInput {Ctrl Down}{Alt Down}{Tab Down}
 SendInput {Ctrl Up}{Alt Up}{Tab Up}
Return

;Activate Hangouts
AppsKey & 1::
 SendInput {LWin down}{3}
 SendInput {LWin up}{3}
Return

;Activate capure mode in vm
AppsKey & 5::
 SendInput {RAlt down}
 SendInput {RAlt up}
 sleep, 200
 SendInput {Alt down}{Tab}
 SendInput {Alt up}
Return

AppsKey & F7::
 Send {Volume_Up}
Return

AppsKey & F8::
 Send {Volume_Down}
Return

; Make Windows Key + Apps Key work like Caps Lock
#AppsKey::Capslock


F12::
WinGetTitle, title, A
MsgBox, "%title%"
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

^!a::
  IfWinExist AirDroid
  {
    WinActivate
  }
  else
  {
    MsgBox, "Airdroid window not found"
  } 
Return

^!t::
  Gui Destroy
  Engine = 1
  Gui Add, Radio, vEngine, Left-Top
  Gui Add, Radio,, Right-Top
  Gui Add, Radio,, Left-Bottom
  Gui Add, Radio,, Right-Bottom
  Gui Add, Button, Default, OK
  Gui Show
  Return
  

  ButtonOK:
  Gui Submit
  SysGet, Mon, MonitorWorkArea, 1
  if Engine = 1
      MouseMove, %MonLeft%,%MonTop%,0
  else if Engine = 2
      MouseMove, %MonRight%,%MonTop%,0
  else if Engine = 3
      MouseMove, %MonLeft%,%MonBottom%,0
  else if Engine = 4
      MouseMove, %MonRight%,%MonBottom%,0
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

