#Requires -RunAsAdministrator
# TODO: This file is under development
exit 1

$DOTFILES = if ($Env:DOTFILES) { $Env:DOTFILES } else { Join-Path "$Env:USERPROFILE" "dotfiles" }


New-Item -ItemType Directory -Path (Join-Path $Env:UserProfile "Temp") -Force

winget install -e --id Git.Git

if (Get-Command git -ErrorAction SilentlyContinue) {
    git clone https://github.com/js0ny/dotfiles.git "$DOTFILES" --depth 1
}
else {
    Write-Output "[ERROR] Git is not installed"
    exit 1
}

# Install scoop
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# Inline `sudo`
sudo sudo config --enable normal

$BOOTSTRAP = Join-Path $DOTFILES "bootstrap" "win"

. (Join-Path $BOOTSTRAP "Environment.ps1")
. (Join-Path $BOOTSTRAP "Registry.ps1")
. (Join-Path $BOOTSTRAP "Symlinks.ps1")

scoop import (Join-Path $BOOTSTRAP "Scoopfile.json")

# Rime

$RIMEDIR = Join-Path $Env:AppData "Rime"
git clone --depth 1 https://github.com/js0ny/rime_wanxiang_pro.git $RIMEDIR

Set-Location $RIMEDIR
just init
just clone_plum

# The section below not done yet
exit 1

#!C:\Program Files\WindowsApps\Microsoft.PowerShell_7.4.6.0_x64__8wekyb3d8bbwe\pwsh.EXE
# Run with PowerShell 7
winget install -e --id Git.Git
git clone https://github.com/js0ny/dotfiles.git ~\.dotfiles
Set-Location -Path ~\.dotfiles
Remove-Item -Force $PROFILE
$DOTFILES = "$HOME\.dotfiles"
New-Item -ItemType SymbolicLink -Path $PROFILE -Target "$DOTFILES\win\Microsoft.PowerShell_profile.ps1"
. $PROFILE
# Install Scoop
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
# Install Chocolatey
# Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Set Dotfiles
# $DOTFILES\.config
$folders = @("conda", "git", "ideavim", "ipython", "markdownlint", "npm", "NuGet", "nvim", "pip", "Vim")
foreach ($folder in $folders) {
    New-Item -ItemType Directory -Path "$Env:XDG_CONFIG_HOME\$folder" -Force
}
New-Item -ItemType SymbolicLink -Path "$Env:XDG_CONFIG_HOME\conda\.condarc" -Target "$DOTFILES\.config\conda\condarc.yaml" -Force
New-Item -ItemType SymbolicLink -Path "$Env:XDG_CONFIG_HOME\git\config" -Target "$DOTFILES\.config\git\.gitconfig" -Force
New-Item -ItemType SymbolicLink -Path "~\.haskeline" -Target "$DOTFILES\.haskeline" -Force
New-Item -ItemType SymbolicLink -Path "$Env:XDG_CONFIG_HOME\ideavim\.ideavimrc" -Target "$DOTFILES\.config\ideavim\.ideavimrc" -Force
New-Item -ItemType SymbolicLink -Path "$Env:XDG_CONFIG_HOME\ipython" -Target "$DOTFILES\.config\ipython" -Force
# New-Item -ItemType SymbolicLink -Path "~\.markdownlint.json" -Target "$DOTFILES\.markdownlint.json" -Force
New-Item -ItemType SymbolicLink -Path "$Env:XDG_CONFIG_HOME\npm\npmrc" -Target "$DOTFILES\.config\npm\npmrc" -Force
New-Item -ItemType SymbolicLink -Path "$Env:AppData\NuGet\NuGet.Config" -Target "$DOTFILES\.config\NuGet\NuGet.Config" -Force
New-Item -ItemType SymbolicLink -Path "$Env:XDG_CONFIG_HOME\nvim" -Target "$DOTFILES\.config\nvim" -Force
New-Item -ItemType SymbolicLink -Path "$Env:AppData\pip\pip.ini" -Target "$DOTFILES\.config\pip\pip.conf" -Force
New-Item -ItemType SymbolicLink -Path "$Env:XDG_CONFIG_HOME\Vim\_vimrc" -Target "$DOTFILES\.config\vim\vimrc" -Force
New-Item -ItemType SymbolicLink -Path "~\.wslconfig" -Target "$DOTFILES\win\.wslconfig" -Force
New-Item -ItemType SymbolicLink -Path "$Env:AppData\neovide\config.toml" -Target "$DOTFILES\win\neovide.toml" -Force
# New-Item -ItemType SymbolicLink -Path "~\.vscode.vimrc" -Target "$DOTFILES\vscode\vscode.vimrc" Use Absolute Path
# Hide dotfiles
Get-ChildItem -Force -Filter .* -Path $HOME | ForEach-Object { $_.Attributes += "Hidden" }
@(
    Join-Path $HOME '.config'
    Join-Path $HOME '.dotfiles'
) | ForEach-Object {
    $_.Attributes -band -bnot [System.IO.FileAttributes]::Hidden
}
Set-Location $HOME\Documents
# Match WindowsPowerShell and PowerShell
Get-ChildItem -Force -Filter *owerShell | ForEach-Object { $_.Attributes += "Hidden" }

