# $DOTFILES/tools\powershell\Prompt.ps1
# Date: 2024-12-01
# Author: js0ny
# Use starship to set prompt

# Invoke-Expression (&starship init powershell)


function formatFG {
    param(
        [string]$RGB
    )
    if ($RGB -eq "-1") {
        return "`e[39m"
    }
    $R = $RGB.Substring(0, 2)
    $G = $RGB.Substring(2, 2)
    $B = $RGB.Substring(4, 2)
    # Convert hex to RGB
    $R = [int]::Parse($R, [System.Globalization.NumberStyles]::HexNumber)
    $G = [int]::Parse($G, [System.Globalization.NumberStyles]::HexNumber)
    $B = [int]::Parse($B, [System.Globalization.NumberStyles]::HexNumber)
    return "`e[38;2;$R;$G;${B}m"
}

function formatBG {
    param(
        [string]$RGB
    )
    if ($RGB -eq "-1") {
        return "`e[49m"
    }
    $R = $RGB.Substring(0, 2)
    $G = $RGB.Substring(2, 2)
    $B = $RGB.Substring(4, 2)
    # Convert hex to RGB
    $R = [int]::Parse($R, [System.Globalization.NumberStyles]::HexNumber)
    $G = [int]::Parse($G, [System.Globalization.NumberStyles]::HexNumber)
    $B = [int]::Parse($B, [System.Globalization.NumberStyles]::HexNumber)
    return "`e[48;2;$R;$G;${B}m"
}
function formatPowerlineText {
    param(
        [string]$FG,
        [string]$BG,
        [string]$PLBG,
        [string]$Text
    )
    $ResumeSequece = "`e[0m"
    $TextFG = formatFG -RGB $FG
    $TextBG = formatBG -RGB $BG
    $PLFG = formatFG -RGB $BG
    $PLBG = formatBG -RGB $PLBG
    return "$TextFG$TextBG $Text $PLFG$PLBG$ResumeSequece"
}

function prompt {
    if ($pwd.Path -eq $HOME) {
        $cwd = "~"
    } else {
        $cwd = $pwd.ProviderPath
    }
    $time = Get-Date -Format "HH:mm"
    $ResumeSequece = "`e[0m"
    $FG0 = "FFFFFF"
    $BG0 = "9A348E"
    $BG1 = "DA627D"
    $BG2 = "FCA17D"
    $FG1 = "035E82"
    $time = formatPowerlineText $FG0 $BG0 $BG1 $time
    $cwd = formatPowerlineText $FG0 $BG1 $BG2 $cwd
    $ps = formatPowerlineText $FG1 $BG2 "-1" "PS"

   "$time$cwd$ps$ResumeSequece "

}

function Invoke-Starship {
    Invoke-Expression (&starship init powershell)
}

Import-Module Catppuccin

$Flavor = $Catppuccin['Mocha']

# The following colors are used by PowerShell's formatting
# Again PS 7.2+ only
$PSStyle.Formatting.Debug = $Flavor.Sky.Foreground()
$PSStyle.Formatting.Error = $Flavor.Red.Foreground()
$PSStyle.Formatting.ErrorAccent = $Flavor.Blue.Foreground()
$PSStyle.Formatting.FormatAccent = $Flavor.Teal.Foreground()
$PSStyle.Formatting.TableHeader = $Flavor.Rosewater.Foreground()
$PSStyle.Formatting.Verbose = $Flavor.Yellow.Foreground()
$PSStyle.Formatting.Warning = $Flavor.Peach.Foreground()

$Colors = @{
    # Largely based on the Code Editor style guide
    # Emphasis, ListPrediction and ListPredictionSelected are inspired by the Catppuccin fzf theme

    # Powershell colours
    Emphasis               = $Flavor.Red.Foreground()
    Selection              = $Flavor.Surface0.Background()

    # PSReadLine prediction colours
    InlinePrediction       = $Flavor.Overlay0.Foreground()
    ListPrediction         = $Flavor.Mauve.Foreground()
    ListPredictionSelected = $Flavor.Surface0.Background()

    # Syntax highlighting
    Command                = $Flavor.Blue.Foreground()
    Comment                = $Flavor.Overlay0.Foreground()
    Default                = $Flavor.Text.Foreground()
    Error                  = $Flavor.Red.Foreground()
    Keyword                = $Flavor.Mauve.Foreground()
    Member                 = $Flavor.Rosewater.Foreground()
    Number                 = $Flavor.Peach.Foreground()
    Operator               = $Flavor.Sky.Foreground()
    Parameter              = $Flavor.Pink.Foreground()
    String                 = $Flavor.Green.Foreground()
    Type                   = $Flavor.Yellow.Foreground()
    Variable               = $Flavor.Lavender.Foreground()
}

# Set the colours
Set-PSReadLineOption -Colors $Colors

# Smarter cd
# Init zoxide apter starship to avoid conflicts
# https://github.com/ajeetdsouza/zoxide/issues/723
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
    ${function:...} = { z -Path (Join-Path -Path .. -ChildPath ..) }
    ${function:....} = { z -Path (Join-Path -Path (Join-Path -Path .. -ChildPath ..) -ChildPath ..) }
    ${function:.....} = { z -Path (Join-Path -Path (Join-Path -Path (Join-Path -Path .. -ChildPath ..) -ChildPath ..) -ChildPath ..) }
    ${function:......} = { z -Path (Join-Path -Path (Join-Path -Path (Join-Path -Path (Join-Path -Path .. -ChildPath ..) -ChildPath ..) -ChildPath ..) -ChildPath ..) }
    ${function:z-} = { z - }
}
else {
    ${function:...} = { Set-Location -Path (Join-Path -Path .. -ChildPath ..) }
    ${function:....} = { Set-Location -Path (Join-Path -Path (Join-Path -Path .. -ChildPath ..) -ChildPath ..) }
    ${function:.....} = { Set-Location -Path (Join-Path -Path (Join-Path -Path (Join-Path -Path .. -ChildPath ..) -ChildPath ..) -ChildPath ..) }
    ${function:......} = { Set-Location -Path (Join-Path -Path (Join-Path -Path (Join-Path -Path (Join-Path -Path .. -ChildPath ..) -ChildPath ..) -ChildPath ..) -ChildPath ..) }
    ${function:z-} = { Set-Location - }
}
