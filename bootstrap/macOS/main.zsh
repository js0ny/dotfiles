#! /bin/zsh

echo "Running the setup script"

# VARIABLES

export DOTFILES="${DOTFILES:-$HOME/.dotfiles}"


# Xcode Command Line Tools
echo "[INFO] Installing Xcode Command Line Tools"
echo "[ACTION] Request Human Takeover"

xcode-select --install

# Press any key to continue (if Xcode Command Line Tools are installed)
read -n 1 -s -r -p "Press any key to continue when xcode CLI tools are installed"

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

read -n 1 -s -r -p "Press any key to continue when xcode CLI tools are installed"

echo "[INFO] Cloning Dotfiles"

git clone https://github.com/js0ny/dotfiles.git $DOTFILES

echo "[INFO] Setting up system properties"

source $DOTFILES/bootstrap/macOS/plist.zsh

echo "[INFO] Installing Homebrew Packages"

# Load Brewfile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file=$DOTFILES/bootstrap/macOS/Brewfile

# Setting Default Apps

source $DOTFILES/bootstrap/macOS/duti.zsh

# Setting up Dotfiles

source $DOTFILES/bootstrap/macOS/symlinks.zsh
source $DOTFILES/bootstrap/components/zsh.sh

source $DOTFILES/tools/zsh/global.zshenv
source $DOTFILES/tools/zsh/zshenv
source $DOTFILES/tools/zsh/zshrc

# Rime

echo "[INFO] Installing Rime"

git clone --depth 1 https://github.com/js0ny/Rime.git ~/Library/Rime
cd ~/Library/Rime

just set_remote
just clone_plum

echo "[INFO] Installing Doom Emacs"

source $DOTFILES/bootstrap/components/emacs.sh


echo "[INFO] Installing Color Scheme (Catppuccin Mocha)"

fish $DOTFILES/bootstrap/temp/mocha_port.fish

# Misc


dotnet tool install --global dotnet-repl

pnpm install -g typescript
pnpm install -g tsx

echo "Done!"
