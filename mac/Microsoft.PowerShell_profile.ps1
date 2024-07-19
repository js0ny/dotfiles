### Variables ###

$DOTFILES = "$HOME\.dotfiles"

### PSReadLine ###

Set-PSReadLineOption -EditMode            vi               # Vi Keybindings
Set-PSReadLineOption -PredictionViewStyle ListView         # Prediction View Style
Set-PSReadLineOption -PredictionSource    HistoryAndPlugin # Prediction Source
Set-PSReadLineOption -ContinuationPrompt  "`e[36m CR > "   # Continuation Prompt

### Keybindings ###

Set-PSReadLineKeyHandler -Chord "Ctrl+f" -Function ForwardWord

### Navigator ###

# Relative navigation #

# ${function:~}        = { Set-Location -Path ~ } cd is better
${function:...}      = { Set-Location -Path ..\.. }
${function:....}     = { Set-Location -Path ..\..\.. }
${function:.....}    = { Set-Location -Path ..\..\..\.. }
${function:......}   = { Set-Location -Path ..\..\..\..\.. }

# Absolute navigation #

${function:docs}     = { Set-Location -Path ~\Documents }
${function:down}     = { Set-Location -Path ~\Downloads }
${function:dt}       = { Set-Location -Path ~\Desktop }
${function:mytmp}    = { Set-Location -Path ~\Temp }
${function:one}      = { Set-Location -Path ~\OneDrive }
${function:doku}     = { Set-Location -Path ~\doku && Get-ChildItem }

### Aliases ###

# PowerShell Equivalents #

Set-Alias "touch" "New-Item"
Set-Alias "ll"    "Get-ChildItem"
Set-Alias "curl"  "Invoke-WebRequest"
Set-Alias "man"   "Get-Help"
Set-Alias "kill"  "Stop-Process"

# Dev #

${function:shcfg}    = { code $PROFILE }
${function:zshcfg}   = { nvim ~/.zshrc }
${function:bashcfg}   = { nvim ~/.bashrc }
${function:reload}   = { Invoke-Expression $PROFILE }
${function:csi}      = { dotnet script }
${function:pulldots} = { Set-Location -Path $DOTFILES && git pull }
Set-Alias "pwshcfg" "shcfg"
Set-Alias "python3" "python"
Set-Alias "pip3"    "pip"
Set-Alias "py"      "python"
Set-Alias "cl"      "clang"
Set-Alias "cl++"    "clang++"
Set-Alias "clang"   "clang -std=c99"
Set-Alias "clang++" "clang++ -std=c++2b"

# Editors #

Set-Alias "v" "nvim"
Set-Alias "c" "code"
Set-Alias "gvi" "neovide"

# Miscs #

Set-Alias mcd CreateAndSet-Directory

### Functions ###

function tc { param ( [string] $filename)
	New-Item $filename && code $filename
}

function tv { param ( [string] $filename)
	New-Item $filename && nvim $filename
}

function cdls { param( [string] $dirname)
	Set-Location $dirname && Get-ChildItem
}



### Modules ###

Import-Module CompletionPredictor

### Misc ###