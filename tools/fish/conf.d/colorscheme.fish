switch (uname)
case "Linux"
    set SYSTEM_COLOR_SCHEME (gsettings get org.gnome.desktop.interface color-scheme)
    if test $SYSTEM_COLOR_SCHEME = "'prefer-dark'"
        set -g fish_config_theme "Catppuccin Mocha"
    else
        set -g fish_config_theme "Catppuccin Latte"
    end
case "Darwin"
    set SYSTEM_COLOR_SCHEME defaults read -g AppleInterfaceStyle
    echo "[TODO] Check if dark mode is enabled in macOS"
case '*'
    set -g fish_config_theme "Catppuccin Mocha"
end
