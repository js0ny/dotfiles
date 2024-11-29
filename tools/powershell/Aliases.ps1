### VARIABLES ###
$EDITOR = "code"
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
Set-Alias "ipy"     "ipython"
${function:pyact} = { conda activate $args[0] }
${function:pydact} = { conda deactivate }
${function:pylsenvs} = { conda env list }
${function:pymkenv} = { conda create --name $args[0] }
${function:pyrmenv} = { conda remove --name $args[0] --all }

# Winget #

if ($isWindows) {
    ${function:wini} = { winget install $args }
    ${function:winr} = { winget uninstall $args }
    ${function:wins} = { winget search $args }
    ${function:winu} = { winget upgrade $args }
}
