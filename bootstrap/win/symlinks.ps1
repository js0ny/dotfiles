# $DOTFILES\bootstrap\set_symlink_win.ps1
# Date: 2024-12-01
# Author: js0ny
# Set symlinks for dotfiles on Windows
# 在 Windows 上设置 配置文件的符号链接

# Run this with Administrator privileges

$DOTFILES = Join-Path $Env:UserProfile ".dotfiles"
$BASE_COMMON = Join-Path $DOTFILES "common"
$BASE_TOOLS = Join-Path $DOTFILES "tools"
$BASE_WIN = Join-Path $DOTFILES "platforms" "win"
$STARTUP = [System.Environment]::GetFolderPath("Startup")

$BAT_CONF = Join-Path $Env:AppData "bat" "config"
if ((Get-Command bat).Source -ccontains "scoop") {
    $BAT_CONF = Join-Path (scoop prefix bat) "config"
}


$SIOYEKDIR = scoop prefix sioyek

$SIOYEKCFG = Get-ChildItem "$BASE_TOOLS\sioyek" -Filter "*.config"

foreach ($cfg in $SIOYEKCFG) {
    $cfgName = $cfg.Name
    $cfgPath = Join-Path $SIOYEKDIR $cfgName
    New-Item -ItemType SymbolicLink -Target $cfg -Path $cfgPath -Force
}

$linkDots = @{
    "$BASE_WIN\wslconfig"            = "$Env:UserProfile\.wslconfig"
    "$BASE_WIN\glzr"                 = "$Env:UserProfile\.glzr"
    "$BASE_WIN\neovide.toml"         = "$Env:AppData\neovide\config.toml"
    "$BASE_WIN\vsvimrc"              = "$Env:UserProfile\.vsvimrc"
    "$BASE_COMMON\bat.config"        = "$BAT_CONF"
    "$BASE_COMMON\condarc.yaml"      = "$Env:XDG_CONFIG_HOME\conda\.condarc"
    "$BASE_COMMON\glow.yaml"         = "$Env:AppData\glow\glow.yml"
    "$BASE_COMMON\haskeline"         = "$Env:UserProfile\.haskeline"
    "$BASE_COMMON\ideavimrc"         = "$Env:XDG_CONFIG_HOME\ideavim\ideavimrc"
    "$BASE_COMMON\lazygit.yaml"      = "$Env:AppData\lazygit\config.yml"
    "$BASE_COMMON\lesskey"           = "$Env:LessKeyIn"
    "$BASE_COMMON\lsd"               = "$Env:AppData\lsd\config.yaml"
    "$BASE_COMMON\npmrc"             = "$Env:NPM_CONFIG_USERCONFIG"
    "$BASE_COMMON\NuGet.Config"      = "$Env:AppData\NuGet\NuGet.Config"
    "$BASE_COMMON\starship.toml"     = "$Env:UserProfile\.config\starship.toml"
    "$BASE_COMMON\pip.conf"          = "$Env:AppData\pip\pip.ini"
    "$BASE_COMMON\vimrc.noxdg.vimrc" = "$Env:UserProfile\_vimrc"
    "$BASE_COMMON\emacs.d"           = "$Env:AppData\.emacs.d"
    "$BASE_TOOLS\ipython"            = "$Env:IPYTHONDIR"
    "$BASE_TOOLS\nvim"               = "$Env:XDG_CONFIG_HOME\nvim"
    "$BASE_TOOLS\wezterm"            = "$Env:XDG_CONFIG_HOME\wezterm"
    "$BASE_TOOLS\yazi"               = "$Env:AppData\yazi\config"
    "$BASE_TOOLS\zed"                = "$Env:AppData\Zed"
}



foreach ($src in $linkDots.Keys) {
    $dest = $linkDots[$src]
    # Auto create directories (Untested)
    if (Test-Path -Path $src -PathType Container) {
        New-Item -ItemType Directory -Path $dest -Force
    }
    else {
        $Local:destParent = Split-Path -Path $dest -Parent
        New-Item -ItemType Directory -Path $destParent -Force
    }
    if (Test-Path -Path $dest) {
        Move-Item $dest "$dest.bak" -Force
    }
    New-Item -ItemType SymbolicLink -Target $src -Path $dest -Force
}

New-Item -ItemType SymbolicLink -Target "$BASE_WIN\Microsoft.PowerShell_profile.ps1" -Path "$Env:UserProfile\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Force

Copy-Item (Join-Path $BASE_WIN "ahk" "bin" "Caps.exe") $STARTUP
Copy-Item (Join-Path $BASE_COMMON "gitconfig") $Env:UserProfile
