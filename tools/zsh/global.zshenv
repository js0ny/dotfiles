# $DOTFILES/tools/zsh/global.zshenv
# system-wide zshenv file 系统级别的 zshenv 文件，用于设置全局环境变量

# Location:
# /etc/zshenv: (macOS and some distro)
# /etc/zsh/zshenv: (some distro)
# Linking:
# sudo cp $DOTFILES/tools/zsh/global.zshenv /etc/zshenv # or /etc/zsh/zshenv

# Set ZDOTDIR to $HOME/.config/zsh if it exists
# This allows us to keep our zsh configuration in $HOME/.config/zsh
# and zshenv will be located at $HOME/.config/zsh/.zshenv instead of
# $HOME/.zshenv
# 如果存在 $HOME/.config/zsh 目录，则将 ZDOTDIR 设置为 $HOME/.config/zsh
# 防止 .zshenv 文件自动生成在用户目录下

# Ensure SPACE between [ and -d and ]
if [ -d $HOME/.config/zsh ]; then
  export ZDOTDIR=$HOME/.config/zsh
fi
