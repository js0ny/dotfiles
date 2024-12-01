#! /bin/bash
# $DOTFILES/bootstrap/set_symlink_unix.bash
# Date: 2024-12-01
# Author: contact@js0ny.net
# Set symlinks for Unix-like operating systems
mkdir -p $XDG_CONFIG_HOME/conda $XDG_CONFIG_HOME/git $XDG_CONFIG_HOME/ideavim $XDG_CONFIG_HOME/markdownlint $XDG_CONFIG_HOME/pip $XDG_CONFIG_HOME/neovide $XDG_CONFIG_HOME/powershell $XDG_CONFIG_HOME/vscode $XDG_CONFIG_HOME/NuGet $XDG_CONFIG_HOME/vim $XDG_CONFIG_HOME/tmux $XDG_CONFIG_HOME/npm $XDG_CONFIG_HOME/readline $XDG_CONFIG_HOME/ipython
mkdir -p ~/.config/zellij # Not support XDG_CONFIG_HOME but same directory
# mkdir -p $WAKATIME_HOME
# mkdir -p $XDG_STATE_HOME/vim/undo $XDG_STATE_HOME/vim/backup $XDG_STATE_HOME/vim/swap  $XDG_STATE_HOME/vim/view
mkdir -p $HOME/Obsidian
# $DOTFILES/common
ln -sf $DOTFILES/common/condarc.yaml $XDG_CONFIG_HOME/conda/.condarc
ln -sf $DOTFILES/common/gitconfig $XDG_CONFIG_HOME/git/config
ln -sf $DOTFILES/common/glow.yaml ~/.config/glow/config.yml
ln -sf $DOTFILES/common/haskeline ~/.haskeline
ln -sf $DOTFILES/common/ideavimrc $XDG_CONFIG_HOME/ideavim/ideavimrc
ln -sf $DOTFILES/common/inputrc $XDG_CONFIG_HOME/readline/inputrc
ln -sf $DOTFILES/common/lesskey $XDG_CONFIG_HOME/lesskey
ln -sf $DOTFILES/common/npmrc $NPM_CONFIG_USERCONFIG
ln -sf $DOTFILES/common/NuGet.Config $XDG_CONFIG_HOME/NuGet/NuGet.Config
ln -sf $DOTFILES/common/obsidian.vimrc $HOME/Obsidian/.obsidian.vimrc
ln -sf $DOTFILES/common/pip.conf $XDG_CONFIG_HOME/pip/pip.conf
ln -sf $DOTFILES/common/tmux.conf $XDG_CONFIG_HOME/tmux/tmux.conf
ln -sf $DOTFILES/common/vimrc $XDG_CONFIG_HOME/vim/vimrc
ln -sf $DOTFILES/common/zellij.config.kdl ~/.config/zellij/config.kdl
# $DOTFILES/tools
ln -sf $DOTFILES/tools/ipython $XDG_CONFIG_HOME/ipython
ln -sf $DOTFILES/tools/nvim $XDG_CONFIG_HOME/nvim

if [ $(uname) = "Darwin"]; then
    mkdir -p ~/.config/karabiner $XDG_CONFIG_HOME/skhd $XDG_CONFIG_HOME/yabai $XDG_CONFIG_HOME/sketchybar
    ln -sf $DOTFILES/platforms/mac/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
    ln -sf $DOTFILES/platforms/mac/skhdrc $XDG_CONFIG_HOME/skhd/skhdrc
    ln -sf $DOTFILES/platforms/mac/sketchybarrc $XDG_CONFIG_HOME/sketchybar/sketchybarrc
    ln -sf $DOTFILES/platforms/mac/yabairc $XDG_CONFIG_HOME/yabai/yabairc
fi
