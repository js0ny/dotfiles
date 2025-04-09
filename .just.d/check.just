
test:
    echo "DOTFILES={{DOTFILES}}"
    echo "XDG_CONFIG_HOME={{XDG_CONFIG_HOME}}"
    echo "XDG_DATA_HOME={{XDG_DATA_HOME}}"


check:
    @just check_shell
format:
    @just format_shell


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

[private]
init:
    git remote add github git@github.com:js0ny/dotfiles.git
    git remote add codeberg git@codeberg.org:js0ny/dotfiles.git

[private]
push:
    git push github master
    git push codeberg master

[private]
pull:
    git pull github master
