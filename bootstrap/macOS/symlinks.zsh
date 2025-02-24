set -e # Exit immediately if a command exits with a non-zero status

# 声明为关联数组
typeset -A linkDots

# 从通用配置文件加载
source "$DOTFILES/bootstrap/components/symlinks.bash"

echo "[INFO] DOTFILES = $DOTFILES"

echo "[ACTION] Press any key to proceed"
read -n 1

echo "[INFO] Setting up symbolic links"
# 使用 zsh 的关联数组语法
for src in ${(k)linkDots}; do
  dest="${linkDots[$src]}"
  echo "Linking $src to $dest"
  if [ -d "$src" ]; then
    test -d $dest && mv $dest $dest.bak
    ln -sf $src $dest
  elif [ -f "$src" ]; then
    dest_parent=$(dirname $dest)
    test -d $dest_parent || mkdir -p $dest_parent
    ln -sf $src $dest
  else
    echo "[ERROR] $src does not exist"
  fi
done
