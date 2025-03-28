# $DOTFILES/tools\powershell\Environment.ps1
# Date: 2024-12-01
# Author: js0ny
# Sourced by Microsoft.PowerShell_profile.ps1


# This file stores only environment variables that only called by
# interactive session.

$env:IPYTHONDIR = "$env:AppData\ipython"
$env:EDITOR = "code --wait"
$env:VISUAL = "code --wait"
$env:PAGER = "less"
