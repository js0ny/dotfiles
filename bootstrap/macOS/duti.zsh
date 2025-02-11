# Set default apps (duti)
# The id of the app can be found by running
# `osascript -e 'id of app "AppName"'`
brew install --formula duti
echo "[INFO] Setting Default Apps"
# Markdown -> Typora
duti -s abnerworks.Typora .md all
duti -s abnerworks.Typora .markdown all
# PDF -> Sioyek
duti -s info.sioyek.sioyek .pdf all
# Raw Text -> Neovide
duti -s com.neovide.neovide .txt all
# Archive -> Keka
duti -s com.aone.keka .zip all
duti -s com.aone.keka .rar all
duti -s com.aone.keka .7z all
duti -s com.aone.keka .tar all
# Source Code Light -> Neovim
duti -s com.neovide.neovide .gitignore all
duti -s com.neovide.neovide .vimrc all
duti -s com.neovide.neovide .vim all
duti -s com.neovide.neovide .lua all
duti -s com.neovide.neovide .py all
duti -s com.neovide.neovide .jl all
duti -s com.neovide.neovide .sh all
duti -s com.neovide.neovide .c all
# Source Code DOTNET -> VSCode
duti -s com.microsoft.VSCode .cs all
duti -s com.microsoft.VSCode .fs all
duti -s com.microsoft.VSCode .fsx all
duti -s com.microsoft.VSCode .csx all
duti -s com.microsoft.VSCode .ps1 all
# Source Code Web -> VSCode
duti -s com.microsoft.VSCode .js all
duti -s com.microsoft.VSCode .ts all
duti -s com.microsoft.VSCode .jsx all
duti -s com.microsoft.VSCode .tsx all
duti -s com.microsoft.VSCode .css all
duti -s com.microsoft.VSCode .scss all
duti -s com.microsoft.VSCode .sass all
duti -s com.microsoft.VSCode .vue all
# Source Code Config -> Neovim
duti -s com.neovide.neovide .json all
duti -s com.neovide.neovide .yaml all
duti -s com.neovide.neovide .yml all
duti -s com.neovide.neovide .toml all
duti -s com.neovide.neovide .ini all
duti -s com.neovide.neovide .cfg all
duti -s com.neovide.neovide .conf all
duti -s com.neovide.neovide .kdl all
duti -s com.neovide.neovide .xml all
# Source Code Jupyter -> VSCode
duti -s com.microsoft.VSCode .ipynb all
# Source Code DotNet Project -> Rider
duti -s com.jetbrains.rider .sln all
duti -s com.jetbrains.rider .csproj all
duti -s com.jetbrains.rider .fsproj all
# Video -> IINA
duti -s com.colliderli.iina .mp4 all
duti -s com.colliderli.iina .mkv all

mkdir -p $DOTFILES/powershell_private
