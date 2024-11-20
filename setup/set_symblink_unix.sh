#! /bin/sh
mkdir -p $XDG_CONFIG_HOME/conda $XDG_CONFIG_HOME/git $XDG_CONFIG_HOME/ideavim $XDG_CONFIG_HOME/markdownlint $XDG_CONFIG_HOME/pip $XDG_CONFIG_HOME/neovide $XDG_CONFIG_HOME/powershell $XDG_CONFIG_HOME/vscode $XDG_CONFIG_HOME/NuGet $XDG_CONFIG_HOME/vim $XDG_CONFIG_HOME/tmux $XDG_CONFIG_HOME/npm
mkdir -p ~/.config/zellij # Not support XDG_CONFIG_HOME but same directory
mkdir -p $WAKATIME_HOME
mkdir -p $XDG_STATE_HOME/vim/undo $XDG_STATE_HOME/vim/backup $XDG_STATE_HOME/vim/swap  $XDG_STATE_HOME/vim/view
# $DOTFILES/.config
ln -sf $DOTFILES/.config/conda/condarc.yaml $XDG_CONFIG_HOME/conda/.condarc
ln -sf $DOTFILES/.config/git/.gitconfig $XDG_CONFIG_HOME/git/config
ln -sf $DOTFILES/.config/ideavim/ideavimrc.vimrc $XDG_CONFIG_HOME/ideavim/ideavimrc
ln -sf $DOTFILES/.config/markdownlint/.markdownlint.json $XDG_CONFIG_HOME/markdownlint/markdownlint.json
ln -sf $DOTFILES/.config/npm/npmrc $NPM_CONFIG_USERCONFIG
ln -sf $DOTFILES/.config/NuGet/NuGet.Config $XDG_CONFIG_HOME/NuGet/NuGet.Config
ln -sf $DOTFILES/.config/nvim/ $XDG_CONFIG_HOME/nvim
ln -sf $DOTFILES/.config/pip/pip.conf $XDG_CONFIG_HOME/pip/pip.conf
ln -sf $DOTFILES/.config/tmux/tmux.conf $XDG_CONFIG_HOME/tmux/tmux.conf
ln -sf $DOTFILES/.config/vim/vimrc $XDG_CONFIG_HOME/vim/vimrc
ln -sf $DOTFILES/.config/zellij/config.kdl ~/.config/zellij/config.kdl
ln -sf $DOTFILES/.config/lesskey $XDG_CONFIG_HOME/lesskey
# $DOTFILES/vscode
ln -sf $DOTFILES/vscode/vscode.vimrc $XDG_CONFIG_HOME/vscode.vimrc
# $DOTFILES root
ln -sf $DOTFILES/.haskeline ~/.haskeline