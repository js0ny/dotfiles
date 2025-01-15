# $DOTFILES/tools\powershell\Prompt.ps1
# Date: 2024-12-01
# Author: js0ny
# Use starship to set prompt
$ENV:STARSHIP_CONFIG = Join-Path $DOTFILES "tools" "starship" "starship_pwsh.toml"

Invoke-Expression (&starship init powershell)
