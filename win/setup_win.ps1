#!C:\Program Files\WindowsApps\Microsoft.PowerShell_7.4.6.0_x64__8wekyb3d8bbwe\pwsh.EXE
# Run with PowerShell 7
# Use PowerShell as Administrator 
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
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Set Dotfiles
New-Item -ItemType SymbolicLink -Path "~\.condarc" -Target "$DOTFILES\.condarc"
New-Item -ItemType SymbolicLink -Path "~\.gitconfig" -Target "$DOTFILES\.gitconfig"
New-Item -ItemType SymbolicLink -Path "~\.haskline" -Target "$DOTFILES\.haskline"
New-Item -ItemType SymbolicLink -Path "~\.ideavimrc" -Target "$DOTFILES\.ideavimrc"
New-Item -ItemType SymbolicLink -Path "~\.markdownlint.json" -Target "$DOTFILES\.markdownlint.json"
New-Item -ItemType SymbolicLink -Path "~\.npmrc" -Target "$DOTFILES\.npmrc"
New-Item -ItemType SymbolicLink -Path "~\.pip.conf" -Target "$DOTFILES\.pip.conf"
New-Item -ItemType SymbolicLink -Path "~\.wslconfig" -Target "$DOTFILES\win\.wslconfig"
New-Item -ItemType SymbolicLink -Path "~\.vscode.vimrc" -Target "$DOTFILES\vscode\vscode.vimrc"
Get-ChildItem -Force -Filter .* | ForEach-Object { $_.Attributes += "Hidden" }  # Hide dotfiles

# Windows Terminal
if (Get-Command wt -ErrorAction SilentlyContinue) {
    Write-Output "Windows Terminal (wt) installed"
} else {
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
scoop add bucket nerd-fonts
scoop add bucket extras

# CLI Tools
winget install -e --id GnuWin32.Grep
winget install -e --id GnuWin32.Make
winget install -e --id GnuWin32.Which
winget install -e --id junegunn.fzf
winget install -e --id BurntSushi.ripgrep.MSVC
winget install -e --id JernejSimoncic.Wget
winget install -e --id GNU.Wget2

# File Management
winget install -e --id voidtools.Everything
winget install -e --id 7zip.7zip
winget install -e --id Bandisoft.Bandizip
winget install -e --id JohnMacFarlane.Pandoc
winget install -e --id SumatraPDF.SumatraPDF
winget install -e --id Google.GoogleDrive

# System Enhancements
winget install -e --id Rem0o.FanControl
winget install -e --id Microsoft.PowerToys
winget install -e --id Guru3D.Afterburner
winget install -e --id Yuanli.uTools
winget install -e --id GeekUninstaller.GeekUninstaller
# winget install -e --id Flow-Launcher.Flow-Launcher
winget install -e --id AutoHotkey.AutoHotkey
winget install -e --id Mactype.Mactype
# winget install -e --id Nilesoft.Shell
# scoop install umi-ocr-paddle

# Editor
winget install -e --id vim.vim
winget install -e --id Neovim.Neovim
winget install -e --id VSCodium.VSCodium
winget install -e --id Microsoft.VisualStudioCode
winget install -e --id Neovide.Neovide

# Security
winget install -e --id Bitwarden.Bitwarden

# PKM
winget install -e --id Obsidian.Obsidian
winget install -e --id B3log.SiYuan
winget install -e --id appmakes.Typora
winget install -e --id DigitalScholar.Zotero
winget install -e --id Anki.Anki
winget install -e --id Notion.Notion

# Browser
winget install -e --id TheBrowserCompany.Arc
winget install -e --id Mozilla.Firefox.Nightly

# Programming Languages
winget install -e --id Python.Python.3.12
winget install -e --id Anaconda.Miniconda3
winget install -e --id OpenJS.NodeJS
winget install -e --id Rustlang.Rustup
winget install -e --id Microsoft.DotNet.SDK.8

# Dev/IDE
winget install -e --id Docker.DockerDesktop
winget install -e --id JesseDuffield.lazygit

# Gaming
winget install -e --id Valve.Steam

# IME
winget install -e --id Rime.Weasel

# Social
winget install -e --id 9N97ZCKPD60Q --source msstore # Unigram (Telegram client)
winget install -e --id Tencent.QQ.NT
winget install -e --id Tencent.WeChat

# Others
winget install -e --id Appest.TickTick

# Fonts
scoop install FiraCode-NF
scoop install CascadiaCode-NF
scoop install LXGWWenKai       # 霞鹜文楷
scoop install LXGWWenKaiMono   # 霞鹜文楷Mono