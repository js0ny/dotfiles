set shell := ["pwsh", "-c"]

pull:
    git pull github master
    git pull codeberg master

push:
    git push github master
    git push codeberg master
