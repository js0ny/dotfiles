# $DOTFILES/scripts/update.zsh
# call by `update` alias defined in tools/zsh/alias.zsh
# 使用别名 `update` 引用，别名定义于 tools/zsh/alias.zsh

# Plugins #
# Auto `git pull` on $ZDOTDIR/plugins
for plugin in $ZDOTDIR/plugins/*; do
  if [ -d "$plugin" ]; then
    cd $plugin
    git pull --quiet --no-edit
  fi
done

# Update package managers #
# Homebrew, macOS
if command -v brew > /dev/null; then
  brew update
  brew upgrade
fi

# Arch
if command -v pacman > /dev/null; then
  sudo pacman -Syu
fi

# Debian
if command -v apt > /dev/null; then
  sudo apt update
  sudo apt upgrade
fi

# Fedora
if command -v dnf > /dev/null; then
  sudo dnf update
fi

# WSL
if command -v winget.exe > /dev/null; then
  winget.exe upgrade
fi
