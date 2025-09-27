#!/usr/bin/env sh

XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

mkdir -p {{XDG_DATA_HOME}}/rtorrent/session
mkdir -p {{XDG_DATA_HOME}}/rtorrent/watch

