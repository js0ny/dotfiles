# $DOTFILES/tools\powershell\Aliases.ps1
# Date: 2024-12-01
# Author: contact@js0ny.net
# Aliases for PowerShell
### VARIABLES ###
$EDITOR = "code"
# Shell Equivalents #
Set-Alias "touch" "New-Item"
${function:l} = { Get-ChildItem -Force }
${function:tree} = { lsd.exe --tree $args }
Set-Alias "which" "Get-Command"

# Shell Configurations #
${function:pulldots} = { Set-Location -Path $DOTFILES && git pull }

# Editors #
Set-Alias "v" "nvim"
Set-Alias "c" "code"
Set-Alias "gvi" "neovide"

# File Creation #
function mkcd { param ( [string] $dirname) New-Item -ItemType Directory -Name $dirname && Set-Location $dirname }
function tc { param ( [string] $filename) New-Item $filename && code $filename }
function tv { param ( [string] $filename) New-Item $filename && nvim $filename }
function cdls { param( [string] $dirname) Set-Location $dirname && Get-ChildItem }

### Dev ###

# Python & Conda #
Set-Alias "py"      "python"
Set-Alias "ipy"     "ipython"
