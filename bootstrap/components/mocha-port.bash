#!/usr/bin/env bash
# Adds better error handling and safety features
# shellcheck disable=SC2016

# TODO: UNTESTED
set -e # Exit immediately if a command exits with a non-zero status
set -u # Treat unset variables as an error

# Create temporary working directory
TEMP_DIR="${HOME}/.tmp/catppuccin-install"
mkdir -p "${TEMP_DIR}"

# Create config directories
mkdir -p "${HOME}/.config/tmux/plugins"
mkdir -p "${HOME}/.config/yazi"
mkdir -p "${HOME}/.config/btop/themes"
mkdir -p "${HOME}/.config/git"
mkdir -p "${HOME}/.config/lsd"
mkdir -p "${HOME}/.local/share/mc/skins"
mkdir -p "${HOME}/.config/fish/themes"
mkdir -p "${HOME}/.local/share/fcitx5/themes"

# Function for downloading files
download_file() {
  local url="$1"
  local output_path="$2"
  local output_dir

  # Extract directory from output path
  output_dir=$(dirname "$output_path")

  # Create directory if it doesn't exist
  if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir"
  fi

  # Print status message
  echo "Downloading: $url"
  echo "        to: $output_path"

  # Download with curl (using -L to follow redirects)
  if ! curl -L -s --fail "$url" -o "$output_path"; then
    echo "Error: Failed to download $url" >&2
    return 1
  fi

  # Verify file was downloaded
  if [ ! -f "$output_path" ]; then
    echo "Error: File was not created at $output_path" >&2
    return 1
  fi

  echo "Download successful."
  return 0
}

# Function to check if command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Install Bat themes
if command_exists bat; then
  BAT_CONFIG_DIR=$(bat --config-dir 2>/dev/null || echo "${HOME}/.config/bat")
  mkdir -p "${BAT_CONFIG_DIR}/themes"

  echo "Installing Bat themes..."
  THEMES=("Latte" "Frappe" "Macchiato" "Mocha")

  for theme in "${THEMES[@]}"; do
    download_file "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20${theme}.tmTheme" \
      "${BAT_CONFIG_DIR}/themes/Catppuccin ${theme}.tmTheme"
  done

  echo "Rebuilding Bat cache..."
  bat cache --build || echo "WARNING: Failed to rebuild Bat cache" >&2
else
  echo "Bat not found, skipping Bat themes installation" >&2
fi

# Install Tmux plugin
if command_exists tmux; then
  echo "Installing Tmux plugin..."

  TMUX_PLUGIN_DIR="${HOME}/.config/tmux/plugins/catppuccin"
  rm -rf "${TMUX_PLUGIN_DIR}"
  mkdir -p "${TMUX_PLUGIN_DIR}"

  if command_exists git; then
    if ! git clone -b v2.1.2 --depth=1 https://github.com/catppuccin/tmux.git "${TMUX_PLUGIN_DIR}/tmux" 2>/dev/null; then
      echo "WARNING: Failed to clone Tmux plugin repository" >&2
    fi
  else
    echo "Git not found, skipping Tmux plugin installation" >&2
  fi
else
  echo "Tmux not found, skipping Tmux plugin installation" >&2
fi

# Install Yazi theme
if command_exists yazi; then
  echo "Installing Yazi theme..."
  download_file "https://raw.githubusercontent.com/catppuccin/yazi/main/themes/mocha/catppuccin-mocha-lavender.toml" \
    "${HOME}/.config/yazi/theme.toml"
else
  echo "Yazi not found, skipping Yazi theme installation" >&2
fi

# Install BTopa themes
if command_exists btop; then
  echo "Installing BTopa themes..."
  download_file "https://raw.githubusercontent.com/catppuccin/btop/main/themes/catppuccin_mocha.theme" \
    "${HOME}/.config/btop/themes/catppuccin_mocha.theme"
  download_file "https://raw.githubusercontent.com/catppuccin/btop/main/themes/catppuccin_latte.theme" \
    "${HOME}/.config/btop/themes/catppuccin_latte.theme"
else
  echo "BTopa not found, skipping BTopa themes installation" >&2
fi

# Install Delta config
echo "Installing Delta config..."
download_file "https://raw.githubusercontent.com/catppuccin/delta/main/catppuccin.gitconfig" \
  "${HOME}/.config/git/catppuccin-delta.gitconfig"

