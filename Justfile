set shell := ["fish", "-c"]
set windows-shell := ["pwsh", "-c"]

check_info:
    shellcheck -x -s sh  **/*.sh platforms/mac/yabairc
    shellcheck -x -s bash  **/*.bash tools/bash/* scripts/*.{sh,zsh,bash} **/*.bashrc
check:
    shellcheck -x -s sh --severity=error **/*.sh platforms/mac/yabairc
    shellcheck -x -s bash --severity=error **/*.bash tools/bash/* **/*.bashrc
format:
    shfmt -w -i 2 -ci -bn -p **/*.sh
    shfmt -w -i 2 -ci -bn -ln bash **/*.bash platforms/mac/sketchybar/sketchybarrc
    # Ignore syntax errors in zsh files
    shfmt -w -i 2 -ci -bn -ln bash **/*.zsh tools/zsh/**/* **/zshrc  || true
pull:
    git pull github master
    git pull codeberg master

push:
    git push github master
    git push codeberg master

init:
    git remote remove origin
    git remote add github git@github.com:js0ny/dotfiles.git
    git remote add codeberg git@codeberg.org:js0ny/dotfiles.git
