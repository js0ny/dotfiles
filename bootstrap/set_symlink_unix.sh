#! /usr/bin/env bash
# $DOTFILES/bootstrap/set_symlink_unix.sh
# Date: 2025-01-28
# Author: js0ny
# Set symbolic links for Unix-like systems
# IMPORTANT: The default `bash` in macOS is outdated, run with zsh or install the latest `bash` via Homebrew

set -e # Exit immediately if a command exits with a non-zero status

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
NPM_CONFIG_USERCONFIG="${NPM_CONFIG_USERCONFIG:-$XDG_CONFIG_HOME/npm/npmrc}"

mkdir -p $ZDOTDIR/plugins

echo "[INFO] Setting up system-wide zsh configuration"
echo "[ACTION] Elevation required!"
test -f "/etc/zsh/zshenv" && sudo cp "$DOTFILES/tools/zsh/zshenv" "/etc/zsh/zshenv"
test -f "/etc/zshenv" && sudo cp "$DOTFILES/tools/zsh/zshenv" "/etc/zshenv"

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
    ["$DOTFILES/tools/zsh/common.zshrc"]="$ZDOTDIR/.zshrc"
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
    if [ "$(uname -r)" = *Microsoft* ]; then
        echo "[INFO] Running on WSL1"
	    : # NOP
    else
        echo "[INFO] Running on Native Linux"
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
            linkDots+=["$kde"]="$HOME/.config/kde/$(basename $kde)"
            # echo "Linking $kde to $HOME/.config/kde/$(basename $kde)"
        done
        echo "[INFO] Setting up system environment variables"
        echo "[ACTION] Elevation required!"
        sudo cp "$DOTFILES/platforms/linux/etc/environment" "/etc/environment"
    fi
fi

echo "[INFO] Setting up symbolic links"
for src in "${!linkDots[@]}"; do
    echo "Linking $src to ${linkDots[$src]}"
    dest="${linkDots[$src]}"
    if [ -d "$src" ]; then
        test -d $dest && mv $dest $dest.bak
        mkdir -p $dest
        ln -sf $src $dest
    elif [ -f "$src" ]; then
        dest_parent=$(dirname $dest)
        test -d $dest_parent || mkdir -p $dest_parent
        ln -sf $src $dest
    else
        echo "[ERROR] $src does not exist"
    fi
done

echo "[INFO] Installing zsh plugins"
test -d $ZDOTDIR/plugins/zsh-autosuggestions || git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git $ZDOTDIR/plugins/zsh-autosuggestions
test -d $ZDOTDIR/plugins/zsh-syntax-highlighting || git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZDOTDIR/plugins/zsh-syntax-highlighting
test -d $ZDOTDIR/plugins/zsh-history-substring-search || git clone --depth 1 https://github.com/zsh-users/zsh-history-substring-search.git $ZDOTDIR/plugins/zsh-history-substring-search
test -d $ZDOTDIR/plugins/zsh-completions || git clone --depth 1 https://github.com/zsh-users/zsh-completions.git $ZDOTDIR/plugins/zsh-completions

echo "[INFO] Setting up some local directories"
test -d $XDG_CACHE_HOME || mkdir -p $XDG_CACHE_HOME
test -d $XDG_DATA_HOME || mkdir -p $XDG_DATA_HOME
test -d $XDG_STATE_HOME || mkdir -p $XDG_STATE_HOME
test -d ~/.local/state/zsh || mkdir -p ~/.local/state/zsh



echo "[INFO] Copying example files"
test -d $XDG_CONFIG_HOME/git || mkdir -p $XDG_CONFIG_HOME/git
cp $DOTFILES/common/gitconfig.example $XDG_CONFIG_HOME/git/config
echo "[INFO] Don't forget to update your gitconfig!"

echo "[INFO] Installing DOOM Emacs"
echo "[ACTION] Request Human Takeover"
test -d ~/.config/emacs && mv ~/.config/emacs ~/.config/emacs.bak
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
~/.config/emacs/bin/doom sync

echo "[INFO] Installing Emacs-Rime"
git clnh https://github.com/js0ny/Rime.git ~/.config/emacs/.local/cache/rime


echo "[INFO] Done!"

export ZDOTDIR
export DOTFILES
export NPM_CONFIG_USERCONFIG
