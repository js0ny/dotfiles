#!/bin/sh

set -x

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

set +x
