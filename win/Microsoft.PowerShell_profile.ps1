### Load Configs ###
$DOTFILES = "$HOME\.dotfiles"
Get-ChildItem -Path $DOTFILES\powershell -Filter *.ps1 | ForEach-Object {. $_}
Get-ChildItem -Path $DOTFILES\powershell_private -Filter *.ps1 | ForEach-Object {. $_}

### Aliases ###

# Shell Equivalents #
Set-Alias "grep" "Select-String"
${function:which}    = { (Get-Command $args[0]).Path }

# Shell Configurations #
${function:shcfg}    = { code $PROFILE }
${function:reload}   = { & $PROFILE }
${function:pulldots} = { Set-Location -Path $DOTFILES && git pull }
Set-Alias "pwshcfg" "shcfg"

# C & C++ #
# Set-Alias "cl"      "clang"
# Set-Alias "clpp"    "clang++"
# ${function:clang} = { clang -std=c99 $args[0] }
# ${function:clang++} = { clang -std=c++2b $args[0] }

# WSL #
${function:wsl1} = {wsl.exe --distribution Arch}
${function:wsl2} = {wsl.exe --distribution Ubuntu-22.04}

# Search Software #
function Find-AppPackageListRemote {
    param(
      [string]$Name
    )
    if (-not $Name) {
      Write-Host "Please provide a package name."
      return
    }
    Write-Host "Searching for $Name..."
    Write-Host "=== winget ==="
    winget search $Name
    Write-Host "=== choco ==="
    choco search $Name
}
Set-Alias "pkgsearch" "Find-AppPackageListRemote"
function Get-AppPackageListLocal {
	winget list
	choco list
	scoop list
}

# Toggle Theme #
function Set-SystemTheme {
  $regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
  $currentMode = Get-ItemProperty -Path $regPath -Name "AppsUseLightTheme"
  if ($currentMode.AppsUseLightTheme -eq 1) {
    Set-ItemProperty -Path $regPath -Name "AppsUseLightTheme" -Value 0
    Write-Host "已切换到深色模式"
  }
  else {
    Set-ItemProperty -Path $regPath -Name "AppsUseLightTheme" -Value 1
    Write-Host "已切换到浅色模式"
  }
}
Set-Alias "dark-mode" "Set-SystemTheme" # Consistent with macOS (`dark-mode`)

# Miscs #

### Misc ###
${function:qwen} = "ollama run qwen2.5:14b"

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
