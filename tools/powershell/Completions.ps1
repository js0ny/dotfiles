function Invoke-Completion {
    param ([string]$command)
    switch ($command) {
        'docker' { docker completion powershell | Out-String | Invoke-Expression }
        'git' { Import-Module Posh-Git }
        'hugo' { hugo completion powershell | Out-String | Invoke-Expression }
        'pip' { pip completion --powershell | Out-String | Invoke-Expression }
        'wezterm' { wezterm shell-completion --shell power-shell | Out-String | Invoke-Expression }
    }
}
