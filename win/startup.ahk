;-------------------------------------------------move-windows-L-LINUX
If (A_AhkVersion < "1.0.39.00")
{
    MsgBox,20,,This script may not work properly with your version of AutoHotkey. Continue?
    IfMsgBox,No
    ExitApp
}


; This is the setting that runs smoothest on my
; system. Depending on your video card and cpu
; power, you may want to raise or lower this value.
SetWinDelay,2

CoordMode,Mouse
return

!LButton::
If DoubleAlt
{
    MouseGetPos,,,KDE_id
    ; This message is mostly equivalent to WinMinimize,
    ; but it avoids a bug with PSPad.
    PostMessage,0x112,0xf020,,,ahk_id %KDE_id%
    DoubleAlt := false
    return
}
; Get the initial mouse position and window id, and
; abort if the window is maximized.
MouseGetPos,KDE_X1,KDE_Y1,KDE_id
WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
If KDE_Win
    return
; Get the initial window position.
WinGetPos,KDE_WinX1,KDE_WinY1,,,ahk_id %KDE_id%
Loop
{
    GetKeyState,KDE_Button,LButton,P ; Break if button has been released.
    If KDE_Button = U
        break
    MouseGetPos,KDE_X2,KDE_Y2 ; Get the current mouse position.
    KDE_X2 -= KDE_X1 ; Obtain an offset from the initial mouse position.
    KDE_Y2 -= KDE_Y1
    KDE_WinX2 := (KDE_WinX1 + KDE_X2) ; Apply this offset to the window position.
    KDE_WinY2 := (KDE_WinY1 + KDE_Y2)
    WinMove,ahk_id %KDE_id%,,%KDE_WinX2%,%KDE_WinY2% ; Move the window to the new position.
}
return

!RButton::
If DoubleAlt
{
    MouseGetPos,,,KDE_id
    ; Toggle between maximized and restored state.
    WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
    If KDE_Win
        WinRestore,ahk_id %KDE_id%
    Else
        WinMaximize,ahk_id %KDE_id%
    DoubleAlt := false
    return
}
; Get the initial mouse position and window id, and
; abort if the window is maximized.
MouseGetPos,KDE_X1,KDE_Y1,KDE_id
WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
If KDE_Win
    return
; Get the initial window position and size.
WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinW,KDE_WinH,ahk_id %KDE_id%
; Define the window region the mouse is currently in.
; The four regions are Up and Left, Up and Right, Down and Left, Down and Right.
If (KDE_X1 < KDE_WinX1 + KDE_WinW / 2)
    KDE_WinLeft := 1
Else
    KDE_WinLeft := -1
If (KDE_Y1 < KDE_WinY1 + KDE_WinH / 2)
    KDE_WinUp := 1
Else
    KDE_WinUp := -1
Loop
{
    GetKeyState,KDE_Button,RButton,P ; Break if button has been released.
    If KDE_Button = U
        break
    MouseGetPos,KDE_X2,KDE_Y2 ; Get the current mouse position.
    ; Get the current window position and size.
    WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinW,KDE_WinH,ahk_id %KDE_id%
    KDE_X2 -= KDE_X1 ; Obtain an offset from the initial mouse position.
    KDE_Y2 -= KDE_Y1
    ; Then, act according to the defined region.
    WinMove,ahk_id %KDE_id%,, KDE_WinX1 + (KDE_WinLeft+1)/2*KDE_X2  ; X of resized window
                            , KDE_WinY1 +   (KDE_WinUp+1)/2*KDE_Y2  ; Y of resized window
                            , KDE_WinW  -     KDE_WinLeft  *KDE_X2  ; W of resized window
                            , KDE_WinH  -       KDE_WinUp  *KDE_Y2  ; H of resized window
    KDE_X1 := (KDE_X2 + KDE_X1) ; Reset the initial position for the next iteration.
    KDE_Y1 := (KDE_Y2 + KDE_Y1)
}
return

; "Alt + MButton" may be simpler, but I
; like an extra measure of security for
; an operation like this.
!MButton::
If DoubleAlt
{
    MouseGetPos,,,KDE_id
    WinClose,ahk_id %KDE_id%
    DoubleAlt := false
    return
}
return

; This detects "double-clicks" of the alt key.
~Alt::
DoubleAlt := A_PriorHotkey = "~Alt" AND A_TimeSincePriorHotkey < 400
Sleep 0
KeyWait Alt  ; This prevents the keyboard's auto-repeat feature from interfering.
return
;============================================================================

;///-----------------------------------------------光标移动

CapsLock & k:: Send {Up}
CapsLock & j:: Send {Down}
CapsLock & h:: Send {Left}
CapsLock & l:: Send {Right}
return

capslock & w:: send ^{Right}
capslock & b:: send ^{Left}
return

;=============================================================================

;-----------------------------------------------撤销-重复

capslock & u:: send ^{z}
return

capslock & p:: send ^{v}
return

CapsLock & s:: send ^{x}
return

capslock & .:: send ^{y}          ;FX
return

;=============================================================================

;///-----------------------------------------------括选


>!h:: send +{Left}
>!j:: send +{Down}
>!k:: send +{Up}
>!l:: send +{Right}
return

