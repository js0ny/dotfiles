#! /bin/zsh
# This script is used to setup a new mac
# In a new mac (Sequoia)
# Enter the following command in the terminal
#! curl -fsSL https://raw.githubusercontent.com/js0ny/dotfiles/refs/heads/master/mac/mac_setup.sh | sh

echo "Running the setup script"

# Xcode Command Line Tools 
echo "[INFO] Installing Xcode Command Line Tools"
echo "[ACTION] Request Human Takeover"
xcode-select --install

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
echo "[INFO] Setting Dock Preferences"
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock persistent-others -array
defaults write com.apple.dock autohide -bool true # Autohide Dock
defaults write com.apple.dock autohide-time-modifier -float 0.5 
defaults write com.apple.dock autohide-delay -float 0 # Immediately Autohide Dock
defaults write com.apple.dock show-recents -bool false # Hide Recent Applications
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
ln -sf $DOTFILES/zsh/.zshenv ~/.zshenv
echo "[INFO] 'source ~/.zshenv' to use XDG_CONFIG_HOME"
source ~/.zshenv
    # export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
    # export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
echo "[INFO] Setting Up Oh-My-Zsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -sf $DOTFILES/zsh/.zshenv ~/.zshenv
ln -sf $DOTFILES/mac/.zshrc $XDG_CONFIG_HOME/zsh/.zshrc
source $XDG_CONFIG/zsh/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting
source $XDG_CONFIG_HOME/zsh/.zshrc

echo "[INFO] Setting Up dotfiles"
mkdir -p $XDG_CONFIG_HOME/conda $XDG_CONFIG_HOME/git $XDG_CONFIG_HOME/ideavim $XDG_CONFIG_HOME/markdownlint $XDG_CONFIG_HOME/pip $XDG_CONFIG_HOME/neovide $XDG_CONFIG_HOME/powershell $XDG_CONFIG_HOME/vscode $XDG_CONFIG_HOME/NuGet
mkdir -p ~/.config/zellij # Not support XDG_CONFIG_HOME but same directory
# $DOTFILES/.config
ln -sf $DOTFILES/.config/conda/condarc.yaml $XDG_CONFIG_HOME/conda/.condarc
ln -sf $DOTFILES/.config/git/.gitconfig $XDG_CONFIG_HOME/git/config
ln -sf $DOTFILES/.config/ideavim/ideavimrc.vimrc $XDG_CONFIG_HOME/ideavim/ideavimrc
ln -sf $DOTFILES/.config/markdownlint/.markdownlint.json $XDG_CONFIG_HOME/markdownlint/markdownlint.json
ln -sf $DOTFILES/.config/NuGet/NuGet.Config $XDG_CONFIG_HOME/NuGet/NuGet.Config
ln -sf $DOTFILES/.config/nvim/ $XDG_CONFIG_HOME/nvim
ln -sf $DOTFILES/.config/pip/pip.conf $XDG_CONFIG_HOME/pip/pip.conf
ln -sf $DOTFILES/.config/zellij/config.kdl ~/.config/zellij/config.kdl
# $DOTFILES/mac
ln -sf $DOTFILES/mac/neovide.toml $XDG_CONFIG_HOME/neovide/config.toml
ln -sf $DOTFILES/mac/Microsoft.PowerShell_profile.ps1 $XDG_CONFIG_HOME/powershell/Microsoft.PowerShell_profile.ps1
# $DOTFILES/vscode
ln -sf $DOTFILES/vscode/vscode.vimrc $XDG_CONFIG_HOME/vscode.vimrc
# $DOTFILES root
ln -sf $DOTFILES/.haskeline ~/.haskeline
ln -sf $DOTFILES/.npmrc ~/.npmrc
ln -sf $DOTFILES/.tmux.conf ~/.tmux.conf

# Brew
echo "[INFO] Installing Homebrew"
echo "[ACTION] Request Human Input"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "[INFO] Installing Softwares"
brew install mas # Mac App Store CLI

# File Management
brew install --cask keka # Archiver
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
brew install --formula zellij # Better Tmux for me
brew install --formula wget
brew install --formula wget2
brew install --formula speedtest-cli

# Editors
brew install --cask visual-studio-code
brew install --formula neovim
brew install --formula neovide

# IDE
brew install --cask qt-creator
brew install --cask rider

# Programming Languages
brew install --formula lua
brew install --formula luajit
brew install --formula node
brew install --formula dotnet
brew install --formula go
# brew install --formula rust
brew install --cask miniconda

# PowerShells
brew install --cask powershell

# Launchers
brew install --cask raycast
brew install --cask utools

# Terminals
brew install --cask iterm2


# IME
brew install --cask squirrel

# PKM
brew install --cask obsidian
brew install --cask typora
brew install --cask notion
brew install --cask notion-calendar

# Media
brew install --cask iina

# Security
brew install --cask keyguard

# Engineering
brew install --cask ltspice

# Office
brew install --cask mactex-no-gui

# Browser
brew install --cask edge # Default
brew install --cask arc
brew install --cask firefox@nightly

# Fonts
brew tap homebrew/cask-fonts
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
curl -fsSL https://raw.githubusercontent.com/rime/plum/master/rime-install | bash

# Set default apps (duti)
# The id of the app can be found by running 
# `osascript -e 'id of app "AppName"'`
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