# Windows Terminal
if (Get-Command wt -ErrorAction SilentlyContinue) {
    Write-Output "Windows Terminal (wt) installed"
}
else {
    winget install -e --id Microsoft.WindowsTerminal
}

# Uninstall Windows Apps
Get-AppxPackage *solit* | Remove-AppxPackage  # 纸牌
Get-AppxPackage *sound* | Remove-AppxPackage # 錄音機
Get-AppxPackage *camera* | Remove-AppxPackage # 相機
Get-AppxPackage *weather* | Remove-AppxPackage # 天氣
Get-AppxPackage *Map* | Remove-AppxPackage # 地圖
# Get-AppxPackage *clipchamp* | Remove-AppxPackage # 其實這個還行

# Added Packages
scoop bucket add main
scoop bucket add nerd-fonts
scoop bucket add extras
scoop bucket add nonportable

# CLI Tools
# winget install -e --id GnuWin32.Grep # Use Select-String instead
scoop install main/make
# winget install -e --id GnuWin32.Which # Use Get-Command instead
scoop install main/fzf
scoop install main/ripgrep
scoop install main/wget
scoop install main/wget2
scoop install main/cmake
scoop install main/bat             # modern cat
scoop install main/zoxide          # Directory Jump
scoop install main/dos2unix        # Convert line endings
scoop install main/hyperfine       # Benchmark
scoop install main/bottom          # System Monitor
scoop install main/delta           # diff
scoop install extras/gpg4win

# File Management
scoop install extras/everything
scoop install main/7zip
scoop install extras/bandizip
scoop install main/pandoc
scoop install extras/sumatrapdf
winget install -e --id Google.GoogleDrive
sudo scoop install nonportable/winbtrfs-np

# System Enhancements
scoop install extras/fancontrol
scoop install extras/powertoys
scoop install extras/msiafterburner
winget install -e --id Yuanli.uTools
scoop install extras/geekuninstaller
scoop install extras/flow-launcher
# winget install -e --id AutoHotkey.AutoHotkey
scoop install extras/autohotkey
scoop install nonportable/mactype-np
scoop install extras/diskgenius
# winget install -e --id Nilesoft.Shell
# scoop install umi-ocr-paddle

# Editor
scoop install main/vim
scoop install main/neovim
scoop install extras/vscodium
scoop install extras/vscode
scoop install extras/neovide


# Security
scoop bucket add keyguard https://github.com/AChep/keyguard-repo-scoop
scoop install keyguard/keyguard

# PKM
scoop install extras/obsidian
winget install -e --id 9P7HPMXP73K4 # Siyuan
scoop install extras/typora
scoop install extras/zotero
scoop install extras/anki
# winget install -e --id Notion.Notion

# Browser
# Use Microsoft Edge directly
# winget install -e --id TheBrowserCompany.Arc
# winget install -e --id Mozilla.Firefox.Nightly # Not working

# Programming Languages
winget install -e --id Python.Python.3.13
winget install -e --id Anaconda.Miniconda3
winget install -e --id OpenJS.NodeJS
winget install -e --id Rustlang.Rustup
winget install -e --id Microsoft.DotNet.SDK.9

# Dev
scoop install extras/docker
scoop install extras/lazygit

# IDE
scoop install extras/rider

# Gaming
winget install -e --id Valve.Steam

# IME
winget install -e --id Rime.Weasel # 小狼毫 Rime

# Misc
winget install -e --id 9N5LW3JBCXKF --source msstore # MSIX Packaging Tool
winget install -e --id 9PKTQ5699M62 --source msstore # iCloud
winget install -e --id RazerInc.RazerInstaller # Razer Synapse

# Social
winget install -e --id 9N97ZCKPD60Q --source msstore # Unigram (Telegram client)
winget install -e --id Tencent.QQ.NT
winget install -e --id XPFCKBRNFZQ62G --source msstore # WeChat in Windows Store (MSIX)

# Others
winget install -e --id Appest.TickTick
winget install -e --id 9NBLGGH4Z1SP --source msstore # ShareX (screen capture)

# Fonts
scoop install FiraCode-NF
scoop install CascadiaCode-NF
scoop install LXGWWenKai       # 霞鹜文楷
scoop install LXGWWenKaiMono   # 霞鹜文楷Mono

# WSL
scoop install archwsl
wsl --set-version Arch 1
