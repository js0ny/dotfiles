function Invoke-Completion {
    param ([string]$command)
    switch ($command) {
        'docker' { docker completion powershell | Out-String | Invoke-Expression }
        'dotnet' {
            # https://learn.microsoft.com/en-us/dotnet/core/tools/enable-tab-autocomplete#powershell
            Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
                param($wordToComplete, $commandAst, $cursorPosition)
                dotnet complete --position $cursorPosition "$commandAst" | ForEach-Object {
                    [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
                }
            }
        }
        'git' { Import-Module Posh-Git }
        'hugo' { hugo completion powershell | Out-String | Invoke-Expression }
        'pip' { pip completion --powershell | Out-String | Invoke-Expression }
        'rg' { rg --generate complete-powershell | Out-String | Invoke-Expression }
        'uv' { uv generate-shell-completion powershell | Out-String | Invoke-Expression }
        'wezterm' { wezterm shell-completion --shell power-shell | Out-String | Invoke-Expression }
        'winget' {
            # https://learn.microsoft.com/en-us/windows/package-manager/winget/tab-completion
            Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
                param($wordToComplete, $commandAst, $cursorPosition)
                [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
                $Local:word = $wordToComplete.Replace('"', '""')
                $Local:ast = $commandAst.ToString().Replace('"', '""')
                winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
                    [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
                }
            }
        }
    }
}
Set-Alias "icmp" "Invoke-Completion"

Register-ArgumentCompleter -CommandName Invoke-Completion -ParameterName 'command' -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $cmds = @('docker', 'dotnet', 'git', 'hugo', 'pip', 'rg', 'uv', 'wezterm', 'winget')

    $cmds | Where-Object { $_ -like "$wordToComplete*" }
}
