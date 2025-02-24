set shell := ["fish", "-c"]
set windows-shell := ["pwsh", "-c"]

check_info:
    shellcheck -x -s sh  ./bootstrap/**/*.sh
    shellcheck -x -s bash  **/*.bash tools/bash/* scripts/*.{sh,zsh,bash} **/*.bashrc
check:
    shellcheck -x -s sh --severity=error ./bootstrap/**/*.sh
    shellcheck -x -s bash --severity=error **/*.bash tools/bash/* **/*.bashrc
format:
    # shfmt -w -d -i 2 -ci -bn **/*.sh tools/bash/* scripts/*.{sh,bash,zsh} **/*.bashrc
    shfmt -w -d -i 2 -ci -bn -p ./bootstrap/**/*.sh
    shfmt -w -d -i 2 -ci -bn -ln bash ./bootstrap/**/*.bash
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
