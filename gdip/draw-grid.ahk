; gdi+ ahk .. draw grid .. based on tutorial 1 written by tic (Tariq Porter)

#SingleInstance, Force
#NoEnv
SetBatchLines, -1

; Uncomment if Gdip.ahk is not in your standard library
#Include, Gdip.ahk

; Start gdi+
If !pToken := Gdip_Startup()
{
	MsgBox, 48, gdiplus error!, Gdiplus failed to start. Please ensure you have gdiplus on your system
	ExitApp
}
OnExit, Exit

F8::
 SendInput {Click,Left} 
Return

F9::
; Set the width and height we want as our drawing area, to draw everything in. This will be the dimensions of our bitmap
Width :=1920, Height := 1080

; Create a layered window (+E0x80000 : must be used for UpdateLayeredWindow to work!) that is always on top (+AlwaysOnTop), has no taskbar entry or caption
Gui, 1: -Caption +E0x80000 +LastFound +AlwaysOnTop +ToolWindow +OwnDialogs

; Show the window
Gui, 1: Show, NA

marker_color = cbbff0000

; Get a handle to this window we have created in order to update it later
hwnd1 := WinExist()

; Create a gdi bitmap with width and height of what we are going to draw into it. This is the entire drawing area for everything
hbm := CreateDIBSection(Width, Height)

; Get a device context compatible with the screen
hdc := CreateCompatibleDC()

; Select the bitmap into the device context
obm := SelectObject(hdc, hbm)

; Get a pointer to the graphics of the bitmap, for use with drawing functions
G := Gdip_GraphicsFromHDC(hdc)

; Set the smoothing mode to antialias = 4 to make shapes appear smother (only used for vector drawing and filling)
Gdip_SetSmoothingMode(G, 4)

; Create a slightly transparent (66) blue brush (ARGB = Transparency, red, green, blue) to draw a rectangle
pBrush := Gdip_BrushCreateSolid(0x660000ff)

increments = 50
x_index := increments
Loop
{ 
  If x_index > %Width%
    break
  Gdip_FillRectangle(G, pBrush,  x_index, 0, 5, Height)
  x_index += increments
}

y_index := increments
Loop
{ 
  If y_index > %Height%
    break
  Gdip_FillRectangle(G, pBrush,  0, y_index, Width, 5)
  y_index += increments
}

; Delete the brush as it is no longer needed and wastes memory
Gdip_DeleteBrush(pBrush)

; We can specify the font to use. Here we use Arial as most systems should have this installed
Font = Arial
; Next we can check that the user actually has the font that we wish them to use
; If they do not then we can do something about it. I choose to give a wraning and exit!
If !Gdip_FontFamilyCreate(Font)
{
   MsgBox, 48, Font error!, The font you have specified does not exist on the system
   ExitApp
}

alpha_1 := "a", alpha_2 := "b", alpha_3 := "c", alpha_4 := "d", alpha_5 := "e"
alpha_6 := "f", alpha_7 := "g", alpha_8 := "h", alpha_9 := "i", alpha_10 := "j"
alpha_11 := "k", alpha_12 := "l", alpha_13 := "m", alpha_14 := "n", alpha_15 := "o"
alpha_16 := "p", alpha_17 := "q", alpha_18 := "r", alpha_19 := "s", alpha_20 := "t"
alpha_21 := "u", alpha_22 := "v", alpha_23 := "w", alpha_24 := "x", alpha_25 := "y"
alpha_26 := "z"

y_index := 0
digit_high := 1
digit_mid  := 1
digit_low  := 1
Loop   
{ 
  If y_index > %Height%
    break
  x_index := 0
  Loop 
  { 
    If x_index > %Width%
      break
    marker := alpha_%digit_high% . alpha_%digit_mid% . alpha_%digit_low%
    positions_x%marker% := x_index
    positions_y%marker% := y_index
    digit_low += 1
    If digit_low > 26
    {
      digit_low := 1
      digit_mid  += 1
      If digit_mid > 26
      {
        digit_mid := 1
        digit_high += 1
      }
    }
    Options = x%x_index% y%y_index% %marker_color% s20
    Gdip_TextToGraphics(G, marker, Options, Font, Width, Height)
    x_index += increments
  }
  y_index += increments
}

