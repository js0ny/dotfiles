# set shell := ["fish", "-c"]
set shell := ["bash", "-c"]
set windows-shell := ["pwsh", "-c"]


OS := \
    if os() == "linux" {
        if env("WSL_DISTRO_NAME","") != "" {
            "wsl"
        } else {
            "linux"
        }
    } else if os() == "windows" {
        "win"
    } else if os() == "macos" {
        "mac"
    } else { "" }
DOTFILES := join(home_directory(), ".dotfiles")
XDG_CONFIG_HOME := \
    if env("XDG_CONFIG_HOME", "") != "" {env("XDG_CONFIG_HOME", "")} \
    else {
        if os_family() == "windows" {
            env("APPDATA")
        } else {
            join(home_directory(), ".config")
        }
    }

XDG_DATA_HOME := \
    if env("XDG_DATA_HOME", "") != "" {env("XDG_DATA_HOME", "")} \
    else {
        if os_family() == "windows" {
            env("LOCALAPPDATA", "")
        } else {
            join(home_directory(), ".local/share")
        }
    }

XDG_STATE_HOME := \
    if env("XDG_STATE_HOME", "") != "" {env("XDG_STATE_HOME", "")} \
    else {
        if os_family() == "windows" {
            join(env("LOCALAPPDATA", ""), "state")
        } else {
            join(home_directory(), ".local/state")
        }
    }

# Sudo and coreutils are required
LN := \
    if os_family() == "windows" {
        "sudo ln -sf"
    } else {
        "ln -sf"
    }
CLIP := \
    if os() == "windows" { "clip.exe" } \
    else if os() == "linux" { "wl-copy" } \
    else if os() == "macos" { "pbcopy" } \
    else { "" }


test:
    echo {{DOTFILES}}
    echo {{XDG_CONFIG_HOME}}
    echo {{XDG_DATA_HOME}}

init:
    git remote remove origin
    git remote add github git@github.com:js0ny/dotfiles.git
    git remote add codeberg git@codeberg.org:js0ny/dotfiles.git

check:
    @just check_shell
format:
    @just format_shell
push:
    git push github master
    git push codeberg master

setup:
    @just ideavim
    @just vivaldi

ideavim:
    ln -sf {{DOTFILES}}/common/ideavimrc {{XDG_CONFIG_HOME}}/ideavim/ideavimrc
    git clone https://github.com/MarcoIeni/intellimacs {{join(home_directory(), ".local/share/intellimacs")}} --depth 1

[unix]
vivaldi:
    curl -L https://github.com/SocietasEvanescentes/Vivaldi/files/12446831/Rose.Pine.Dawn.zip -o "$HOME/Downloads/vivaldi-light.zip" # Rose Pine Dawn
    curl -L https://github.com/catppuccin/vivaldi/releases/download/1.0.0-ctpv2/Catppuccin.Mocha.Lavender.zip -o "$HOME/Downloads/vivaldi-dark.zip" # Catppuccino Mocha Lavender


[linux]
systemd:
    ln -sf {{DOTFILES}}/platforms/{{OS}}/systemd {{XDG_CONFIG_HOME}}/systemd/


uv:
    uv init {{XDG_DATA_HOME}}/uvenv
    cd {{XDG_DATA_HOME}}/uvenv
    uv venv
    uv add -r {{DOTFILES}}/bootstrap/components/requirements.txt

[unix]
vim:
    mkdir -p {{XDG_DATA_HOME}}/vim/after
    mkdir -p {{XDG_STATE_HOME}}/vim/{backup,swap,undo,view}
    mkdir -p {{XDG_CONFIG_HOME}}/vim/
    ln -sf {{DOTFILES}}/common/vimrc {{XDG_CONFIG_HOME}}/vim/vimrc


[windows]
vim:
    New-Item -ItemType SymbolicLink -Path $HOME/_vimrc -Value {{DOTFILES}}/common/vim.noxdg.vimrc

yazi:
    which yazi || cargo install --locked yazi-fm yazi-cli
    -ya pack -a llanosrocas/yaziline
    -ya pack -a yazi-rs/plugins:git
    -ya pack -a Rolv-Apneseth/starship

wezterm:
    which wezterm
    {{LN}} {{DOTFILES}}/tools/wezterm {{XDG_CONFIG_HOME}}/wezterm/wezterm.lua

neovim:
    which nvim
    {{LN}} {{DOTFILES}}/tools/nvim {{XDG_CONFIG_HOME}}/nvim
    nvim --headless +checkhealth +"w nvim-healthcheck.txt" +qall

[unix]
neovide:
    which neovide
    -mkdir -p {{XDG_CONFIG_HOME}}/neovide
    {{LN}} {{DOTFILES}}/platforms/{{OS}}/neovide.toml {{XDG_CONFIG_HOME}}/neovide/config.toml

