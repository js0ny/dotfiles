#!/bin/sh
# shellcheck shell=sh

if command -v nvim > /dev/null 2>&1; then
    nvim --headless +checkhealth +"w nvim-healthcheck.txt" +qall
fi
