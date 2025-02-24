#!/usr/bin/env bash
# vim:ft=bash
echo "[INFO] Installing AppMan"
echo "[ACTION] Type [2] to install AppMan"
wget -q https://raw.githubusercontent.com/ivan-hc/AM/main/AM-INSTALLER && chmod a+x ./AM-INSTALLER && ./AM-INSTALLER

APPMAN_PATH="$HOME/.local/bin/appman"

if command -v $APPMAN_PATH >/dev/null 2>&1; then
  $APPMAN_PATH install wezterm
  $APPMAN_PATH install nvim
fi
