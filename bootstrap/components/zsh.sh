WHEEL="${WHEEL:-1}"

echo "[INFO] ZDOTDIR = $ZDOTDIR"
echo "[INFO] DOTFILES = $DOTFILES"
echo "[INFO] WHEEL = $WHEEL"

echo "[ACTION] Press any key to proceed"
read -n 1

if [ "$WHEEL" -eq 1 ]; then
  echo "[INFO] Setting up system-wide zsh configuration"
  echo "[ACTION] Elevation required"
  test -f "/etc/zsh/zshenv" && sudo cp "$DOTFILES/tools/zsh/global.zshenv" "/etc/zsh/zshenv"
  test -f "/etc/zshenv" && sudo cp "$DOTFILES/tools/zsh/global.zshenv" "/etc/zshenv"
  if [ $(uname) = "Darwin" ]; then
    sudo cp "$DOTFILES/tools/zsh/global.zshenv" "/etc/zshenv"
  fi
else
  echo "[INFO] Setting up user zsh configuration"
  # A fallback case to set $ZDOTDIR in ~/.zshenv if the user cannot access global zshenv
  ln -sf "$DOTFILES/tools/zsh/zshenv" "$HOME/.zshenv"
fi

echo "[INFO] Installing zsh plugins"
test -d $ZDOTDIR/plugins/zsh-autosuggestions || git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git $ZDOTDIR/plugins/zsh-autosuggestions
test -d $ZDOTDIR/plugins/zsh-syntax-highlighting || git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZDOTDIR/plugins/zsh-syntax-highlighting
test -d $ZDOTDIR/plugins/zsh-history-substring-search || git clone --depth 1 https://github.com/zsh-users/zsh-history-substring-search.git $ZDOTDIR/plugins/zsh-history-substring-search
test -d $ZDOTDIR/plugins/zsh-completions || git clone --depth 1 https://github.com/zsh-users/zsh-completions.git $ZDOTDIR/plugins/zsh-completions
