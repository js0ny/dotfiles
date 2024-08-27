### PSReadLine ###

Set-PSReadLineOption -EditMode            vi               # Vi Keybindings
Set-PSReadLineOption -PredictionViewStyle ListView         
Set-PSReadLineOption -PredictionSource    HistoryAndPlugin 
Set-PSReadLineOption -ContinuationPrompt  "`e[36m CR > "   

### Keybindings ###

Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+f" -Function ForwardWord
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+b" -Function BackwardWord
Set-PSReadLineKeyHandler -Chord "Alt+f"	   -Function ForwardChar
Set-PSReadLineKeyHandler -Chord "Ctrl+b"	   -Function BackwardChar
Set-PSReadLineKeyHandler -Chord "Ctrl+p"	   -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord "Ctrl+n"	   -Function HistorySearchForward
Set-PSReadLineKeyHandler -Chord "Ctrl+a"	   -Function BeginningOfLine
Set-PSReadLineKeyHandler -Chord "Ctrl+e"	   -Function EndOfLine

### Navigator ###

# Relative navigation #

# ${function:~}        = { Set-Location -Path ~ } cd is better
${function:...}      = { Set-Location -Path ..\.. }
${function:....}     = { Set-Location -Path ..\..\.. }
${function:.....}    = { Set-Location -Path ..\..\..\.. }
${function:......}   = { Set-Location -Path ..\..\..\..\.. }

# Absolute navigation #

${function:docs}     = { Set-Location -Path ~/Documents }
${function:down}     = { Set-Location -Path ~/Downloads }
${function:dt}       = { Set-Location -Path ~/Desktop }
${function:mytmp}    = { Set-Location -Path ~/Temp }
${function:one}      = { Set-Location -Path ~/OneDrive }
${function:doku}     = { Set-Location -Path ~/doku && Get-ChildItem }

### Alias ###

# Shell Equivalents #

Set-Alias "touch" "New-Item"
${function:ll} = { Get-ChildItem -Force } 

# Shell Configurations #

${function:shcfg}    = { code $PROFILE }
Set-Alias "pwshcfg" "shcfg"
${function:reload}   = { . $PROFILE }
${function:pulldots} = { Set-Location -Path $DOTFILES && git pull }

# Editors #

Set-Alias "v" "nvim"
Set-Alias "c" "code"
Set-Alias "gvi" "neovide"

# File Creation #

function mkcd { param ( [string] $dirname) mkdir $dirname && Set-Location $dirname }
function tc { param ( [string] $filename) New-Item $filename && code $filename }
function tv { param ( [string] $filename) New-Item $filename && nvim $filename }
function cdls { param( [string] $dirname) Set-Location $dirname && Get-ChildItem }

### Dev ###

# .NET #

${function:csi}      = { dotnet repl --default-kernel csharp}
${function:fsi}      = { dotnet repl --default-kernel fsharp}

# Python & Conda #

Set-Alias "py"      "python"
${function:pyact} = { conda activate $args[0] }
${function:pydact} = { conda deactivate }
${function:pylsenvs} = { conda env list }
${function:pymkenv} = { conda create --name $args[0] }
${function:pyrmenv} = { conda remove --name $args[0] --all }

# C & C++ #


### Modules ###

Import-Module CompletionPredictor