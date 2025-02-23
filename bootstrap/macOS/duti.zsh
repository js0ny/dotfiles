#!/bin/zsh
# duti.zsh
# Set default apps (duti)
# The id of the app can be found by running
# `osascript -e 'id of app "AppName"'`
brew install --formula duti
echo "[INFO] Setting Default Apps"

# Define an associative array with file extensions and corresponding app IDs
typeset -A app_defaults
app_defaults=(
  # Markdown -> Typora
  .md abnerworks.Typora
  .markdown abnerworks.Typora
  # PDF -> Sioyek
  .pdf info.sioyek.sioyek
  # Raw Text -> Neovide
  .txt com.neovide.neovide
  # Archive -> Keka
  .zip com.aone.keka
  .rar com.aone.keka
  .7z com.aone.keka
  .tar com.aone.keka
  # Source Code Light -> Neovim
  .gitignore com.neovide.neovide
  .vimrc com.neovide.neovide
  .vim com.neovide.neovide
  .lua com.neovide.neovide
  .py com.neovide.neovide
  .jl com.neovide.neovide
  .sh com.neovide.neovide
  .c com.neovide.neovide
  # Source Code DOTNET -> VSCode
  .cs com.microsoft.VSCode
  .fs com.microsoft.VSCode
  .fsx com.microsoft.VSCode
  .csx com.microsoft.VSCode
  .ps1 com.microsoft.VSCode
  # Source Code Web -> VSCode
  .js com.microsoft.VSCode
  .ts com.microsoft.VSCode
  .jsx com.microsoft.VSCode
  .tsx com.microsoft.VSCode
  .css com.microsoft.VSCode
  .scss com.microsoft.VSCode
  .sass com.microsoft.VSCode
  .vue com.microsoft.VSCode
  # Source Code Config -> Neovim
  .json com.neovide.neovide
  .yaml com.neovide.neovide
  .yml com.neovide.neovide
  .toml com.neovide.neovide
  .ini com.neovide.neovide
  .cfg com.neovide.neovide
  .conf com.neovide.neovide
  .kdl com.neovide.neovide
  .xml com.neovide.neovide
  # Source Code Jupyter -> VSCode
  .ipynb com.microsoft.VSCode
  # Source Code DotNet Project -> Rider
  .sln com.jetbrains.rider
  .csproj com.jetbrains.rider
  .fsproj com.jetbrains.rider
  # Video -> IINA
  .mp4 com.colliderli.iina
  .mkv com.colliderli.iina
)

# Loop through the array and set the default apps
for ext app_id in ${(kv)app_defaults}; do
  duti -s $app_id $ext all
done

unset app_defaults
