#! /bin/zsh
# This script is used to setup a new mac

# Xcode Command Line Tools 
xcode-select --install

# System Preferences 
# Installation Sources
sudo spctl --master-disable
## Finder
defaults write com.apple.finder QuitMenuItem -bool true # Quit with CMD+Q
defaults write com.apple.finder AppleShowAllFiles -bool false # Don't show Hidden Files
defaults write com.apple.finder ShowPathbar -bool true  # Show Path Bar
defaults write com.apple.finder ShowStatusBar -bool true # Show Status Bar
defaults write NSGlobalDomain AppleShowAllExtensions -bool true  # Show All File Extensions
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
killall Finder
## Dock
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock persistent-others -array
defaults write com.apple.dock autohide -bool true # Autohide Dock
defaults write com.apple.dock autohide-time-modifier -float 0.5 
defaults write com.apple.dock autohide-delay -float 0 # Immediately Autohide Dock
defaults write com.apple.dock show-recents -bool false # Hide Recent Applications
## Trackpad
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# Development #
### Dotfiles Setup ###
export $DOTFILES="$HOME/.dotfiles"
git clone https://www.github.com/js0ny/dotfiles.git $DOTFILES
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
ln -s $DOTFILES/.condarc ~/.condarc
ln -s $DOTFILES/.gitconfig ~/.gitconfig
ln -s $DOTFILES/.haskeline ~/.haskeline
ln -s $DOTFILES/.ideavimrc ~/.ideavimrc
ln -s $DOTFILES/.tmux.conf ~/.tmux.conf
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install mas # Mac App Store CLI

# File Management
brew install --cask keka # Archive
brew install --cask google-drive # Cloud Storage

# CLI
brew install --formula cfiles
brew install --formula fastfetch # 這輩子有了
brew install --formula fzf
brew install --formula ffmpeg
brew install --formula im-select # Switch IME (For Vim)
brew install --formula lazygit
brew install --formula ripgrep
brew install --formula tmux
brew install --formula tree
brew install --formula pandoc

# Editors
brew install --cask visual-studio-code
brew install --formula neovim
brew install --formula neovide

# Programming Languages
brew install --formula lua
brew install --formula luajit
brew install --formula node
brew install --formula dotnet
# brew install --formula rust
brew install --cask miniconda

# PowerShells
brew install --cask powershell

# Launchers
brew install --cask raycast
brew install --cask utools

# Terminals
brew install --cask iterm2

brew install --cask follow
brew install --formula dotnet

# IME
brew install --cask squirrel

# PKM
brew install --cask obsidian
brew install --cask typora

# Media
brew install --cask iina

# Security
brew install --cask keyguard

# Engineering
brew install --cask ltspice

# Office
brew install --cask mactex-no-gui

# Browser
brew install --cask arc
brew install --cask firefox@nightly

# Fonts
brew tap homebrew/cask-fonts
brew install --cask font-caskaydia-cove-nerd-font
brew install --cask font-lxgw-wenkai
brew install --cask clash-verge-rev

# Quick Look
brew install --cask qlmarkdown

# Utilities
brew install --cask rustdesk
brew install --cask logi-options+
mas install 1452453066 # Hidden Bar
brew install ticktick # To-do List
brew install --cask zotero # Reference Manager
brew install --cask betterdisplay
brew install --cask karabiner-elements # Keyboard Customization
brew install --cask scroll-reverser # Let Trackpad and Mouse Scroll in the Same Direction like Windows
# brew install --cask orbstack # VM


# Social
brew install --cask telegram-desktop
mas install 836500024 # WeChat
mas install 451108668 # QQ

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo rm -rf ~/.zshrc
mkdir -p ~/.config/zsh
ln -s $DOTFILES/zsh/.zshenv ~/.zshenv
ln -s $DOTFILES/mac/.zshrc ~/.config/zsh/.zshrc
source ~/.config/zsh/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting