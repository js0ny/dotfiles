#!/usr/bin/env bash
# vim:ft=bash
# chromium-flags.sh
# Set Chromium & Electron Flags

echo "[INFO] Set Chromium & Electron Flags"

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
BROWSER_FLAG=$DOTFILES/platforms/linux/chromium-flags.conf
ELECTRON_FLAG=$DOTFILES/platforms/linux/electron-flags.conf


parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            # --debug|-d)
            #     export LOG_LEVEL="DEBUG"
            #     log_debug "Debug mode enabled"
            #     shift
            #     ;;
            --force|-f)
                FORCE_FILE="true"
                echo "Force update enabled"
                shift
                ;;
            *)
                echo "Unknown argument: $1"
                echo "Usage: chromium-flags.sh [--debug|-d] [--force|-f]"
                exit 1
                ;;
        esac
    done
}

parse_args "$@"

# Browser Flags

browser_flags_path=(
  "$XDG_CONFIG_HOME/chromium-flags.conf" # Chromium
  "$XDG_CONFIG_HOME/chrome-flags.conf"   # Google Chrome
  "$XDG_CONFIG_HOME/thorium-flags.conf"  # Thorium
  "$XDG_CONFIG_HOME/vivaldi-flags.conf"  # Vivaldi
  "$XDG_CONFIG_HOME/vivaldi-stable.conf" # Vivaldi

)

electron_flags_path=(
  "$XDG_CONFIG_HOME/electron-flags.conf"    # General
  "$XDG_CONFIG_HOME/code-flags.conf"        # VSCode
  "$XDG_CONFIG_HOME/qq-electron-flags.conf" # QQ
)

for path in "${browser_flags_path[@]}"; do
  if [ -f "$path" ] && [ "$FORCE_FILE" != "true" ]; then
    echo "[INFO] Found Browser Flags: $path"
  else
    echo "[INFO] Creating Browser Flags: $path"
    ln -sf "$BROWSER_FLAG" "$path"
  fi
done

for path in "${electron_flags_path[@]}"; do
  if [ -f "$path" ] && [ "$FORCE_FILE" != "true" ]; then
    echo "[INFO] Found Electron Flags: $path"
  else
    echo "[INFO] Creating Electron Flags: $path"
    ln -sf "$ELECTRON_FLAG" "$path"
  fi
done
