#!/usr/bin/env bash
# vim:ft=bash

set -e

echo "Running the setup script"

# Variables

export DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

# If is in the sudo or wheel group, set the WHEEL variable to 1
WHEEL=0
groups "$(whoami)" | grep -E -q '\b(sudo|wheel)\b' && WHEEL=1

if [ "$WHEEL" -eq 1 ]; then
    echo "[INFO] Running as sudo or wheel group"
else
    echo "[INFO] Not running as sudo or wheel group"
fi

export WHEEL

GUI_SETUP=0

IS_WSL=0
WINDOWS_USER=""
PACKAGE_MANAGER=""

# NOTE: This is NOT a POSIX-compliant way, for POSIX-compliant way, use case/esac
if [[ "$(uname -r)" = *Microsoft* ]]; then
    echo "[INFO] Running on WSL1 Skipping GUI setup"
    IS_WSL=1
    WINDOWS_USER="$(cmd.exe /c "echo %USERNAME%" | tr -d '\r')"
else
    read -p "[ACTION] Do you want to setup Linux GUI? (y/N) " -r choice
    case "$choice" in
    y | Y)
        GUI_SETUP=1
        ;;
    *)
        echo "[INFO] Skipping GUI setup"
        ;;
    esac
fi

export GUI_SETUP

# base-devel

if [ "$WHEEL" -eq 1 ]; then
    echo "[INFO] Installing basic build tools"
    if command -v apt >/dev/null 2>&1; then
        sudo apt update
        sudo apt install -y build-essential
        PACKAGE_MANAGER="apt"
    elif command -v pacman >/dev/null 2>&1; then
        sudo pacman -Syu --noconfirm
        sudo pacman -S --noconfirm base-devel
        PACKAGE_MANAGER="pacman"
    else
        echo "[ERROR] Unsupported package manager"
        exit 1
    fi
fi

echo "[INFO] Cloning Dotfiles"

if [ -d "$DOTFILES" ]; then
    echo "[INFO] Dotfiles already cloned"
elif [ "$IS_WSL" -eq 1 ]; then
    ln -sf "/mnt/c/Users/$WINDOWS_USER/.dotfiles" "$DOTFILES"
elif command -v git >/dev/null 2>&1; then
    git clone https://github.com/js0ny/dotfiles.git "$DOTFILES" --depth 1
else
    echo "[ERROR] Git is not installed"
    exit 1
fi

if [ "$WHEEL" -eq 0 ]; then
    read -p "[ACTION] Do you want to install some AppImages (by AppMan)? (y/N) " -r choice
    case "$choice" in
    y | Y)
        source "$DOTFILES/bootstrap/linux/appman.bash"
        ;;
    *)
        echo "[INFO] Skipping AppMan installation"
        :
        ;;
    esac
fi

echo "[INFO] Setting up symbolic links"

source "$DOTFILES"/bootstrap/linux/symlinks.bash

if [ "$WHEEL" -eq 1 ]; then
    source "$DOTFILES"/tools/bash/xdg-compact.sh
    source "$DOTFILES"/tools/bash/global.bashrc
fi
source "$DOTFILES"/tools/bash/profile
source "$DOTFILES"/tools/bash/bashrc
source "$DOTFILES"/tools/bash/bash_aliases

if command -v zsh >/dev/null 2>&1; then

    read -p "[ACTION] Do you want to setup zsh? (Y/n) " -r choice
    case "$choice" in
    n | N)
        :
        ;;
    *)
        source "$DOTFILES"/bootstrap/components/zsh.sh
        ;;
    esac
fi

if [ "$WHEEL" -eq 0 ]; then
    echo "Done!"
    exit 0
fi

# TODO: Add this part
read -p "[ACTION] Do you want to use other package managers? (y/N) " -r choice
case "$choice" in
y | Y)
    :
    ;;
*)
    :
    ;;
esac

echo "[INFO] Installing Doom Emacs"

source "$DOTFILES"/bootstrap/components/emacs.sh

# TODO: Untestest
if [ "$IS_WSL" -eq 1 ]; then
    ln -sf "/mnt/c/Users/$WINDOWS_USER" "$HOME/winhome"
    ln -sf "/mnt/c/Users/$WINDOWS_USER/Downloads" "$HOME/Downloads"
    ln -sf "/mnt/c/Users/$WINDOWS_USER/Documents" "$HOME/Documents"
    ln -sf "/mnt/c/Users/$WINDOWS_USER/Desktop" "$HOME/Desktop"
    ln -sf "/mnt/c/Users/$WINDOWS_USER/Pictures" "$HOME/Pictures"
    ln -sf "/mnt/c/Users/$WINDOWS_USER/Music" "$HOME/Music"
    ln -sf "/mnt/c/Users/$WINDOWS_USER/Videos" "$HOME/Videos"
fi

if [ "$GUI_SETUP" -eq 0 ]; then
    echo "Done!"
    exit 0
fi

# Wayland

source "$DOTFILES"/bootstrap/linux/chromium-flags.bash

# Rime

source "$DOTFILES"/bootstrap/components/rime.sh

# TODO: Rewrite the script(mocha_port.fish) in bash/zsh or POSIX-compliant shell
echo "[INFO] Installing Color Scheme (Catppuccin Mocha)"

# fish $DOTFILES/bootstrap/temp/mocha_port.fish

source "$DOTFILES"/bootstrap/components/mocha-port.bash

echo "Done!"