;Options = x0 y0 cbbffffff s20 
;Gdip_TextToGraphics(G, "aa", Options, Font, Width, Height)
;Options = x100 y0 cbbffffff s20 
;Gdip_TextToGraphics(G, "ab", Options, Font, Width, Height)
;Options = x200 y0 cbbffffff s20 
;Gdip_TextToGraphics(G, "ac", Options, Font, Width, Height)

; Update the specified window we have created (hwnd1) with a handle to our bitmap (hdc), specifying the x,y,w,h we want it positioned on our screen
; So this will position our gui at (0,0) with the Width and Height specified earlier
UpdateLayeredWindow(hwnd1, hdc, 0, 0, Width, Height)

Loop
{
	Input, UserInput1, T5 L1, {Enter}{Escape}, a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z
	IfInString, ErrorLevel, Max
    {
      GoSub, Quit
    }
	IfInString, ErrorLevel, Timeout
    { 
      GoSub, Quit
    }
	Input, UserInput2, T5 L1, {Enter}{Escape}, a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z
	IfInString, ErrorLevel, Max
    {
      GoSub, Quit
    }
	IfInString, ErrorLevel, Timeout
    { 
      GoSub, Quit
    }
	Input, UserInput3, T5 L1, {Enter}{Escape}, a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z
	IfInString, ErrorLevel, Max
    {
      GoSub, Quit
    }
	IfInString, ErrorLevel, Timeout
    { 
      GoSub, Quit
    }
    inputvalue = %UserInput1%%UserInput2%%UserInput3%
    value_x := positions_x%inputvalue%
    If value_x =
    {
      GoSub, Quit
    }
    value_y := positions_y%inputvalue%
    CoordMode, Mouse, Screen
    MouseMove, 0, 0, 0
    MouseMove, %value_x%, %value_y%, 0
    CoordMode, Mouse, Relative
GetAgain:
	Input, UserInput, T5 L1, {Enter}{Escape}, ,,,g,q,i,h,j,k,l,n,m,.,r,s,d
	IfInString, ErrorLevel, Max
    {
      GoSub, Quit
    }
	IfInString, ErrorLevel, Timeout
    { 
      GoSub, Quit
    }
    If UserInput = g
    { 
       SendInput {Click,Left} 
    }
    else If UserInput = q
    { 
       GoSub, Quit
    }
    else If UserInput = i
    { 
       delay := 200
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
       GoSub, Quit
    }
    else If UserInput = r
    { 
       SendInput {Click,Right}
    }
    else If UserInput = s
    { 
       SendInput {Click down,Left} 
    }
    else If UserInput = d
    {
       SendInput {Click,Left} 
       SendInput {Click down,Left} 
    }
    else If UserInput = h
    {
       MouseMove, -25, 0, 0, R
       Goto, GetAgain
    }
    else If UserInput = j
    {
       MouseMove, 0, 25, 0, R
       Goto, GetAgain
    }
    else If UserInput = k
    {
       MouseMove, 0, -25, 0, R
       Goto, GetAgain
    }
    else If UserInput = l
    {
       MouseMove, 25, 0, 0, R
       Goto, GetAgain
    }
    else If UserInput = n
    {
       MouseMove, -5, 0, 0, R
       Goto, GetAgain
    }
    else If UserInput = m
    {
       MouseMove, 0, 5, 0, R
       Goto, GetAgain
    }
    else If UserInput = ,
    {
       MouseMove, 0, -5, 0, R
       Goto, GetAgain
    }
    else If UserInput = .
    {
       MouseMove, 5, 0, 0, R
       Goto, GetAgain
    }
    GoSub, Quit
}

Return

;#######################################################################

Exit:
; gdi+ may now be shutdown on exiting the program
Gdip_Shutdown(pToken)
ExitApp
Return

Quit:
Gui,1: Destroy

; Select the object back into the hdc
SelectObject(hdc, obm)

; Now the bitmap may be deleted
DeleteObject(hbm)

; Also the device context related to the bitmap may be deleted
DeleteDC(hdc)

; The graphics may now be deleted
Gdip_DeleteGraphics(G)

Exit
return


