# Run as Administrator

Set-MpPreference -EnableControlledFolderAccess 1

$protected = (Get-MpPreference).ControlledFolderAccessProtectedFolders
$protected += "$env:USERPROFILE\.ssh"
$protected += "$env:USERPROFILE\.config"
Set-MpPreference -ControlledFolderAccessProtectedFolders $protected

$apps = (Get-MpPreference).ControlledFolderAccessAllowedApplications
$apps += "$Env:Windir\System32\OpenSSH\ssh.exe"
$apps += "$Env:ProgramFiles\GPSoftware\Directory Opus\DOpus.exe"
$apps += "$Env:UserProfile\scoop\apps\pwsh\current\pwsh.exe"
Set-MpPreference -ControlledFolderAccessAllowedApplications $apps

$exclusion = (Get-MpPreference).ExclusionPath
$exclusion += "$env:ProgramFiles\JetBrains"
$exclusion += "$env:LocalAppData\JetBrains"
$exclusion += "D:\Source"
Set-MpPreference -ExclusionPath $exclusion
