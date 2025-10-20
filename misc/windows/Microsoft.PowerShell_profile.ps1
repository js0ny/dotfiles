# $DOTFILES/platforms\win\Microsoft.PowerShell_profile.ps1
# Date: 2024-12-01
# Author: js0ny
# PowerShell profile for Windows

### Load Configs ###
$DOTFILES = Join-Path $HOME ".dotfiles"
Get-ChildItem -Path $(Join-Path $DOTFILES "tools" "powershell") -Filter *.ps1 | ForEach-Object { . $_ }

### Aliases ###


# Toggle Theme #
Set-Alias "dark-mode" "$DOTFILES\platforms\win\cmd\dark-mode.bat" # Consistent with macOS (`dark-mode`)

# Miscs #

### Misc ###
${function:qwen} = "ollama run qwen2.5:14b"

## Conda ##
#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
If (Test-Path "$HOME\miniconda3\Scripts\conda.exe") {
    (& "$HOME\miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Where-Object { $_ } | Invoke-Expression
}
#endregion

## Check Start Up ##
#$SystemlogFilePath = "$env:USERPROFILE\.PowerShellStartup.log"
## 检查日志文件是否存在
#if (-not (Test-Path $SystemlogFilePath)) {
#	New-Item -Path $SystemlogFilePath -ItemType File -Force | Out-Null
#}
## 读取日志文件的最后一行（即上次启动日期）
#$__lastStartup = Get-Content -Path $SystemlogFilePath -Tail 1 -ErrorAction SilentlyContinue
#$_currentDate = (Get-Date).ToString("yyyy-MM-dd")
#if (-not ($__lastStartup -eq $_currentDate)) {
#	Get-Date
#	Update-ForexData &
#	Write-Host "今天是第一次启动 PowerShell。"
#	# 记录当前日期到日志文件
#	$_currentDate | Out-File -FilePath $SystemlogFilePath -Append
#}
#Remove-Variable SystemlogFilePath
#Remove-Variable __lastStartup
#Remove-Variable _currentDate

# Set default applications

$Env:PAGER = "less"
$Env:EDITOR = "code --wait"
$Env:VISUAL = "code --wait"
$Env:FILE_MANAGER = "dopus.exe"


${function:wini} = { winget install $args }
${function:winr} = { winget uninstall $args }
${function:wins} = { winget search $args }
${function:winu} = { winget upgrade $args }

${function:pkill} = { Get-Process *$args* | Stop-Process -Force }


${function:tmux} = { wsl.exe tmux $args }

if (Get-Command "sfsu.exe" -ErrorAction SilentlyContinue) {
    Invoke-Expression (&sfsu.exe hook)
}

# Elevate in current shell
# Set Windows Sudo to `inlined` sudo
${function:su} = { sudo.exe pwsh }

function Show-WindowsNotification {
    param (
        [string]$Title,
        [Parameter(ValueFromPipeline=$true)]
        [string]$Message
    )

    Add-Type -AssemblyName System.Windows.Forms
    $notifyIcon = New-Object System.Windows.Forms.NotifyIcon
    $notifyIcon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon((Get-Command pwsh).Source)
    $notifyIcon.Visible = $true
    $notifyIcon.ShowBalloonTip(0,$Title,$Message,[System.Windows.Forms.ToolTipIcon]::Info)
}

Import-Module "$($(Get-Item $(Get-Command scoop.ps1).Path).Directory.Parent.FullName)\modules\scoop-completion"
