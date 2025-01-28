# $DOTFILES/tools\powershell\Aliases.ps1
# Date: 2024-12-01
# Author: js0ny
# Aliases for PowerShell

# Unix Shell Equivalents #
Set-Alias "touch" "New-Item"
${function:l} = { Get-ChildItem -Force }
${function:tree} = { lsd --tree $args }
Set-Alias "which" "Get-Command"

# Editors #
Set-Alias "v" "nvim"
Set-Alias "c" "code"
Get-Command neovide -ErrorAction SilentlyContinue > $null && Set-Alias "gvi" "neovide"



# File Creation #
function mkcd { param ( [string] $dirname) New-Item -ItemType Directory -Name $dirname && Set-Location $dirname }
function tc { param ( [string] $filename) New-Item $filename && code $filename }
function tv { param ( [string] $filename) New-Item $filename && nvim $filename }
function cdls { param( [string] $dirname) Set-Location $dirname && Get-ChildItem }
function zls { param( [string] $dirname) z $dirname && Get-ChildItem }
function zl { param( [string] $dirname) z $dirname && lsd }


### Dev ###

# Python & Conda #
Set-Alias "py"      "python"
Set-Alias "ipy"     "ipython"

if ($Env:WEZTERM) {
    # Environment variable injected by wezterm/wezterm.lua
    ${function:icat} = { wezterm imgcat $args }
}
elseif ($Env:KITTY) {
    ${function:icat} = { kitty +kitten icat $args }
}
