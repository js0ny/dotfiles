#!/bin/bash
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

if [ "$(uname -r)" = *Microsoft* ]; then
  echo "[INFO] Running on WSL1 Skipping GUI setup"
else
  read -p "[ACTION] Do you want to setup Linux GUI? (y/N) " choice
  case "$choice" in
    y|Y)
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
  if [ command -v apt ]; then
    sudo apt update
    sudo apt install -y build-essential
  elif [ command -v pacman ]; then
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm base-devel
  else
    echo "[ERROR] Unsupported package manager"
    exit 1
  fi
fi

echo "[INFO] Cloning Dotfiles"

if [ -d "$DOTFILES" ]; then
  echo "[INFO] Dotfiles already cloned"
elif [ command -v git ]; then
  git clone https://github.com/js0ny/dotfiles.git "$DOTFILES" --depth 1
else
  echo "[ERROR] Git is not installed"
  exit 1
fi

if [ "$WHEEL" -eq 0 ]; then
  read -p "[ACTION] Do you want to install some AppImages (by AppMan)? (y/N) " choice
  case "$choice" in
    y|Y)
        source "$DOTFILES/bootstrap/linux/appman.bash"
      ;;
    *)
      echo "[INFO] Skipping AppMan installation"
      :
      ;;
  esac
fi

echo "[INFO] Setting up symbolic links"

source $DOTFILES/bootstrap/linux/symlinks.bash

if [ "$WHEEL" -eq 1 ]; then
  source $DOTFILES/tools/bash/xdg-compact.sh
  source $DOTFILES/tools/bash/global.bashrc
fi
source $DOTFILES/tools/bash/profile
source $DOTFILES/tools/bash/bashrc
source $DOTFILES/tools/bash/bash_aliases

if [ command -v zsh ]; then
  read -p "[ACTION] Do you want to setup zsh? (Y/n) " choice
  case "$choice" in
    n|N)
      :
      ;;
    *)
      source $DOTFILES/bootstrap/components/zsh.sh
      ;;
  esac
fi


if [ "$WHEEL" -eq 0 ]; then
  echo "Done!"
  exit 0
fi

read -p "[ACTION] Do you want to use other package managers? (y/N) " choice
case "$choice" in
  y|Y)
    :
    ;;
  *)
    :
    ;;
esac

echo "[INFO] Installing Doom Emacs"

source $DOTFILES/bootstrap/components/emacs.sh

if [ "$GUI_SETUP" -eq 0 ]; then
  echo "Done!"
  exit 0
fi

# Wayland

source $DOTFILES/bootstrap/linux/chromium-flags.sh

# Rime

source $DOTFILES/bootstrap/components/rime.sh

# TODO: Rewrite the script(mocha_port.fish) in bash/zsh or POSIX-compliant shell
echo "[INFO] Installing Color Scheme (Catppuccin Mocha)"

fish $DOTFILES/bootstrap/temp/mocha_port.fish


echo "Done!"
