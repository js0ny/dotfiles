### Variables ###

$EDITOR = "code"
$DOTFILES = "$HOME\Documents\.dotfiles"

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
${function:mytmp}    = { Set-Location -Path ~\Temporary }
${function:one}      = { Set-Location -Path ~\OneDrive }
${function:doku}     = { Set-Location -Path ~\MyDocuments && Get-ChildItem }

### Aliases ###

# Shell Equivalents #

Set-Alias "touch" "New-Item"
Set-Alias "open"  "explorer.exe" 

# Shell Configurations #

${function:shcfg}    = { $EDITOR $PROFILE }
${function:reload}   = { Invoke-Expression $PROFILE }
${function:pulldots} = { Set-Location -Path $DOTFILES && git pull }
Set-Alias "pwshcfg" "shcfg"

# Dotnet #

${function:csi}      = { dotnet script }

# C & C++ #

Set-Alias "cl"      "clang"
Set-Alias "clp"    "clang++"
Set-Alias "clang"   "clang -std=c99"
Set-Alias "clang++" "clang++ -std=c++2b"

# Python & Conda #

Set-Alias "python3" "python"
Set-Alias "pip3"    "pip"
Set-Alias "py"      "python"
Set-Alias "pyact"   "conda activate"
Set-Alias "pylsenv" "conda env list"
Set-Alias "pydeact" "conda deactivate"
Set-Alias "pymkenv" "conda create --name"

# # Git #

# Set-Alias "g" "git"
# Set-Alias "ginit" "git init"
# Set-Alias "ga" "git add"
# Set-Alias "gaa" "git add --all"
# Set-Alias "gc" "git commit --message"
# Set-Alias "gca" "git commit --all --message"
# Set-Alias "gcl" "git clone"
# Set-Alias "gclnh" "git clone --depth 1"
# Set-Alias "gs" "git status"
# Set-Alias "gpl" "git pull"
# Set-Alias "gps" "git push"


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

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) { Import-Module "$ChocolateyProfile" }

Import-Module -Name Microsoft.WinGet.CommandNotFound #f45873b3-b655-43a6-b217-97c00aa0db58

Import-Module CompletionPredictor

### Misc ###

#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
If (Test-Path "$HOME\miniconda3\Scripts\conda.exe") {
    (& "$HOME\miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Where-Object{$_} | Invoke-Expression
}
#endregion
