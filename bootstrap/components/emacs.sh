#!/bin/sh
# shellcheck shell=sh
echo "[INFO] Installing DOOM Emacs"
echo "[ACTION] Request Human Takeover"
test -d ~/.config/emacs && mv ~/.config/emacs ~/.config/emacs.bak
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
~/.config/emacs/bin/doom sync

echo "[INFO] Installing Emacs-Rime"
git clone --depth 1 https://github.com/js0ny/Rime.git ~/.config/emacs/.local/cache/rime
