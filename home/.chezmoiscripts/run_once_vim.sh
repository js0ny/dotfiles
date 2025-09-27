#!/bin/sh

XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"


mkdir -p $XDG_DATA_HOME/vim/after
mkdir -p $XDG_STATE_HOME/vim/{backup,swap,undo,view}

