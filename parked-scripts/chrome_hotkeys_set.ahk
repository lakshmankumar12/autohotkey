; Source: https://gist.github.com/hubisan/5981dcf2a8560df9b434dd3b7d8e357b
; ------------------------------------
; Open or activate Chrome with a profile.
; ------------------------------------
; If Chrome with the profile specified doesn't exist yet it will open it.
; If Chrome with the profile specified is already open it will activate it.
;
; Args:
;   profile_name (str, optional): The name of the profile like "Default" or
;     "Profile 1". Defaults to "Default".
;   url (str, optional): If specified open a new tab in chrome with the profile
;     specified. Defaults to "" which means that it either actives the already
;     existing chrome or open it without visiting an url.
;   wait_for (int, optional): Maximal time in seconds it waits for Chrome to get
;     active. Defaults to 5 seconds. Depending on your system you might increase
;     this.
;
; Returns:
;   (hwnd) The window handle of chrome window of the profile specified. This can
;   be used as ahk_id. If it was not possible to get the hwnd it returns 0.
;
; Example:
;   chrome_hwnd_default := open_chrome_with_profile("Default")
;   chrome_hwnd_profile_1 := open_chrome_with_profile("Profile 1")
;   WinActivate, % "ahk_id " . chrome_hwnd_default
;   Sleep 1000
;   WinActivate, % "ahk_id " . chrome_hwnd_profile_1
;   open_chrome_with_profile("Profile 1", "www.google.com")
; ------------------------------------
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