# Configure FZF
if command_exists fzf; then
  echo "Configuring FZF..."

  # Check shell type to determine how to set environment variables
  if [ -n "${FISH_VERSION:-}" ] || command_exists fish; then
    # For Fish shell
    fish -c 'set -U FZF_DEFAULT_OPTS "--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 --color=selected-bg:#45475a --multi"' \
      || echo "WARNING: Failed to set FZF options for Fish shell" >&2
  else
    # For Bash/Zsh - add to both .bashrc and .zshrc if they exist
    FZF_CONFIG="export FZF_DEFAULT_OPTS=\"--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 --color=selected-bg:#45475a --multi\""

    # Add to .bashrc if it exists
    if [ -f "${HOME}/.bashrc" ]; then
      if ! grep -q "FZF_DEFAULT_OPTS.*catppuccin" "${HOME}/.bashrc"; then
        echo "${FZF_CONFIG}" >>"${HOME}/.bashrc"
        echo "Added FZF configuration to .bashrc"
      fi
    fi

    # Add to .zshrc if it exists
    if [ -f "${HOME}/.zshrc" ]; then
      if ! grep -q "FZF_DEFAULT_OPTS.*catppuccin" "${HOME}/.zshrc"; then
        echo "${FZF_CONFIG}" >>"${HOME}/.zshrc"
        echo "Added FZF configuration to .zshrc"
      fi
    fi
  fi
else
  echo "FZF not found, skipping FZF configuration" >&2
fi

# Install LSD themes
if command_exists lsd; then
  echo "Installing LSD themes..."
  download_file "https://raw.githubusercontent.com/catppuccin/lsd/main/themes/catppuccin-mocha/colors.yaml" \
    "${HOME}/.config/lsd/colors.yaml"
  download_file "https://raw.githubusercontent.com/catppuccin/lsd/main/themes/catppuccin-latte/colors.yaml" \
    "${HOME}/.config/lsd/colors-light.yaml"
else
  echo "LSD not found, skipping LSD themes installation" >&2
fi

# Install Midnight Commander skin
echo "Installing Midnight Commander skin..."
download_file "https://raw.githubusercontent.com/catppuccin/mc/main/catppuccin.ini" \
  "${HOME}/.local/share/mc/skins/catppuccin.ini"

# Print MC configuration hint
echo "Note: To use the Midnight Commander theme:"
echo "  - Change or add skin=catppuccin in the [Midnight-Commander] section inside ~/.config/mc/ini"
echo "  - OR choose the skin inside Midnight Commander through F9 > Options > Appearance"
echo "  - Save setup through F9 > Options > Save setup"

# Install PowerShell module
if command_exists pwsh; then
  echo "Installing PowerShell module..."
  PS_MODULE_PATH=$(pwsh -C 'Write-Output $Env:PSModulePath.split(":")[0]' 2>/dev/null)

  if [ -n "${PS_MODULE_PATH}" ]; then
    if command_exists git; then
      if ! git clone --depth=1 https://github.com/catppuccin/powershell.git "${PS_MODULE_PATH}/Catppuccin" 2>/dev/null; then
        echo "WARNING: Failed to clone PowerShell module repository" >&2
      fi
    else
      echo "Git not found, skipping PowerShell module installation" >&2
    fi
  else
    echo "PowerShell module path not found, skipping PowerShell module installation" >&2
  fi
else
  echo "PowerShell not found, skipping PowerShell module installation" >&2
fi

# Install Fish themes
if command_exists fish; then
  echo "Installing Fish themes..."
  download_file "https://raw.githubusercontent.com/catppuccin/fish/main/themes/Catppuccin%20Mocha.theme" \
    "${HOME}/.config/fish/themes/Catppuccin Mocha.theme"
  download_file "https://raw.githubusercontent.com/catppuccin/fish/main/themes/Catppuccin%20Latte.theme" \
    "${HOME}/.config/fish/themes/Catppuccin Latte.theme"
else
  echo "Fish not found, skipping Fish themes installation" >&2
fi

# Install Fcitx5 themes
if command_exists fcitx5; then
  echo "Installing Fcitx5 themes..."

  rm -rf "${TEMP_DIR}/fcitx5"
  if command_exists git; then
    if git clone --depth=1 https://github.com/catppuccin/fcitx5.git "${TEMP_DIR}/fcitx5" 2>/dev/null; then
      cp -r "${TEMP_DIR}/fcitx5/src/"* "${HOME}/.local/share/fcitx5/themes/"
    else
      echo "WARNING: Failed to clone Fcitx5 repository" >&2
    fi
  else
    echo "Git not found, skipping Fcitx5 themes installation" >&2
  fi
else
  echo "Fcitx5 not found, skipping Fcitx5 themes installation" >&2
fi

# Clean up temporary directory
rm -rf "${TEMP_DIR}"

echo "Catppuccin themes installation completed!"
