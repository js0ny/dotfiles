#!/usr/bin/env bash
# shellcheck disable=SC1090 shell=sh
# Date: 2025-02-11
# Author: js0ny
# IMPORTANT: The default `bash` in macOS is outdated, run with zsh or install the latest `bash` via Homebrew
# If you are macOS, run `xcode select --install` first

set -o errexit
set -o xtrace

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

mkdir -p ~/.local/.tmp

export DOTFILES

case "$(uname)" in
  Linux)
    curl https://raw.githubusercontent.com/js0ny/dotfiles/refs/heads/master/bootstrap/linux/main.bash -o ~/.local/.tmp/main.bash
    source ~/.local/.tmp/main.bash
    rm -rf ~/.local/.tmp/main.bash
    ;;
  Darwin)
    curl https://raw.githubusercontent.com/js0ny/dotfiles/refs/heads/master/bootstrap/macOS/main.zsh -o ~/.local/.tmp/main.zsh
    zsh ~/.local/.tmp/main.zsh
    rm -rf ~/.local/.tmp/main.zsh
    ;;
esac
