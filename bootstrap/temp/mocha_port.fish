# Bat
mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
bat cache --build
# Tmux
mkdir -p ~/.config/tmux/plugins/catppuccin:w
git clone -b v2.1.2 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
# Yazi
curl https://raw.githubusercontent.com/catppuccin/yazi/refs/heads/main/themes/mocha/catppuccin-mocha-lavender.toml -o ~/.config/yazi/theme.toml
# BTop
curl https://raw.githubusercontent.com/catppuccin/btop/refs/heads/main/themes/catppuccin_mocha.theme -o ~/.config/btop/themes/catppuccin_mocha.theme
curl https://raw.githubusercontent.com/catppuccin/btop/refs/heads/main/themes/catppuccin_latte.theme -o ~/.config/btop/themes/catppuccin_latte.theme
# Delta
curl https://raw.githubusercontent.com/catppuccin/delta/refs/heads/main/catppuccin.gitconfig -o ~/.config/git/catppuccin-delta.gitconfig
# Fzf
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"
# LsD
curl https://raw.githubusercontent.com/catppuccin/lsd/refs/heads/main/themes/catppuccin-mocha/colors.yaml -o ~/.config/lsd/colors.yaml
curl https://raw.githubusercontent.com/catppuccin/lsd/refs/heads/main/themes/catppuccin-latte/colors.yaml -o ~/.config/lsd/colors-light.yaml
# Midnight Commander
# Change or add skin=catppuccin in the [Midnight-Commander] section inside ~/.config/mc/ini OR Choose the skin inside Midnight Commander through F9>Options>Appearance and Save setup through F9>Options/Save setup
mkdir -p $HOME/.local/share/mc/skins
curl https://raw.githubusercontent.com/catppuccin/mc/refs/heads/main/catppuccin.ini -o $HOME/.local/share/mc/skins/catppuccin.ini
# PowerShell
pwsh -C 'git clone https://github.com/catppuccin/powershell.git (Join-Path $Env:PSModulePath.split(":")[0] Catppuccin)'
# Fish
mkdir -p ~/.config/fish/themes
curl https://raw.githubusercontent.com/catppuccin/fish/refs/heads/main/themes/Catppuccin%20Mocha.theme -o ~/.config/fish/themes/Catppuccin\ Mocha.theme
curl https://raw.githubusercontent.com/catppuccin/fish/refs/heads/main/themes/Catppuccin%20Latte.theme -o ~/.config/fish/themes/Catppuccin\ Latte.theme
