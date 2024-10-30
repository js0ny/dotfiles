Import-Module -Name Terminal-Icons
Import-Module -Name CompletionPredictor
if ($IsWindows) {
    # Chocolatey
    $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
    if (Test-Path($ChocolateyProfile)) { Import-Module "$ChocolateyProfile" }
    # WinGet
    Import-Module -Name Microsoft.WinGet.CommandNotFound #f45873b3-b655-43a6-b217-97c00aa0db58
}