#Requires -RunAsAdministrator

Write-Output "[INFO] Setting up KMonad Tasks"

# PowerShell Path, use 7 if available
if (Get-Command "pwsh" -ErrorAction SilentlyContinue) {
    $PowerShellPath = (Get-Command "pwsh").Source
}
else {
    $PowerShellPath = (Get-Command "powershell").Source
}

$DotStartUpPath = "$Env:DOTFILES\platforms\win\start"

$KMonadRunnerPath = Join-Path $DotStartUpPath "KMonad.ps1"
$Action = New-ScheduledTaskAction -Execute $PowerShellPath -Argument "-NoProfile -ExecutionPolicy Bypass -File $KMonadRunnerPath"
$Trigger = New-ScheduledTaskTrigger -AtLogOn
$Principal = New-ScheduledTaskPrincipal -UserId "$env:USERNAME" -LogonType Interactive -RunLevel Highest
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd -Hidden

Register-ScheduledTask -TaskName "Start Kmonad" -Action $Action -Trigger $Trigger -Principal $Principal -Settings $Settings -TaskPath "\Personal"
