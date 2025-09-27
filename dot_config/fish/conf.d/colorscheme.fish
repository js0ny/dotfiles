switch (uname)
case "Linux"
    set SYSTEM_COLOR_SCHEME (gsettings get org.gnome.desktop.interface color-scheme)
    if test $SYSTEM_COLOR_SCHEME = "'prefer-dark'"
        fish_config theme choose "Catppuccin Mocha"
    else
        fish_config theme choose "Catppuccin Latte"
    end
case "Darwin"
    set SYSTEM_COLOR_SCHEME (defaults read -g AppleInterfaceStyle)
    if test $SYSTEM_COLOR_SCHEME = "Dark"
        fish_config theme choose "Catppuccin Mocha"
    else
        fish_config theme choose "Catppuccin Latte"
    end
case '*'
    fish_config theme choose "Catppuccin Mocha"
end