[unix]
thunderbird:
    curl -L https://github.com/wshanks/tbkeys/releases/download/v2.4.0/tbkeys.xpi -o "$HOME/Downloads/tbkeys.xpi"
    curl -L https://github.com/htyxyt/htyxyt-immersive-translate-Thunderbird/releases/download/thunderbird-v1.14.8/immersive-translate-Thunderbird.v1.14.8.xpi -o "$HOME/Downloads/immersive-translate-Thunderbird.xpi"
    cat {{DOTFILES}}/tools/thunderbird/tbkeys.json | {{CLIP}}

[linux]
readline:
    mkdir -p {{XDG_CONFIG_HOME}}/readline
    {{LN}} {{DOTFILES}}/common/inputrc {{XDG_CONFIG_HOME}}/readline/inputrc

[linux]
bash:
    {{LN}} {{DOTFILES}}/tools/bash {{XDG_CONFIG_HOME}}/bash
    sudo cp {{DOTFILES}}/tools/bash/xdg-compat.sh /etc/profile.d/xdg-compat.sh

[linux]
keyd:
    -which keyd || sudo pacman -S keyd --noconfirm || sudo apt install keyd --yes || @just build_keyd
    sudo cp {{DOTFILES}}/platforms/linux/keyd/keyd.conf /etc/keyd/default.conf
    mkdir -p {{XDG_CONFIG_HOME}}/keyd
    {{LN}} {{DOTFILES}}/platforms/linux/keyd/app.conf {{XDG_CONFIG_HOME}}/keyd/app.conf
    sudo systemctl enable keyd

[linux]
[private]
build_keyd:
    git clone https://github.com/rvaiya/keyd $HOME/.local/build/keyd
    cd $HOME/.local/build/keyd && make && sudo make install

[unix]
kitty:
    which kitty
    {{LN}} {{DOTFILES}}/tools/kitty {{XDG_CONFIG_HOME}}/kitty

[unix]
zotero:
    curl -L https://github.com/syt2/zotero-addons/releases/download/V1.8.1/zotero-addons.xpi -o "$HOME/Downloads/zotero-addons.xpi"

[unix]
fish:
    {{LN}} {{DOTFILES}}/tools/fish {{XDG_CONFIG_HOME}}/fish
    curl -L https://raw.githubusercontent.com/SpaceAceMonkey/dotenv-for-fish/refs/heads/main/dotenv.fish -o "{{DOTFILES}}/tools/fish/functions/dotenv.fish"


[unix]
zsh:
    -[[ -f /etc/zshenv ]] && sudo cp {{DOTFILES}}/tools/zsh/global.zshenv /etc/zshenv # or /etc/zsh/zshenv
    -[[ -f /etc/zsh/zshenv ]] && sudo cp {{DOTFILES}}/tools/zsh/global.zshenv /etc/zsh/zshenv
    mkdir -p {{XDG_CONFIG_HOME}}/zsh
    {{LN}} {{DOTFILES}}/tools/zsh/zshenv {{XDG_CONFIG_HOME}}/zsh/.zshenv
    {{LN}} {{DOTFILES}}/tools/zsh/zshrc {{XDG_CONFIG_HOME}}/zsh/.zshrc
    {{LN}} {{DOTFILES}}/tools/zsh/zprofile {{XDG_CONFIG_HOME}}/zsh/.zprofile
    test -d {{XDG_CONFIG_HOME}}/zsh/plugins/zsh-autosuggestions || git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git {{XDG_CONFIG_HOME}}/zsh/plugins/zsh-autosuggestions
    test -d {{XDG_CONFIG_HOME}}/zsh/plugins/zsh-syntax-highlighting || git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git {{XDG_CONFIG_HOME}}/zsh/plugins/zsh-syntax-highlighting
    test -d {{XDG_CONFIG_HOME}}/zsh/plugins/zsh-history-substring-search || git clone --depth 1 https://github.com/zsh-users/zsh-history-substring-search.git {{XDG_CONFIG_HOME}}/zsh/plugins/zsh-history-substring-search
    test -d {{XDG_CONFIG_HOME}}/zsh/plugins/zsh-completions || git clone --depth 1 https://github.com/zsh-users/zsh-completions.git {{XDG_CONFIG_HOME}}/zsh/plugins/zsh-completions

[linux]
flatpak:
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

[private]
pull:
    git pull github master
    git pull codeberg master


[private]
[unix]
check_shell:
    shellcheck -x -s sh --severity=error **/*.sh platforms/mac/yabairc
    shellcheck -x -s bash --severity=error **/*.bash tools/bash/* **/*.bashrc

[private]
[unix]
format_shell:
    shfmt -w -i 2 -ci -bn -p **/*.sh
    shfmt -w -i 2 -ci -bn -ln bash **/*.bash platforms/mac/sketchybar/sketchybarrc
    # Ignore syntax errors in zsh files
    shfmt -w -i 2 -ci -bn -ln bash **/*.zsh tools/zsh/**/* **/zshrc  || true

[private]
check_info:
    shellcheck -x -s sh  **/*.sh platforms/mac/yabairc
    shellcheck -x -s bash  **/*.bash tools/bash/* scripts/*.{sh,zsh,bash} **/*.bashrc
