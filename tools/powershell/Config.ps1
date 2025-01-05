
if ($Env:WEZTERM) {
    # Environment variable injected by wezterm/wezterm.lua
    ${function:icat} = { wezterm imgcat $args }
}
elseif ($Env:KITTY) {
    ${function:icat} = { kitty +kitten icat $args }
}
