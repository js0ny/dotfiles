ideavim:
    {{LN}} {{DOTFILES}}/common/ideavimrc {{XDG_CONFIG_HOME}}/ideavim/ideavimrc
    git clone https://github.com/MarcoIeni/intellimacs {{join(home_directory(), ".local/share/intellimacs")}} --depth 1

lsd:
    -mkdir {{XDG_CONFIG_HOME}}/lsd
    {{LN}} {{DOTFILES}}/common/lsd.yaml {{XDG_CONFIG_HOME}}/lsd/config.yaml

bat:
    mkdir -p "$(bat --config-dir)/themes"
    wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
    wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
    wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
    wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
    {{LN}} {{DOTFILES}}/common/bat.config.dark {{DOTFILES}}/common/bat.config
    {{LN}} {{DOTFILES}}/common/bat.config {{XDG_CONFIG_HOME}}/bat/config

[unix]
neovide:
    which neovide
    -mkdir -p {{XDG_CONFIG_HOME}}/neovide
    {{LN}} {{DOTFILES}}/platforms/{{OS}}/neovide.toml {{XDG_CONFIG_HOME}}/neovide/config.toml


[linux]
readline:
    mkdir -p {{XDG_CONFIG_HOME}}/readline
    {{LN}} {{DOTFILES}}/common/inputrc {{XDG_CONFIG_HOME}}/readline/inputrc


[unix]
vim:
    mkdir -p {{XDG_DATA_HOME}}/vim/after
    mkdir -p {{XDG_STATE_HOME}}/vim/{backup,swap,undo,view}
    mkdir -p {{XDG_CONFIG_HOME}}/vim/
    ln -sf {{DOTFILES}}/common/vimrc {{XDG_CONFIG_HOME}}/vim/vimrc


[windows]
vim:
    New-Item -ItemType SymbolicLink -Path $HOME/_vimrc -Value {{DOTFILES}}/common/vim.noxdg.vimrc