>!w:: send {CtrlDown}{ShiftDown}{Right}{CtrlUp}{ShiftUp}
return

>!b:: send {CtrlDown}{ShiftDown}{Left}{CtrlUp}{ShiftUp}
return

>!4:: send +{End}
>!0:: send +{Home}
return

;=============================================================================

;-----------------------------------------------段节

>+j::
    send {home}{Left}{ShiftDown}{home}{ShiftUp}{BackSpace}     ;Q_up
Return
 
>+k::
    send {end}{Right}{ShiftDown}{end}{ShiftUp}{BackSpace}  ;Q_down
Return

<^BackSpace:: 
    send {home}{Left}{Enter}
return

>+4:: send +{end}{delete}
return

>+0:: send +{home}{delete}
return

capslock & g::
if capslockg_presses > 0
{
    capslockg_presses += 1
    return
}
capslockg_presses = 1
SetTimer, keycapslockg, 150
return

Keycapslockg:

SetTimer, Keycapslockg, off

if capslockg_presses = 1
{
    Send, ^{Home}
}
else if capslockg_presses = 2
{
    Send, ^{End}
}
else if capslockg_presses < 2
MsgBox

capslockg_presses = 0
Return

;-----------------------------------------------删除、复制与剪切连击组合


capslock & y::                ;copy&cpy-here
if capslocky_presses > 0
{
    capslocky_presses += 1
    Return
}
capslocky_presses = 1
SetTimer, Keycapslocky, 150
Return

Keycapslocky:

SetTimer, Keycapslocky, off

if capslocky_presses = 1
{
    Gosub, Y1   
}
else if capslocky_presses = 2
{
    Gosub, Y2      
}
else if capslocky_presses > 2
{
    Gosub, Y3
}
;
capslocky_presses = 0
Return

Y1:             ;单一字节
send, ^c
Return

Y2:             ;段落
Send, {Home}{ShiftDown}{End}{ShiftUp}
send, ^c
send, {End}
Return

Y3:             ;词组
send, ^{Left}{ShiftDown}
      ^{Right}{ShiftDown}{ShiftUp}
send, ^{c}
return

MsgBox
return


capslock & d::                  ;del&del-here
if capslockd_presses > 0
{
    capslockd_presses += 1
    Return
}
capslockd_presses = 1
SetTimer, Keycapslockd, 150
Return

Keycapslockd:

SetTimer, Keycapslockd, off

if capslockd_presses = 1
{
    send, {Delete}
}
else if capslockd_presses = 2
{
    send, {END}{ShiftDown}{HOME}{ShiftUp}{Backspace}
}
else if capslockd_presses > 2
MsgBox

capslockd_presses = 0
Return

;
capslock & x::                    ;bk0.1
if capslockx_presses > 0
{
    capslockx_presses += 1
    Return
}
capslockx_presses = 1
SetTimer, Keycapslockx, 150
Return

Keycapslockx:

SetTimer, Keycapslockx, off

if capslockx_presses = 1
{
    send, {Backspace}
}
else if capslockx_presses = 2
{
    send,{HOME}{ShiftDown}{End}{ShiftUp}
    send,^x
    send,{End}
}
else if capslockx_presses > 2
MsgBox

;reset code
capslockx_presses = 0
Return

;=============================================================================

;-----------------------------------------------end
CapsLock & 4::          ;end
if capslock4_presses > 0
{
    capslock4_presses += 1
    Return
}
capslock4_presses = 1
SetTimer, Keycapslock4, 150
Return

Keycapslock4:

SetTimer, Keycapslock4, off

if capslock4_presses = 1
{
    send, {END}
}
else if capslock4_presses = 2
{
    send, {ShiftDown}{END}
    send, ^x
}
else if capslock4_presses > 2
MsgBox

;
capslock4_presses = 0
Return

CapsLock & 0::                  ;home
if capslock0_presses > 0
{
    capslock0_presses += 1
    Return
}
capslock0_presses = 1
SetTimer, Keycapslock0, 150
Return

Keycapslock0:

SetTimer, Keycapslock0, off

if capslock0_presses = 1
{
    send, {home}
}
else if capslock0_presses = 2
{
    send, {ShiftDown}{home}
    send, ^x
}
else if capslock0_presses > 2
MsgBox

;
capslock0_presses = 0
Return

;=============================================================================

;-------------------------------------------------窗口置顶、窗口转换
>^\::  Winset, Alwaysontop, , A
return

RControl & Left:: send !{Tab}
RControl & Right:: send !+{tab}
return

>^PgDn:: send #{m}
;=============================================================================

;-------------------------------------------------快捷符号：批划
capslock & ,::
 send +{,}{.}
 send {Left}
return

capslock & [::
 send +{[}{]}
 send {Left}
return

capslock & 9:: 
 Send +{(}{)}
 send {Left}
return

capslock & '::
 send +{"}{"}
 send {Left}
return

;;::
Clipboard = .com
send ^v
;;eturn

;;;capslock & /::
Clipboard = https://www.
send ^v
;;return
;============================================================================

;-number code set ---software
;==
