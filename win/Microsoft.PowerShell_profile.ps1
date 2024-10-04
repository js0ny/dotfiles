### Variables ###

$DOTFILES = "$HOME\Documents\.dotfiles"

### Load Configs ###

Get-ChildItem -Path $DOTFILES\powershell -Filter *.ps1 | ForEach-Object {. $_}
Get-ChildItem -Path $DOTFILES\powershell_private -Filter *.ps1 | ForEach-Object {. $_}

### Aliases ###

# Shell Equivalents #

Set-Alias "open" "Invoke-Item" # Use ii instead of explorer.exe

# Shell Configurations #

${function:shcfg}    = { code $PROFILE }
${function:reload}   = { . $PROFILE }
${function:pulldots} = { Set-Location -Path $DOTFILES && git pull }
Set-Alias "pwshcfg" "shcfg"
# C & C++ #

# Set-Alias "cl"      "clang"
# Set-Alias "clpp"    "clang++"
# ${function:clang} = { clang -std=c99 $args[0] }
# ${function:clang++} = { clang -std=c++2b $args[0] }

# Python & Conda #

Set-Alias "python3" "python"
Set-Alias "pip3"    "pip"

# Git #

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


# Miscs #

### Modules ###

Import-Module -Name Microsoft.WinGet.CommandNotFound #f45873b3-b655-43a6-b217-97c00aa0db58
Import-Module CompletionPredictor
# Import-Module syntax-highlighting # Buggy

### Misc ###

## Conda ##

#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
If (Test-Path "$HOME\miniconda3\Scripts\conda.exe") {
    (& "$HOME\miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Where-Object{$_} | Invoke-Expression
}
#endregion

## Check Start Up ##
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

Remove-Variable SystemlogFilePath
Remove-Variable __lastStartup
Remove-Variable _currentDate

## Chocolatey ##

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) { Import-Module "$ChocolateyProfile" }
