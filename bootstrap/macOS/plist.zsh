## Finder
echo "[INFO] Setting Finder Preferences"
defaults write com.apple.finder QuitMenuItem -bool true         # Quit with CMD+Q
defaults write com.apple.finder ShowPathbar -bool true          # Show Path Bar
defaults write com.apple.finder ShowStatusBar -bool true        # Show Status Bar
defaults write NSGlobalDomain AppleShowAllExtensions -bool true # Show All File Extensions
defaults write com.apple.finder AppleShowAllFiles -bool true    # Show Hidden Files
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
defaults write com.apple.dock autohide-delay -float 0  # Immediately Autohide Dock
defaults write com.apple.dock show-recents -bool false # Hide Recent Applications
killall Dock
## Trackpad
echo "[INFO] Setting Trackpad Preferences"
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write -g NSWindowShouldDragOnGesture -bool true
