#!/usr/bin/env bash

if command -v yazi > /dev/null 2>&1; then
    ya pkg add llanosrocas/yaziline
    ya pkg add yazi-rs/plugins:git
    ya pkg add Rolv-Apneseth/starship
fi
exit 0

