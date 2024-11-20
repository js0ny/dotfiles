# $DOTFILES/zsh/update.sh

# This file won't be sourced by zsh by default
# Use `source` to run this file for updating plugins

# Plugins #
# Auto `git pull` on $ZDOTDIR/plugins
for plugin in $ZDOTDIR/plugins/*; do
  if [ -d "$plugin" ]; then
    cd $plugin
    git pull --quiet --no-edit
  fi
done

if [ which brew > /dev/null ]; then
  brew update
  brew upgrade
fi