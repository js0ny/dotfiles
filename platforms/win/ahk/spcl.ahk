#Requires AutoHotkey v2.0
#SingleInstance Force

Space Up:: Send '{Space ' (A_PriorKey = 'Space' ? 1 : times) '}'
Space:: global times := ''

#HotIf GetKeyState('Space', 'P')
h::Left
n::Down
e::Up
i::Right
k::Home
o::End
u::PgUp
m::PgDn
1::F1
2::F2
3::F3
4::F4
5::F5
6::F6
7::F7
8::F8
9::F9
0::F10
-::F11
=::F12
+:: global times .= ThisHotkey
#HotIf

Enter Up:: Send '{Enter ' (A_PriorKey = 'Enter' ? 1 : times) '}'
Enter:: global times := ''

#HotIf GetKeyState('Enter', 'P')
b:: {
    Run("vivaldi.exe")
}
t:: {
    Run("wezterm-gui.exe")
}
c:: {
    Run("code.exe")
}
