#!/usr/bin/env bash
# Date: 2025-02-11
# Author: js0ny
# IMPORTANT: The default `bash` in macOS is outdated, run with zsh or install the latest `bash` via Homebrew
# If you are macOS, run `xcode select --install` first

set -e # Exit immediately if a command exits with a non-zero status

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

mkdir -p ~/.local/.tmp

export DOTFILES

case "$(uname)" in
  Linux)
  :
  Darwin)
  curl https://raw.githubusercontent.com/js0ny/dotfiles/refs/heads/master/bootstrap/macOS/main.zsh -o ~/.local/.tmp/main.zsh
  zsh ~/.local/.tmp/main.zsh
  rm -rf ~/.local/.tmp/main.zsh
esac
