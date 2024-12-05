#! /bin/zsh
# $DOTFILES/bootstrap/macOS.zsh
# Run this script to set up macOS
# 运行此脚本以设置 macOS

echo "Running the setup script"

# Xcode Command Line Tools
echo "[INFO] Installing Xcode Command Line Tools"
echo "[ACTION] Request Human Takeover"
xcode-select --install

# Press any key to continue (if Xcode Command Line Tools are installed)
read -n 1 -s -r -p "Press any key to continue when xcode CLI tools are installed"

# System Preferences
# Installation Sources
echo "[INFO] Setting Installation Sources"
# sudo spctl --master-disable
# In Mac OS Sequoia, the command above is not working
# Should be set up manually (System Preferences -> Security & Privacy -> General -> Allow apps downloaded from: Anywhere)
## Finder
echo "[INFO] Setting Finder Preferences"
defaults write com.apple.finder QuitMenuItem -bool true # Quit with CMD+Q
defaults write com.apple.finder AppleShowAllFiles -bool false # Don't show Hidden Files
defaults write com.apple.finder ShowPathbar -bool true  # Show Path Bar
defaults write com.apple.finder ShowStatusBar -bool true # Show Status Bar
defaults write NSGlobalDomain AppleShowAllExtensions -bool true  # Show All File Extensions
defaults write com.apple.finder AppleShowAllFiles -bool true # Show Hidden Files
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Documents" # Open New Finder Windows in Documents
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder FinderSpawnTab -bool true
# Don't show External Hard Drives on Desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
# No DS_Store on Network
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# Keyboard
# Disable Accent Menu
defaults write NSGlobalDomain ApplePressAndHoldEnabled -boolean false
killall Finder
killall Dock
## Dock
echo "[INFO] Setting Dock Preferences"
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock persistent-others -array
defaults write com.apple.dock autohide -bool true # Autohide Dock
defaults write com.apple.dock autohide-time-modifier -float 0.5
defaults write com.apple.dock autohide-delay -float 0 # Immediately Autohide Dock
defaults write com.apple.dock show-recents -bool false # Hide Recent Applications
killall Dock
## Trackpad
echo "[INFO] Setting Trackpad Preferences"
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# Development #
### Dotfiles Setup ###
echo "[INFO] Setting Up Dotfiles"
export DOTFILES="$HOME/.dotfiles"
git clone https://www.github.com/js0ny/dotfiles.git ~/.dotfiles
sudo cp ~/.dotfiles/zsh/.zshenv /etc/zshenv
echo "[INFO] 'source etc/zshenv' to use XDG_CONFIG_HOME"
source /etc/zshenv
    # export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
    # export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
echo "[INFO] Setting Up Zsh for Initial Use"
mkdir -p $ZDOTDIR
ln -sf $DOTFILES/zsh/.zshenv $ZDOTDIR/.zshenv
ln -sf $DOTFILES/mac/.zshrc $ZDOTDIR/.zshrc
mv ~/.zprofile $ZDOTDIR/.zprofile
source $ZDOTDIR/.zshrc
# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mkdir -p $ZDOTDIR/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions $ZDOTDIR/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZDOTDIR/plugins/zsh-syntax-highlighting
source /etc/zshenv
source $ZDOTDIR/.zshrc
rm -f ~/.zshrc ~/.zprofile ~/.zsh_history ~/.zshenv
rm -rf ~/.zsh_sessions

echo "[INFO] Setting Up dotfiles"
. $DOTFILES/setup/set_symblink_unix.sh
# $DOTFILES/mac
ln -sf $DOTFILES/mac/neovide.toml $XDG_CONFIG_HOME/neovide/config.toml
ln -sf $DOTFILES/mac/Microsoft.PowerShell_profile.ps1 $XDG_CONFIG_HOME/powershell/Microsoft.PowerShell_profile.ps1

# Brew
echo "[INFO] Installing Homebrew"
echo "[ACTION] Request Human Input"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "[INFO] Installing Softwares"
# Tap
brew tap daipeihust/tap # for `im-select`
brew tap homebrew/cask-fonts

brew install mas # Mac App Store CLI


# CLI
# brew install --formula cfiles # Not Available
# File Management
brew install --formula bat
brew install --formula fzf
brew install --formula glow # Markdown Preview
brew install --formula less # Pager, overwrites system less, no XDG support
brew install --formula ripgrep
brew install --formula tree
brew install --formula lsd
# Network
brew install --formula wget
brew install --formula wget2
brew install --formula speedtest-cli
# Development
brew install --formula cmake
brew install --formula lazygit
# Shell
brew install --formula starship # Shell Prompt
brew install --formula tmux
brew install --formula zellij
# System Info
brew install --formula fastfetch # 這輩子有了
# Utilities
brew install --formula ffmpeg
brew install --formula daipeihust/tap/im-select # IME Selector (for Vim modes)
brew install --formula pandoc
brew install --formula tldr

# File Management
brew install --cask keka # Archiver
brew install --cask google-drive # `sudo` # Cloud Storage

