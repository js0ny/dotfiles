# $XDG_CONFIG_HOME/powershell/Microsoft.PowerShell_profile.ps1
# ln -sf $DOTFILES/mac/Microsoft.PowerShell_profile.ps1 $XDG_CONFIG_HOME/powershell/Microsoft.PowerShell_profile.ps1
### Variables ###

$DOTFILES = "$HOME/.dotfiles"

### Load Configs ###

Get-ChildItem -Path $(Join-Path $DOTFILES "tools" "powershell") -Filter *.ps1 | ForEach-Object {. $_}

## Aliases ###

# PowerShell Equivalents #

# Set-Alias "curl"  "Invoke-WebRequest"
# Set-Alias "man"   "Get-Help"
Set-Alias "kill"  "Stop-Process"
Set-Alias "open" "Invoke-Item" # Use ii instead of open

# Dev #

${function:zshcfg}   = { nvim ~/.zshrc }
${function:bashcfg}   = { nvim ~/.bashrc }
