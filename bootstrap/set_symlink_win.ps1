# $DOTFILES\bootstrap\set_symlink_win.ps1
# Date: 2024-12-01
# Author: js0ny
# Set symlinks for dotfiles on Windows
# 在 Windows 上设置 配置文件的符号链接

$DOTFILES = Join-Path $Env:UserProfile ".dotfiles"
$BASE_COMMON = Join-Path $DOTFILES "common"
$BASE_TOOLS = Join-Path $DOTFILES "tools"
$BASE_WIN = Join-Path $DOTFILES "platforms" "win"
$linkDots = @{
    "$BASE_WIN\wslconfig"         = "$Env:UserProfile\.wslconfig"
    "$BASE_WIN\neovide.toml"      = "$Env:AppData\neovide\config.toml"
    "$BASE_WIN\vsvimrc"           = "$Env:Vim\.vsvimrc"
    "$BASE_WIN\komorebi"          = "$Env:KOMOREBI_CONFIG_HOME"
    "$BASE_COMMON\condarc.yaml"   = "$Env:XDG_CONFIG_HOME\conda\.condarc"
    "$BASE_COMMON\gitconfig"      = "$Env:UserProfile\.gitconfig"
    "$BASE_COMMON\glow.yaml"      = "$Env:AppData\glow\glow.yml"
    "$BASE_COMMON\haskeline"      = "$Env:UserProfile\.haskeline"
    "$BASE_COMMON\ideavimrc"      = "$Env:XDG_CONFIG_HOME\ideavim\ideavimrc"
    "$BASE_COMMON\lesskey"        = "$Env:LessKeyIn"
    "$BASE_COMMON\npmrc"          = "$Env:NPM_CONFIG_USERCONFIG"
    "$BASE_COMMON\NuGet.Config"   = "$Env:AppData\NuGet\NuGet.Config"
    "$BASE_COMMON\obsidian.vimrc" = "$Env:UserProfile\Obsidian\.obsidian.vimrc"
    "$BASE_COMMON\pip.conf"       = "$Env:AppData\pip\pip.ini"
    "$BASE_COMMON\vimrc"          = "$Env:Vim\_vimrc"
    "$BASE_TOOLS\ipython"         = "$Env:IPYTHONDIR"
    "$BASE_TOOLS\nvim"            = "$Env:XDG_CONFIG_HOME\nvim"
}



foreach ($target in $linkDots.Keys) {
    $path = $linkDots[$target]
    # Auto create directories (Untested)
    $dir = Split-Path $path
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force
    }
    New-Item -ItemType SymbolicLink -Target $target -Path $path -Force
}

New-Item -ItemType SymbolicLink -Target "$BASE_WIN\Microsoft.PowerShell_profile.ps1" -Path "$Env:UserProfile\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Force
