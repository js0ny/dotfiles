#!/bin/bash
# chromium-flags.sh
# Set Chromium & Electron Flags

echo "[INFO] Set Chromium & Electron Flags"

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
BROWSER_FLAG=$DOTFILES/platforms/linux/chromium-flags.conf
ELECTRON_FLAG=$DOTFILES/platforms/linux/electron-flags.conf

# Browser Flags

browser_flags_path=(
    "$XDG_CONFIG_HOME/chromium-flags.conf" # Chromium
    "$XDG_CONFIG_HOME/chrome-flags.conf" # Google Chrome
    "$XDG_CONFIG_HOME/thorium-flags.conf" # Thorium
    "$XDG_CONFIG_HOME/vivaldi-flags.conf" # Vivaldi
    "$XDG_CONFIG_HOME/vivaldi-stable.conf" # Vivaldi

)

electron_flags_path=(
    "$XDG_CONFIG_HOME/electron-flags.conf" # General
    "$XDG_CONFIG_HOME/code-flags.conf" # VSCode
    "$XDG_CONFIG_HOME/qq-electron-flags.conf" # Slack
)

for path in "${browser_flags_path[@]}"; do
    if [ -f "$path" ]; then
        echo "[INFO] Found Browser Flags: $path"
    else
        echo "[INFO] Creating Browser Flags: $path"
        ln -s $BROWSER_FLAG $path
    fi
done


for path in "${electron_flags_path[@]}"; do
    if [ -f "$path" ]; then
        echo "[INFO] Found Electron Flags: $path"
    else
        echo "[INFO] Creating Electron Flags: $path"
        ln -s $ELECTRON_FLAG $path
    fi
done
