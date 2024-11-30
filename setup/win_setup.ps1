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

# Set Environment Variables
# Use %PATH_EXT% to prevent PATH from being too long
[System.Environment]::SetEnvironmentVariable("Path_EXT_0", "D:\bin", "User")
[System.Environment]::SetEnvironmentVariable("Path_EXT_0", "C:\Users\citoy\AppData\Local\Cargo\bin", "User")
[System.Environment]::SetEnvironmentVariable("Path_EXT_1", "C:\Users\citoy\AppData\Local\Cargo\bin", "User")
[System.Environment]::SetEnvironmentVariable("Path_EXT_2", "C:\Users\citoy\AppData\Local\Cargo\bin", "User")
[System.Environment]::SetEnvironmentVariable("Path_EXT_2", "", "User")
$currentPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
if ($currentPath -notlike "*%PATH_EXT%*") {
    $currentPath += ";%PATH_EXT_0%;%PATH_EXT_1%;%PATH_EXT_2%"
}
[System.Environment]::SetEnvironmentVariable("Path", $currentPath, "User")
[System.Environment]::SetEnvironmentVariable("PATH_EXT_0", "", [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("PATH_EXT_1", "", [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("PATH_EXT_2", "", [System.EnvironmentVariableTarget]::Machine)
$currentPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
if ($currentPath -notlike "*%PATH_EXT%*") {
    $currentPath += ";%PATH_EXT_0%;%PATH_EXT_1%;%PATH_EXT_2%"
}
[System.Environment]::SetEnvironmentVariable("Path", $currentPath, [System.EnvironmentVariableTarget]::Machine)
# Simulate XDG Base Directory Specification
$Env:XDG_CONFIG_HOME = "$Env:AppData"
$Env:XDG_DATA_HOME = "$Env:LocalAppData"
$Env:XDG_CACHE_HOME = "$Env:LocalAppData\cache"
$Env:XDG_STATE_HOME = "$Env:LocalAppData\state"
[System.Environment]::SetEnvironmentVariable("XDG_CONFIG_HOME", "$Env:XDG_CONFIG_HOME", "User")
[System.Environment]::SetEnvironmentVariable("XDG_DATA_HOME", "$Env:XDG_DATA_HOME", "User")
New-Item -ItemType Directory -Path "$Env:LocalAppData\cache" -Force
[System.Environment]::SetEnvironmentVariable("XDG_CACHE_HOME", "$Env:XDG_CACHE_HOME", "User")
New-Item -ItemType Directory -Path "$Env:LocalAppData\state" -Force
[System.Environment]::SetEnvironmentVariable("XDG_STATE_HOME", "$Env:XDG_STATE_HOME", "User")
# Add environment variables
[System.Environment]::SetEnvironmentVariable("DOTFILES", "$DOTFILES", "User")
# Set potential environment variables to prevent softwares put their configs in the wrong place
# eg. dotfiles in %UserProfile%
# ~\.aws -> %AppData%\aws :: AWS CLI
New-Item -ItemType Directory -Path "$Env:AppData\aws" -Force
[System.Environment]::SetEnvironmentVariable("AWS_CONFIG_FILE", "$Env:AppData\aws\config", "User")
[System.Environment]::SetEnvironmentVariable("AWS_SHARED_CREDENTIALS_FILE", "$Env:AppData\aws\credentials", "User")
# ~\.azure -> %LocalAppData%\Azure :: Azure CLIcargo install --list
[System.Environment]::SetEnvironmentVariable("AZURE_CONFIG_DIR", "$Env:LocalAppData\Azure", "User")
# ~\.cargo -> %LocalAppData%\Cargo :: Rust https://doc.rust-lang.org/cargo/guide/cargo-home.html
[System.Environment]::SetEnvironmentVariable("CARGO_HOME", "$Env:LocalAppData\Cargo", "User")
# ~\.docker -> %AppData%\dotDocker :: Docker (Docker takes %AppData%\Docker, use dotDocker instead)
[System.Environment]::SetEnvironmentVariable("DOCKER_CONFIG", "$Env:AppData\dotDocker", "User")
# ~\.dotnet -> %LocalAppData%\dotNET :: .NET Core
[System.Environment]::SetEnvironmentVariable("DOTNET_CLI_HOME", "$Env:LocalAppData\dotNET", "User")
# ~\.emacs.d -> %AppData%\.emacs.d :: Emacs (This is default)
# [System.Environment]::SetEnvironmentVariable("EMACS_HOME", "$Env:AppData\emacs.d", "User")
# ~\go -> %LocalAppData%\GO :: golang
[System.Environment]::SetEnvironmentVariable("GOPATH", "$Env:LocalAppData\GO", "User")
# ~\.ipython -> %AppData%\ipython :: IPython
# IPython won't check XDG on Windows https://github.com/ipython/ipython/blob/0615526f80691452f2e282c363bce197c0141561/IPython/utils/path.py#L200
[System.Environment]::SetEnvironmentVariable("IPYTHONDIR", "$Env:AppData\ipython", "User")
# ~\.julia -> %LocalAppData%\julia :: Julia
[System.Environment]::SetEnvironmentVariable("JULIA_DEPOT_PATH", "$Env:LocalAppData\julia", "User")
# ~\_lesshst -> %LocalAppData%\state\lesshst :: less
[System.Environment]::SetEnvironmentVariable("LESSHISTFILE", "$Env:XDG_STATE_HOME\lesshst", "User")
# %AppData%\less\lesskey :: less
New-Item -ItemType Directory -Path "$Env:AppData\less" -Force
[System.Environment]::SetEnvironmentVariable("LESSKEYIN", "$Env:AppData\less\lesskey", "User")
# ~\.matplotlib -> %LocalAppData%\matplotlib :: Matplotlib
[System.Environment]::SetEnvironmentVariable("MPLCONFIGDIR", "$Env:LocalAppData\matplotlib", "User")
# ~\.npmrc -> %AppData%\npm\npmrc :: npm
[System.Environment]::SetEnvironmentVariable("NPM_CONFIG_USERCONFIG", "$Env:AppData\npm\npmrc", "User")
# ~\.node_repl_history -> %LocalAppData%\state\node\repl_history :: Node.js
New-Item -ItemType Directory -Path "$Env:XDG_STATE_HOME\node" -Force
[System.Environment]::SetEnvironmentVariable("NODE_REPL_HISTORY", "$Env:XDG_STATE_HOME\node\repl_history", "User")
# ~\.ts_node_repl_history -> %LocalAppData%\state\node\ts_node_repl_history :: Node.js
# NOTE: ts-node doesn't support this yet
# [System.Environment]::SetEnvironmentVariable("TS_NODE_REPL_HISTORY", "$Env:XDG_STATE_HOME\node\ts_node_repl_history", "User")
# ~\.nuget\packages -> %LocalAppData%\cache\NuGet\packages :: NuGet
[System.Environment]::SetEnvironmentVariable("NUGET_PACKAGES", "$Env:XDG_CACHE_HOME\NuGet\packages", "User")
# ~\.omnisharp -> %AppData%\OmniSharp :: OmniSharp
[System.Environment]::SetEnvironmentVariable("OMNISHARPHOME", "$Env:AppData\OmniSharp", "User")
# ~\.python_history -> %LocalAppData%\state\python\python_history :: Python
# Only works for Python 3.13+ https://docs.python.org/3.13/using/cmdline.html#envvar-PYTHON_HISTORY
New-Item -ItemType Directory -Path "$Env:XDG_STATE_HOME\python" -Force
[System.Environment]::SetEnvironmentVariable("PYTHON_HISTORY", "$Env:XDG_STATE_HOME\python\python_history", "User")
# ~\.rustup -> %LocalAppData%\Rustup :: Rust
[System.Environment]::SetEnvironmentVariable("RUSTUP_HOME", "$Env:LocalAppData\Rustup", "User")
# ~\.vimrc -> %AppData%\Vim\_vimrc :: Vim
New-Item -ItemType Directory -Path "$Env:AppData\Vim" -Force
[System.Environment]::SetEnvironmentVariable("VIM", "$Env:AppData\Vim", "User")
[System.Environment]::SetEnvironmentVariable("KOMOREBI_CONFIG_HOME", "$Env:AppData\komorebi", "User")
# ~\.vuerc -> %AppData%\vue\.vuerc :: Vue CLI
# Currently, Vue CLI doesn't support file path configuration:https://github.com/vuejs/vue-cli/blob/dev/packages/%40vue/cli/lib/confifile
# [System.Environment]::SetEnvironmentVariable("VUE_CLI_CONFIG_PATH", "$Env:AppData\vue\.vuerc", "User")
# ~\.wget-hsts -> %LocalAppData%\cache\wget-hsts :: wget
# Use Alias, wget host file path is not configurable
# ~\.yarnrc -> %AppData%\yarn\config.yaml :: Yarn v1
# Use Alias, yarnrc path is not configurable

# Reload required here to make sure the environment variables are set


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
