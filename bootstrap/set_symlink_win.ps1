# $DOTFILES\bootstrap\set_symlink_win.ps1
# Date: 2024-12-01
# Author: js0ny
# Set symlinks for dotfiles on Windows
# 在 Windows 上设置 dotfiles 的符号链接

$DOTFILES = Join-Path $env:UserProfile ".dotfiles"
$BASE_COMMON = Join-Path $DOTFILES "common"
$BASE_TOOLS = Join-Path $DOTFILES "tools"
$BASE_WIN = Join-Path $DOTFILES "platforms" "win"
$linkDots = @{
    "$BASE_WIN\wslconfig"          = "$env:UserProfile\.wslconfig"
    "$BASE_WIN\neovide.toml"       = "$Env:AppData\neovide\config.toml"
    "$BASE_WIN\vsvimrc"            = "$Env:Vim\.vsvimrc"
    "$BASE_WIN\komorebi"           = "$env:KOMOREBI_CONFIG_HOME"
    "$BASE_COMMON\condarc.yaml"    = "$env:XDG_CONFIG_HOME\conda\.condarc"
    "$BASE_COMMON\gitconfig"       = "$env:UserProfile\.gitconfig"
    "$BASE_COMMON\glow.yaml"       = "$env:AppData\glow\glow.yml"
    "$BASE_COMMON\haskeline"       = "$env:UserProfile\.haskeline"
    "$BASE_COMMON\ideavimrc"       = "$env:XDG_CONFIG_HOME\ideavim\ideavimrc"
    "$BASE_COMMON\lesskey"         = "$env:LessKeyIn"
    "$BASE_COMMON\npmrc"           = "$env:NPM_CONFIG_USERCONFIG"
    "$BASE_COMMON\NuGet.Config"    = "$env:AppData\NuGet\NuGet.Config"
    "$BASE_COMMON\obsidian.vimrc"  = "$env:UserProfile\Obsidian\.obsidian.vimrc"
    "$BASE_COMMON\pip.conf"        = "$env:AppData\pip\pip.ini"
    "$BASE_COMMON\vimrc"           = "$env:Vim\_vimrc"
    "$BASE_TOOLS\ipython"          = "$env:IPYTHONDIR"
    "$BASE_TOOLS\nvim"             = "$env:XDG_CONFIG_HOME\nvim"
}

# TODO: Auto create directories

foreach ($target in $linkDots.Keys) {
    $path = $linkDots[$target]
    New-Item -ItemType SymbolicLink -Target $target -Path $path -Force
}

New-Item -ItemType SymbolicLink -Target "$BASE_WIN\Microsoft.PowerShell_profile.ps1" -Path "$env:UserProfile\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Force
