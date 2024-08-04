### Variables ###

$DOTFILES = "$HOME\Documents\.dotfiles"

### Load Configs ###

Get-ChildItem -Path $DOTFILES\powershell -Filter *.ps1 | ForEach-Object {. $_}

### PSReadLine ###

Set-PSReadLineOption -EditMode            vi               # Vi Keybindings
Set-PSReadLineOption -PredictionViewStyle ListView         # Prediction View Style
Set-PSReadLineOption -PredictionSource    HistoryAndPlugin # Prediction Source
Set-PSReadLineOption -ContinuationPrompt  "`e[36m CR > "   # Continuation Prompt

### Keybindings ###

Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+f" -Function ForwardWord
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+b" -Function BackwardWord
Set-PSReadLineKeyHandler -Chord "Alt+f"	   -Function ForwardChar
Set-PSReadLineKeyHandler -Chord "Ctrl+b"	   -Function BackwardChar
Set-PSReadLineKeyHandler -Chord "Ctrl+p"	   -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord "Ctrl+n"	   -Function HistorySearchForward
Set-PSReadLineKeyHandler -Chord "Ctrl+a"	   -Function BeginningOfLine
Set-PSReadLineKeyHandler -Chord "Ctrl+e"	   -Function EndOfLine

### Navigator ###

# Relative navigation #

# ${function:~}        = { Set-Location -Path ~ } cd is better
${function:...}      = { Set-Location -Path ..\.. }
${function:....}     = { Set-Location -Path ..\..\.. }
${function:.....}    = { Set-Location -Path ..\..\..\.. }
${function:......}   = { Set-Location -Path ..\..\..\..\.. }

# Absolute navigation #

${function:docs}     = { Set-Location -Path ~\Documents }
${function:down}     = { Set-Location -Path ~\Downloads }
${function:dt}       = { Set-Location -Path ~\Desktop }
${function:mytmp}    = { Set-Location -Path ~\Temporary }
${function:one}      = { Set-Location -Path ~\OneDrive }
${function:doku}     = { Set-Location -Path ~\MyDocuments && Get-ChildItem }

### Aliases ###

# Shell Equivalents #

Set-Alias "touch" "New-Item"
Set-Alias "open"  "explorer.exe" 

# Shell Configurations #

${function:shcfg}    = { code $PROFILE }
${function:reload}   = { . $PROFILE }
${function:pulldots} = { Set-Location -Path $DOTFILES && git pull }
Set-Alias "pwshcfg" "shcfg"

# Dotnet #

${function:csi}      = { dotnet script }

# C & C++ #

Set-Alias "cl"      "clang"
Set-Alias "clpp"    "clang++"
Set-Alias "clang"   "clang -std=c99"
Set-Alias "clang++" "clang++ -std=c++2b"

# Python & Conda #

Set-Alias "python3" "python"
Set-Alias "pip3"    "pip"
Set-Alias "py"      "python"
Set-Alias "pyact"   "conda activate"
Set-Alias "pylsenv" "conda env list"
Set-Alias "pydeact" "conda deactivate"
Set-Alias "pymkenv" "conda create --name"

# # Git #

# Set-Alias "g" "git"
# Set-Alias "ginit" "git init"
# Set-Alias "ga" "git add"
# Set-Alias "gaa" "git add --all"
# Set-Alias "gc" "git commit --message"
# Set-Alias "gca" "git commit --all --message"
# Set-Alias "gcl" "git clone"
# Set-Alias "gclnh" "git clone --depth 1"
# Set-Alias "gs" "git status"
# Set-Alias "gpl" "git pull"
# Set-Alias "gps" "git push"


# WSL #

${function:wsl1} = {wsl.exe --distribution Debian}
${function:wsl2} = {wsl.exe --distribution Ubuntu-22.04}

# Editors #

Set-Alias "v" "nvim"
Set-Alias "c" "code"
Set-Alias "gvi" "neovide"

# Miscs #

Set-Alias mcd CreateAndSet-Directory

### Functions ###

function tc { param ( [string] $filename)
	New-Item $filename && code $filename
}

function tv { param ( [string] $filename)
	New-Item $filename && nvim $filename
}

function cdls { param( [string] $dirname)
	Set-Location $dirname && Get-ChildItem
}

### Modules ###

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) { Import-Module "$ChocolateyProfile" }

Import-Module -Name Microsoft.WinGet.CommandNotFound #f45873b3-b655-43a6-b217-97c00aa0db58

Import-Module CompletionPredictor

### Misc ###

#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
If (Test-Path "$HOME\miniconda3\Scripts\conda.exe") {
    (& "$HOME\miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Where-Object{$_} | Invoke-Expression
}
#endregion

### Check Start Up ###

$SystemlogFilePath = "$env:USERPROFILE\.PowerShellStartup.log"

# 检查日志文件是否存在
if (-not (Test-Path $SystemlogFilePath)) {
	New-Item -Path $SystemlogFilePath -ItemType File -Force | Out-Null
}

# 读取日志文件的最后一行（即上次启动日期）
$__lastStartup = Get-Content -Path $SystemlogFilePath -Tail 1 -ErrorAction SilentlyContinue
$_currentDate = (Get-Date).ToString("yyyy-MM-dd")

if (-not ($__lastStartup -eq $_currentDate)) {
	Get-Date
	Update-ForexData &
	Write-Host "今天是第一次启动 PowerShell。"
	# 记录当前日期到日志文件
	$_currentDate | Out-File -FilePath $SystemlogFilePath -Append
}