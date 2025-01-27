# $DOTFILES\bootstrap\set_symlink_win.ps1
# Date: 2024-12-01
# Author: js0ny
# Set symlinks for dotfiles on Windows
# 在 Windows 上设置 配置文件的符号链接

$DOTFILES = Join-Path $Env:UserProfile ".dotfiles"
$BASE_COMMON = Join-Path $DOTFILES "common"
$BASE_TOOLS = Join-Path $DOTFILES "tools"
$BASE_WIN = Join-Path $DOTFILES "platforms" "win"
$STARTUP = [System.Environment]::GetFolderPath("Startup")

$linkDots = @{
    "$BASE_WIN\wslconfig"            = "$Env:UserProfile\.wslconfig"
    "$BASE_WIN\glzr"                 = "$Env:UserProfile\.glzr"
    "$BASE_WIN\neovide.toml"         = "$Env:AppData\neovide\config.toml"
    "$BASE_WIN\vsvimrc"              = "$Env:UserProfile\.vsvimrc"
    "$BASE_COMMON\condarc.yaml"      = "$Env:XDG_CONFIG_HOME\conda\.condarc"
    "$BASE_COMMON\gitconfig"         = "$Env:UserProfile\.gitconfig"
    "$BASE_COMMON\glow.yaml"         = "$Env:AppData\glow\glow.yml"
    "$BASE_COMMON\haskeline"         = "$Env:UserProfile\.haskeline"
    "$BASE_COMMON\ideavimrc"         = "$Env:XDG_CONFIG_HOME\ideavim\ideavimrc"
    "$BASE_COMMON\lesskey"           = "$Env:LessKeyIn"
    "$BASE_COMMON\npmrc"             = "$Env:NPM_CONFIG_USERCONFIG"
    "$BASE_COMMON\NuGet.Config"      = "$Env:AppData\NuGet\NuGet.Config"
    "$BASE_COMMON\starship.toml"     = "$Env:UserProfile\.config\starship.toml"
    "$BASE_COMMON\pip.conf"          = "$Env:AppData\pip\pip.ini"
    "$BASE_COMMON\vimrc.noxdg.vimrc" = "$Env:UserProfile\_vimrc"
    "$BASE_TOOLS\ipython"            = "$Env:IPYTHONDIR"
    "$BASE_TOOLS\ipython"            = "$Env:IPYTHONDIR"
    "$BASE_TOOLS\nvim"               = "$Env:XDG_CONFIG_HOME\nvim"
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

Copy-Item (Join-Path $BASE_WIN "ahk" "bin" "Caps.exe") $STARTUP
