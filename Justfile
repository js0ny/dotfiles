set shell := ["fish", "-c"]
set windows-shell := ["pwsh", "-c"]

DOTFILES := join(home_directory(), ".dotfiles")
XDG_CONFIG_HOME := \
    if env_var("XDG_CONFIG_HOME") != "" {env_var("XDG_CONFIG_HOME")} \
    else {
        if os_family() == "windows" {
            env_var("APPDATA")
        } else {
            join(home_directory(), ".config")
        }
    }

XDG_DATA_HOME := \
    if env_var("XDG_DATA_HOME") != "" {env_var("XDG_DATA_HOME")} \
    else {
        if os_family() == "windows" {
            env_var("LOCALAPPDATA")
        } else {
            join(home_directory(), ".local/share")
        }
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

ideavim:
    ln -sf {{DOTFILES}}/common/ideavimrc $XDG_CONFIG_HOME/ideavim/ideavimrc
    git clone https://github.com/MarcoIeni/intellimacs {{join(home_directory(), ".local/share/intellimacs")}}

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