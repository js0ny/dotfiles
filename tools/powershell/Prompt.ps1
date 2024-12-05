# $DOTFILES/tools\powershell\Prompt.ps1
# Date: 2024-12-01
# Author: js0ny
# Use starship to set prompt
$ENV:STARSHIP_CONFIG = Join-Path $DOTFILES "tools" "starship" "starship_pwsh.toml"

# Invoke-Expression (&starship init powershell)

# Below is the backup of original prompt function
# $promptTime = $true
# # $promptWeather = $false

# function prompt {
#   $prompt = "`e[35m"
#   # Time
#   if ($promptTime) {
#     $promptTime = Get-Date -Format HH:mm
#     $prompt += "`[$promptTime]"
#   }
#   # UserInfo
#   $prompt += " $Env:Username @ $Env:Userdomain"
#   # Directory
#   $promptCurrentDirectory = $(PWD).Path
#   $promptCurrentDirectory = $promptCurrentDirectory.Replace("$HOME", "~")
#   $prompt += "`e[0m in `e[33m$promptCurrentDirectory "
#   # Git
#   if ($(git rev-parse --is-inside-work-tree 2> $null) -eq "true") {
#     $prompt += "`e[32m`u{e702} $(git branch --show-current)"
#   }
#   # Conda
#   if ( $Env:CONDA_PROMPT_MODIFIER ) {
#     $promptConda = $Env:CONDA_PROMPT_MODIFIER.Replace("`(","").Replace(")","")
#     $pythonVersion = $(python --version).Split(" ")[1]
#     $prompt += " `e[33m`u{e73c} $promptConda $pythonVersion"
#   }
#   # Programming Language (by Get-ChildItem)
#   ## Python
#     if (Test-Path -Path "$PWD\pyproject.toml") {
#         $pythonVersion = $(python --version).Split(" ")[1]
#         $prompt += " `e[33m`u{e73c} $pythonVersion"
#     }
#   ## Node.js
#     if (Test-Path -Path "$PWD\package.json") {
#         $nodeVersion = $(node --version)
#         $prompt += " `e[32m`u{e3a0} $nodeVersion"
#         # Locked
#         if (Test-Path -Path "$PWD\yarn.lock" || Test-Path -Path "$PWD\package-lock.json") {
#             $prompt += "`u{f023}"
#         }
#     }
#   ## .NET
#   ### C Sharp
#     if (Test-Path -Path "$PWD\*.csproj") {
#         $dotnetVersion = $(dotnet --version)
#         $prompt += " `e[34m`u{e648} $dotnetVersion"
#     }
#     ### F Sharp
#     if (Test-Path -Path "$PWD\*.fsproj") {
#         $dotnetVersion = $(dotnet --version)
#         $prompt += " `e[35m`u{e65a} $dotnetVersion"
#     }
#   ## Rust
#   if (Test-Path -Path "$PWD\Cargo.toml") {
#     $rustVersion = $(cargo --version).Split(" ")[1]
#     $prompt += " `e[31m`u{e7a8} $rustVersion"
#   }
#   ## Java
#     if (Test-Path -Path "$PWD\pom.xml" || Test-Path -Path "$PWD\build.gradle") {
#         $javaVersion =  $(java --version).Split(" ")[1]
#         $prompt += " `e[31m`u{e738} $javaVersion"
#     }
#     ## Makefile
#     if (Test-Path -Path "$PWD\Makefile") {
#         $prompt += " `e[32m`u{e673}"
#     }
#     if (Test-Path -Path "$PWD\CMakeLists.txt") {
#         $prompt += " `e[32m `u{e61d}"
#     }
#     # Docker
#     if (Test-Path -Path "$PWD\Dockerfile" || Test-Path -Path "$PWD\docker-compose.yml") {
#         $prompt += " `e[33m`u{f21f}"
#     }
#   # Weather
#   # if ( $global:promptWeather ) {
#   #   $prompt += $(Write-WeatherCurrent -City "Edinburgh" -Country "UK" -Unit "metric" -Inline -Apikey $Env:WEATHER_API_KEY)
#   # }
#   # Error on last command
#   ## TODO: Seems does not work
#   if ($?) {
#     $prompt += "`n`e[32m PS > `e[0m"
#   } else {
#     $prompt += "`n`e[31m PS > `e[0m"
#   }
#   return $prompt
# }
