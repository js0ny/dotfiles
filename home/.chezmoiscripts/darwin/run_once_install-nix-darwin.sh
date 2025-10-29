#!/bin/sh

curl -fsSL https://install.determinate.systems/nix | sh -s -- install

sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/.dotfiles/nixcfgs
