# $DOTFILES/tools/bash/xdg-compat.sh
# Author: js0ny
# Date: 2025-01-28
# Sourced by /etc/profile

# Location: /etc/profile.d/xdg-compat.sh
# cp $DOTFILES/tools/bash/xdg-compat.sh /etc/profile.d/xdg-compat.sh

# Set XDG Base Directory Path
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

# Source user's XDG-compliant Bash configs
if [ -f "$XDG_CONFIG_HOME/bash/profile" ]; then
  . "$XDG_CONFIG_HOME/bash/profile"
fi
