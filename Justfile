set shell := ["fish", "-c"]
set windows-shell := ["pwsh", "-c"]

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
