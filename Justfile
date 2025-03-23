set shell := ["fish", "-c"]
set windows-shell := ["pwsh", "-c"]


PLATFORM := \
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
    if env("XDG_CONFIG_HOME") != "" {env("XDG_CONFIG_HOME")} \
    else {
        if os_family() == "windows" {
            env("APPDATA")
        } else {
            join(home_directory(), ".config")
        }
    }

XDG_DATA_HOME := \
    if env("XDG_DATA_HOME") != "" {env("XDG_DATA_HOME")} \
    else {
        if os_family() == "windows" {
            env("LOCALAPPDATA")
        } else {
            join(home_directory(), ".local/share")
        }
    }

XDG_STATE_HOME := \
    if env("XDG_STATE_HOME") != "" {env("XDG_STATE_HOME")} \
    else {
        if os_family() == "windows" {
            join(env("LOCALAPPDATA"), "state")
        } else {
            join(home_directory(), ".local/state")
        }
    }

LN := \
    if os_family() == "windows" { # Sudo and coreutils are required
        "sudo ln -sf"
    } else {
        "ln -sf"
    }

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

vivaldi:
    curl https://github.com/SocietasEvanescentes/Vivaldi/files/12446831/Rose.Pine.Dawn.zip > $HOME/Downloads/vivaldi-light.zip # Rose Pine Dawn
    curl https://github.com/catppuccin/vivaldi/releases/download/1.0.0-ctpv2/Catppuccin.Mocha.Lavender.zip > $HOME/Downloads/vivaldi-dark.zip # Catppuccino Mocha Lavender

[linux]
systemd:
    ln -sf {{DOTFILES}}/platforms/{{PLATFORM}}/systemd {{XDG_CONFIG_HOME}}/systemd/


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


[linux]
bash:
    {{LN}} {{DOTFILES}}/tools/bash {{XDG_CONFIG_HOME}}/bash
    sudo cp $DOTFILES/tools/bash/xdg-compat.sh /etc/profile.d/xdg-compat.sh

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
