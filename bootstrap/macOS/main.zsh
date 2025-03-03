#! /bin/zsh

echo "Running the setup script"
set -e
set -x

# VARIABLES

export DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

# In macOS, consider the user as sudoer by default
export WHEEL=1
export GUI_SETUP=1

# Xcode Command Line Tools
echo "[INFO] Installing Xcode Command Line Tools"
echo "[ACTION] Request Human Takeover"

xcode-select --install

# Press any key to continue (if Xcode Command Line Tools are installed)
echo "[ACTION] Press any key to continue when xcode CLI tools are installed"
read -n 1

# System Preferences
# Installation Sources
echo "[INFO] Setting Installation Sources"
echo "[ACTION] Request Human Takeover"
echo "In macOS Sequoia, setup manually (System preferences -> Security & Privacy -> General -> Allow apps downloaded from: Anywhere)"
# sudo spctl --master-disable
# In Mac OS Sequoia, the command above is not working
# Should be set up manually (System Preferences -> Security & Privacy -> General -> Allow apps downloaded from: Anywhere)

echo "[INFO] Installing Homebrew"
echo "[ACTION] Request Human Input"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "[ACTION] Press any key to continue when xcode CLI tools are installed"
read -n 1

echo "[INFO] Cloning Dotfiles"

git clone https://github.com/js0ny/dotfiles.git $DOTFILES

echo "[INFO] Setting up system properties"

source $DOTFILES/bootstrap/macOS/plist.zsh

read -p "[ACTION] Do you want to use sudo with touch ID? (Y/n) " -r choice
case "$choice" in
  n | N)
    :
    ;;
  *)
    # Use `sudo cp` to prevent losing sudo access
    sudo cp /etc/pam.d/sudo /etc/pam.d/sudo.bak
    sudo cp $DOTFILES/platforms/mac/etc/pam.d/sudo /etc/pam.d/sudo
    ;;
esac

echo "[INFO] Installing Homebrew Packages"

# Load Brewfile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file=$DOTFILES/bootstrap/macOS/Brewfile

# Setting up emacs
ln -s /usr/local/opt/emacs-mac/Emacs.app /Applications/Emacs.app

# Setting Default Apps

source $DOTFILES/bootstrap/macOS/duti.zsh

# Setting up Dotfiles

source $DOTFILES/bootstrap/macOS/symlinks.zsh
source $DOTFILES/bootstrap/components/zsh.sh

source $DOTFILES/tools/zsh/global.zshenv
source $DOTFILES/tools/zsh/zshenv
source $DOTFILES/tools/zsh/zshrc

# Rime

source $DOTFILES/bootstrap/components/rime.sh

echo "[INFO] Installing Doom Emacs"

source $DOTFILES/bootstrap/components/emacs.sh

echo "[INFO] Installing Color Scheme (Catppuccin Mocha)"

fish $DOTFILES/bootstrap/temp/mocha_port.fish

# Misc

dotnet tool install --global dotnet-repl

pnpm install -g typescript
pnpm install -g tsx

echo "Done!"
