#Requires AutoHotkey v2.0
#SingleInstance Force

; 全局变量声明
global g_LastCtrlKeyDownTime := 0
global g_AbortSendEsc := false
global g_ControlRepeatDetected := false

*CapsLock:: {
    global g_ControlRepeatDetected
    global g_LastCtrlKeyDownTime
    global g_AbortSendEsc

    if (g_ControlRepeatDetected) {
        return
    }

    Send "{Ctrl down}"
    g_LastCtrlKeyDownTime := A_TickCount
    g_AbortSendEsc := false
    g_ControlRepeatDetected := true
}

*CapsLock Up:: {
    global g_ControlRepeatDetected
    global g_LastCtrlKeyDownTime
    global g_AbortSendEsc

    Send "{Ctrl up}"
    g_ControlRepeatDetected := false
    if (g_AbortSendEsc) {
        return
    }
    current_time := A_TickCount
    time_elapsed := current_time - g_LastCtrlKeyDownTime
    if (time_elapsed <= 250) {
        SendInput "{Esc}"
    }
}

; 组合所有 Ctrl 快捷键
#HotIf
~*^a::
~*^b::
~*^c::
~*^d::
~*^e::
~*^f::
~*^g::
~*^h::
~*^i::
~*^j::
~*^k::
~*^l::
~*^m::
~*^n::
~*^o::
~*^p::
~*^q::
~*^r::
~*^s::
~*^t::
~*^u::
~*^v::
~*^w::
~*^x::
~*^y::
~*^z::
~*^1::
~*^2::
~*^3::
~*^4::
~*^5::
~*^6::
~*^7::
~*^8::
~*^9::
~*^0::
~*^Space::
~*^Backspace::
~*^Delete::
~*^Insert::
~*^Home::
~*^End::
~*^PgUp::
~*^PgDn::
~*^Tab::
~*^Enter::
~*^,::
~*^.::
~*^/::
~*^;::
~*^'::
~*^[::
~*^]::
~*^\::
~*^-::
~*^=::
~*^`::
~*^F1::
~*^F2::
~*^F3::
~*^F4::
~*^F5::
~*^F6::
~*^F7::
~*^F8::
~*^F9::
~*^F10::
~*^F11::
~*^F12::
{
    global g_AbortSendEsc
    g_AbortSendEsc := true
}
