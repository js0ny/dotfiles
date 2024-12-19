#Requires AutoHotkey v2.0

#h::
{
    Send("{Left}")
}

#n::
{
    Send("{Down}")
}

#e::
{
    Send("{Up}")
}

#i::
{
    Send("{Right}")
}

{
    Send("{Home}")
}
#a:: ; Vim-like navigation: Append
{
    Send("{End}")
}

#q:: ; Simulate cmd+q in macOS
{
    Send("!{F4}")
}

; 定义一个全局状态变量，标记是否触发了组合键
global CapsLockState := false

; 当 CapsLock 作为修饰键与其他键一起使用时
CapsLock & s:: {
    global CapsLockState
    CapsLockState := true
    Run("ShareX.exe -RectangleRegion")
}

; 单独按下 CapsLock 时，发送 Esc
CapsLock:: {
    global CapsLockState
    ; 如果之前未使用组合键，则发送 Esc
    if not CapsLockState {
        Send("{Esc}")
    }
    CapsLockState := false ; 重置状态
}

; 释放 CapsLock 时重置状态
*CapsLock Up:: {
    global CapsLockState
    CapsLockState := false
}

#HotIf WinActive('ahk_exe' 'QQ.exe')
^n::
{
    Send("^{Down}")
}
^h::
{
    Send("^{Left}")
}
^i::
{
    Send("^{Enter}")
}
^e::
{
    Send("^{Up}")
}
#HotIf WinActive('ahk_exe' 'Weixin.exe')
^n::
{
    Send("{Down}")
}
^e::
{
    Send("{Up}")
}
#HotIf WinActive('ahk_exe' 'Discord.exe')
^n::
{
    Send("^!{Down}")
}
^e::
{
    Send("^!{Up}")
}

#HotIf WinActive('ahk_exe' 'olk.exe')
^n::
{
    Send("{Down}")
}
^+n::
{
    Send("^.")
}
^+e::
{
    Send("^,")
}
^e::
{
    Send("{Up}")
}
#HotIf WinActive('ahk_exe' 'SumatraPDF.exe')
^\::
{
    Send("{F12}")
}
#HotIf WinActive('ahk_exe' 'Flow.Launcher.exe')
^a::
{
    Send("{End}")
}
^+a::
{
    Send("^a")
}
^l::
{
    Send("{Home}")
}
^+BackSpace::
{
    Send("^a{Backspace}")
}
#HotIf WinActive('ahk_exe' 'Obsidian.exe')
^e::
{
    Send("^p")
}
#HotIf