# Editors
brew install --formula vim # Overwrite System Vim since no XDG support
brew install --cask visual-studio-code
brew install --formula neovim
brew install --formula neovide

# IDE
brew install --cask qt-creator
brew install --cask rider

# Programming Languages
brew install --formula lua
brew install --formula luajit
brew install --formula luarocks
brew install --formula node
brew install --formula dotnet
brew install --formula go
# brew install --formula rust
brew install --cask miniconda

# PowerShells
brew install --cask powershell # `sudo`

# Launchers
brew install --cask raycast
brew install --cask utools

# Terminals
brew install --cask iterm2


# IME
brew install --cask squirrel # `sudo`

# PKM
brew install --cask obsidian
brew install --cask typora
brew install --cask notion
brew install --cask notion-calendar

# Media
brew install --cask iina

# Security
brew install --cask keyguard
brew install --cask protonmail-bridge

# Engineering
brew install --cask ltspice # `sudo`

# Office
brew install --cask mactex-no-gui

# Browser
brew install --cask microsoft-edge # Default
brew install --cask arc
brew install --cask firefox@nightly

# Fonts
brew install --cask font-caskaydia-cove-nerd-font
brew install --cask font-lxgw-wenkai

# Quick Look
brew install --cask qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize suspicious-package apparency quicklookase qlvideo

# Utilities
brew install --cask rustdesk
# brew install --cask logi-options+ # NBCS
mas install 1452453066 # Hidden Bar
brew install ticktick # To-do List
brew install --cask zotero # Reference Manager
brew install --cask betterdisplay
brew install --cask karabiner-elements # Keyboard Customization
brew install --cask scroll-reverser # Let Trackpad and Mouse Scroll in the Same Direction like Windows
# brew install --cask orbstack # VM
# brew install --cask docker
brew install --cask clash-verge-rev
brew install --cask chatbox # LLM API Caller
brew install --cask follow # RSS Reader


# Social
brew install --cask telegram-desktop
mas install 836500024 # WeChat
mas install 451108668 # QQ

# plum (Rime IME)
curl -fsSL https://raw.githubusercontent.com/rime/plum/master/rime-install -o $HOME | bash

# Set default apps (duti)
# The id of the app can be found by running
# `osascript -e 'id of app "AppName"'`
brew install --formula duti
echo "[INFO] Setting Default Apps"
# Markdown -> Typora
duti -s abnerworks.Typora .md all
duti -s abnerworks.Typora .markdown all
# PDF -> Skim
duti -s net.sourceforge.skim-app.skim .pdf all
# Raw Text -> Neovide
duti -s com.neovide.neovide .txt all
# Archive -> Keka
duti -s com.aone.keka .zip all
duti -s com.aone.keka .rar all
duti -s com.aone.keka .7z all
duti -s com.aone.keka .tar all
# Source Code Light -> Neovim
duti -s com.neovide.neovide .gitingore all
duti -s com.neovide.neovide .vimrc all
duti -s com.neovide.neovide .vim all
duti -s com.neovide.neovide .lua all
duti -s com.neovide.neovide .py all
duti -s com.neovide.neovide .jl all
# Source Code Heavy -> VSCode
duti -s com.microsoft.VSCode .c all
# Source Code DOTNET -> VSCode
duti -s com.microsoft.VSCode .cs all
duti -s com.microsoft.VSCode .fs all
duti -s com.microsoft.VSCode .fsx all
duti -s com.microsoft.VSCode .csx all
duti -s com.microsoft.VSCode .ps1 all
# Source Code Web -> VSCode
duti -s com.microsoft.VSCode .js all
duti -s com.microsoft.VSCode .ts all
duti -s com.microsoft.VSCode .jsx all
duti -s com.microsoft.VSCode .tsx all
duti -s com.microsoft.VSCode .css all
duti -s com.microsoft.VSCode .scss all
duti -s com.microsoft.VSCode .sass all
duti -s com.microsoft.VSCode .vue all
# Source Code Config -> Neovim
duti -s com.neovide.neovide .json all
duti -s com.neovide.neovide .yaml all
duti -s com.neovide.neovide .yml all
duti -s com.neovide.neovide .toml all
duti -s com.neovide.neovide .ini all
duti -s com.neovide.neovide .cfg all
duti -s com.neovide.neovide .conf all
duti -s com.neovide.neovide .kdl all
duti -s com.neovide.neovide .xml all
# Source Code Jupyter -> VSCode
duti -s com.microsoft.VSCode .ipynb all
# Source Code DotNet Project -> Rider
duti -s com.jetbrains.rider .sln all
duti -s com.jetbrains.rider .csproj all
duti -s com.jetbrains.rider .fsproj all
# Video -> IINA
duti -s com.colliderli.iina .mp4 all
duti -s com.colliderli.iina .mkv all

mkdir -p $DOTFILES/powershell_private

mkdir -p ~/Documents/Source/Forks
mkdir -p ~/Documents/Source/Projects
mkdir -p ~/Documents/Source/Scripts
mkdir -p ~/Documents/Source/Tutorials
