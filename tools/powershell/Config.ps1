# Use XDG Base Directory Specification and its similar structure for Windows

# wget
if (Get-Command wget -ErrorAction SilentlyContinue) {
    ${function:wget} = {wget --hsts-file $XDG_CACHE_HOME/wget-hsts $args}
}

# yarn v1
if (Get-Command yarn -ErrorAction SilentlyContinue) {
    ${function:yarn} = {yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config.yaml $args}
}

if ($Env:WEZTERM) { # Environment variable injected by wezterm/wezterm.lua
    ${function:icat} = {wezterm imgcat $args}
}
elseif ($Env:KITTY) {
    ${function:icat} = {kitty +kitten icat $args}
}
