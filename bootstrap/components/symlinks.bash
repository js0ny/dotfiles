#!/usr/bin/env bash
# vim:ft=bash
# shellcheck disable=SC1090 shell=bash
# This should be run with bash > 4.0 or zsh
set -e # Exit immediately if a command exits with a non-zero status

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
NPM_CONFIG_USERCONFIG="${NPM_CONFIG_USERCONFIG:-$XDG_CONFIG_HOME/npm/npmrc}"
GUI_SETUP="${GUI_SETUP:-1}"
WHEEL="${WHEEL:-0}"

XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

echo "[INFO] Setting up some local directories"
test -d "$XDG_CACHE_HOME" || mkdir -p "$XDG_CACHE_HOME"
test -d "$XDG_DATA_HOME" || mkdir -p "$XDG_DATA_HOME"
test -d "$XDG_STATE_HOME" || mkdir -p "$XDG_STATE_HOME"
test -d ~/.local/state/zsh || mkdir -p ~/.local/state/zsh

# echo "[INFO] Setting up system-wide zsh configuration"
# echo "[ACTION] Elevation required!"
# test -f "/etc/zsh/zshenv" && sudo cp "$DOTFILES/tools/zsh/zshenv" "/etc/zsh/zshenv"
# test -f "/etc/zshenv" && sudo cp "$DOTFILES/tools/zsh/zshenv" "/etc/zshenv"

declare -A linkDots

linkDots=(
    ["$DOTFILES/common/condarc.yaml"]="$XDG_CONFIG_HOME/conda/.condarc"
    # ["$DOTFILES/common/gitconfig"]="$XDG_CONFIG_HOME/git/config"
    ["$DOTFILES/common/glow.yaml"]="$HOME/.config/glow/config.yml"
    ["$DOTFILES/common/haskeline"]="$HOME/.haskeline"
    ["$DOTFILES/common/ideavimrc"]="$XDG_CONFIG_HOME/ideavim/ideavimrc"
    ["$DOTFILES/common/lazygit.yaml"]="$XDG_CONFIG_HOME/lazygit/config.yml"
    ["$DOTFILES/common/lesskey"]="$XDG_CONFIG_HOME/lesskey"
    ["$DOTFILES/common/npmrc"]="$NPM_CONFIG_USERCONFIG"
    ["$DOTFILES/common/NuGet.Config"]="$XDG_CONFIG_HOME/NuGet/NuGet.Config"
    ["$DOTFILES/common/pip.conf"]="$XDG_CONFIG_HOME/pip/pip.conf"
    ["$DOTFILES/common/starship.toml"]="$HOME/.config/starship.toml"
    ["$DOTFILES/common/tmux.conf"]="$XDG_CONFIG_HOME/tmux/tmux.conf"
    ["$DOTFILES/common/vimrc"]="$XDG_CONFIG_HOME/vim/vimrc"
    ["$DOTFILES/common/zellij.config.kdl"]="$HOME/.config/zellij/config.kdl"
    # ["$DOTFILES/tools/emacs.d"]="$HOME/.emacs.d"
    ["$DOTFILES/tools/doom"]="$HOME/.config/doom"
    ["$DOTFILES/tools/fish"]="$HOME/.config/fish"
    ["$DOTFILES/tools/ipython"]="$XDG_CONFIG_HOME/ipython"
    ["$DOTFILES/tools/nvim"]="$XDG_CONFIG_HOME/nvim"
    ["$DOTFILES/tools/yazi"]="$HOME/.config/yazi"
    ["$DOTFILES/tools/zsh/zshrc"]="$ZDOTDIR/.zshrc"
    ["$DOTFILES/tools/zsh/zshenv"]="$ZDOTDIR/.zshenv"
    ["$DOTFILES/platforms/mac/pwshProfile.ps1"]="$HOME/.config/powershell/Microsoft.PowerShell_profile.ps1"
)

if [ $(uname) = "Darwin" ]; then
    echo "[INFO] Running on macOS"
    linkDots+=(
        ["$DOTFILES/platforms/mac/karabiner"]="$HOME/.config/karabiner"
        ["$DOTFILES/platforms/mac/skhdrc"]="$XDG_CONFIG_HOME/skhd/skhdrc"
        ["$DOTFILES/platforms/mac/sketchybarrc"]="$XDG_CONFIG_HOME/sketchybar/sketchybarrc"
        ["$DOTFILES/platforms/mac/yabairc"]="$XDG_CONFIG_HOME/yabai/yabairc"
        ["$DOTFILES/tools/wezterm"]="$HOME/.config/wezterm"
        ["$DOTFILES/tools/zed"]="$HOME/.config/zed"
        ["$DOTFILES/tools/sioyek"]="$HOME/.config/sioyek"
    )
else
    echo "[INFO] Running on Linux"
    linkDots+=(
        ["$DOTFILES/common/inputrc"]="$HOME/.inputrc"
    )
    # WSL1 : Microsoft
    # WSL2 : microsoft
    # if [ "$(uname -r)" = *icrosoft* ]; then
    #     echo "[INFO] Running on WSL"
    #     : # NOP
    if [ "$GUI_SETUP" -eq 1 ]; then
        echo "[INFO] Setting up Linux GUI Applications"
        linkDots+=(
            ["$DOTFILES/platforms/linux/awesome"]="$HOME/.config/awesome"
            ["$DOTFILES/platforms/linux/hypr"]="$HOME/.config/hypr"
            ["$DOTFILES/platforms/linux/waybar"]="$HOME/.config/waybar"
            ["$DOTFILES/platforms/linux/wlogout"]="$HOME/.config/wlogout"
            ["$DOTFILES/platforms/linux/mako-config"]="$HOME/.config/mako/config"
            ["$DOTFILES/tools/wezterm"]="$HOME/.config/wezterm"
            ["$DOTFILES/tools/zed"]="$HOME/.config/zed"
            ["$DOTFILES/tools/sioyek"]="$HOME/.config/sioyek"
        )
        for kde in "$DOTFILES/platforms/linux/kde/"*; do
            linkDots+=["$kde"]="$HOME/.config/kde/$(basename "$kde")"
            # echo "Linking $kde to $HOME/.config/kde/$(basename $kde)"
        done
        if [ "$WHEEL" -eq 1 ]; then
            echo "[INFO] Setting up system environment variables"
            echo "[ACTION] Elevation required!"
            sudo cp "$DOTFILES/platforms/linux/etc/environment" "/etc/environment"
        fi
    fi
fi

echo "[INFO] Copying example files"
test -d $XDG_CONFIG_HOME/git || mkdir -p $XDG_CONFIG_HOME/git
test -f $XDG_CONFIG_HOME/git/config && mv $XDG_CONFIG_HOME/git/config $XDG_CONFIG_HOME/git/config.bak
cp $DOTFILES/common/gitconfig.example $XDG_CONFIG_HOME/git/config
echo "[INFO] Don't forget to update your gitconfig!"

test -f ~/.wakatime.cfg && mv ~/.wakatime.cfg ~/.wakatime.cfg.bak
cp $DOTFILES/common/wakatime.example.cfg ~/.wakatime.cfg
echo "[INFO] Don't forget to update your wakatime config!"
