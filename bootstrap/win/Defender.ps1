#Requires -RunAsAdministrator

Set-MpPreference -EnableControlledFolderAccess 1

$protected = (Get-MpPreference).ControlledFolderAccessProtectedFolders
$protected += "$Env:UserProfile\.ssh"
$protected += "$Env:UserProfile\.config"
$protected += "$Env:UserProfile\Vault"
Set-MpPreference -ControlledFolderAccessProtectedFolders $protected

$apps = (Get-MpPreference).ControlledFolderAccessAllowedApplications
$apps += "$Env:Windir\System32\OpenSSH\ssh.exe"
$apps += "$Env:ProgramFiles\GPSoftware\Directory Opus\DOpus.exe"
$apps += (Get-Command -Name code).Source.Replace("bin\code.cmd", "Code.exe")
$apps += (Get-Command -Name pwsh).Source
$apps += (Get-Command -Name git).Source
Set-MpPreference -ControlledFolderAccessAllowedApplications $apps

$exclusion = (Get-MpPreference).ExclusionPath
$exclusion += "$env:ProgramFiles\JetBrains"
$exclusion += "$env:LocalAppData\JetBrains"
$exclusion += "D:\Source"
Set-MpPreference -ExclusionPath $exclusion
