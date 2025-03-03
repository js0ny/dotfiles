# Set Environment Variables
# Use %PATH_EXT% to prevent PATH from being too long
[System.Environment]::SetEnvironmentVariable("Path_EXT_0", "D:\bin", "User")
[System.Environment]::SetEnvironmentVariable("Path_EXT_0", "C:\Users\jsony\AppData\Local\Cargo\bin", "User")
[System.Environment]::SetEnvironmentVariable("Path_EXT_1", "C:\Users\jsony\AppData\Local\Go\bin", "User")
[System.Environment]::SetEnvironmentVariable("Path_EXT_2", "C:\Users\jsony\AppData\Local\Cargo\bin", "User")
$currentPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
if ($currentPath -notlike "*%PATH_EXT%*") {
    $currentPath += ";%PATH_EXT_0%;%PATH_EXT_1%;%PATH_EXT_2%"
}
[System.Environment]::SetEnvironmentVariable("Path", $currentPath, "User")
[System.Environment]::SetEnvironmentVariable("PATH_EXT_0", "", [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("PATH_EXT_1", "", [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("PATH_EXT_2", "", [System.EnvironmentVariableTarget]::Machine)
$currentPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
if ($currentPath -notlike "*%PATH_EXT%*") {
    $currentPath += ";%PATH_EXT_0%;%PATH_EXT_1%;%PATH_EXT_2%"
}
[System.Environment]::SetEnvironmentVariable("Path", $currentPath, [System.EnvironmentVariableTarget]::Machine)
# Simulate XDG Base Directory Specification
$Env:XDG_CONFIG_HOME = "$Env:AppData"
$Env:XDG_DATA_HOME = "$Env:LocalAppData"
$Env:XDG_CACHE_HOME = "$Env:LocalAppData\Cache"
$Env:XDG_STATE_HOME = "$Env:LocalAppData\State"
[System.Environment]::SetEnvironmentVariable("XDG_CONFIG_HOME", "$Env:XDG_CONFIG_HOME", "User")
[System.Environment]::SetEnvironmentVariable("XDG_DATA_HOME", "$Env:XDG_DATA_HOME", "User")
New-Item -ItemType Directory -Path "$Env:LocalAppData\cache" -Force
[System.Environment]::SetEnvironmentVariable("XDG_CACHE_HOME", "$Env:XDG_CACHE_HOME", "User")
New-Item -ItemType Directory -Path "$Env:LocalAppData\state" -Force
[System.Environment]::SetEnvironmentVariable("XDG_STATE_HOME", "$Env:XDG_STATE_HOME", "User")
# Add environment variables
[System.Environment]::SetEnvironmentVariable("DOTFILES", "$DOTFILES", "User")
# Set potential environment variables to prevent softwares put their configs in the wrong place
# eg. dotfiles in %UserProfile%
# ~\.aws -> %AppData%\aws :: AWS CLI
New-Item -ItemType Directory -Path "$Env:AppData\aws" -Force
[System.Environment]::SetEnvironmentVariable("AWS_CONFIG_FILE", "$Env:AppData\aws\config", "User")
[System.Environment]::SetEnvironmentVariable("AWS_SHARED_CREDENTIALS_FILE", "$Env:AppData\aws\credentials", "User")
# ~\.azure -> %LocalAppData%\Azure :: Azure CLIcargo install --list
[System.Environment]::SetEnvironmentVariable("AZURE_CONFIG_DIR", "$Env:LocalAppData\Azure", "User")
# ~\.cargo -> %LocalAppData%\Cargo :: Rust https://doc.rust-lang.org/cargo/guide/cargo-home.html
[System.Environment]::SetEnvironmentVariable("CARGO_HOME", "$Env:LocalAppData\Cargo", "User")
# ~\.docker -> %AppData%\dotDocker :: Docker (Docker takes %AppData%\Docker, use dotDocker instead)
[System.Environment]::SetEnvironmentVariable("DOCKER_CONFIG", "$Env:AppData\dotDocker", "User")
# ~\.dotnet -> %LocalAppData%\dotNET :: .NET Core
[System.Environment]::SetEnvironmentVariable("DOTNET_CLI_HOME", "$Env:LocalAppData\dotNET", "User")
# ~\.emacs.d -> %AppData%\.emacs.d :: Emacs (This is default)
# [System.Environment]::SetEnvironmentVariable("EMACS_HOME", "$Env:AppData\emacs.d", "User")
# ~\go -> %LocalAppData%\GO :: golang
[System.Environment]::SetEnvironmentVariable("GOPATH", "$Env:LocalAppData\GO", "User")
# ~\.ipython -> %AppData%\ipython :: IPython
# IPython won't check XDG on Windows https://github.com/ipython/ipython/blob/0615526f80691452f2e282c363bce197c0141561/IPython/utils/path.py#L200
[System.Environment]::SetEnvironmentVariable("IPYTHONDIR", "$Env:AppData\ipython", "User")
# ~\.julia -> %LocalAppData%\julia :: Julia
[System.Environment]::SetEnvironmentVariable("JULIA_DEPOT_PATH", "$Env:LocalAppData\julia", "User")
# ~\_lesshst -> %LocalAppData%\state\lesshst :: less
[System.Environment]::SetEnvironmentVariable("LESSHISTFILE", "$Env:XDG_STATE_HOME\lesshst", "User")
# %AppData%\less\lesskey :: less
New-Item -ItemType Directory -Path "$Env:AppData\less" -Force
[System.Environment]::SetEnvironmentVariable("LESSKEYIN", "$Env:AppData\less\lesskey", "User")
# ~\.matplotlib -> %LocalAppData%\matplotlib :: Matplotlib
[System.Environment]::SetEnvironmentVariable("MPLCONFIGDIR", "$Env:LocalAppData\matplotlib", "User")
# ~\.npmrc -> %AppData%\npm\npmrc :: npm
[System.Environment]::SetEnvironmentVariable("NPM_CONFIG_USERCONFIG", "$Env:AppData\npm\npmrc", "User")
# ~\.node_repl_history -> %LocalAppData%\state\node\repl_history :: Node.js
New-Item -ItemType Directory -Path "$Env:XDG_STATE_HOME\node" -Force
[System.Environment]::SetEnvironmentVariable("NODE_REPL_HISTORY", "$Env:XDG_STATE_HOME\node\repl_history", "User")
# ~\.ts_node_repl_history -> %LocalAppData%\state\node\ts_node_repl_history :: Node.js
# NOTE: ts-node doesn't support this yet
# [System.Environment]::SetEnvironmentVariable("TS_NODE_REPL_HISTORY", "$Env:XDG_STATE_HOME\node\ts_node_repl_history", "User")
# ~\.nuget\packages -> %LocalAppData%\cache\NuGet\packages :: NuGet
[System.Environment]::SetEnvironmentVariable("NUGET_PACKAGES", "$Env:XDG_CACHE_HOME\NuGet\packages", "User")
# ~\.omnisharp -> %AppData%\OmniSharp :: OmniSharp
[System.Environment]::SetEnvironmentVariable("OMNISHARPHOME", "$Env:AppData\OmniSharp", "User")
# ~\.python_history -> %LocalAppData%\state\python\python_history :: Python
# Only works for Python 3.13+ https://docs.python.org/3.13/using/cmdline.html#envvar-PYTHON_HISTORY
New-Item -ItemType Directory -Path "$Env:XDG_STATE_HOME\python" -Force
[System.Environment]::SetEnvironmentVariable("PYTHON_HISTORY", "$Env:XDG_STATE_HOME\python\python_history", "User")
# ~\.rustup -> %LocalAppData%\Rustup :: Rust
[System.Environment]::SetEnvironmentVariable("RUSTUP_HOME", "$Env:LocalAppData\Rustup", "User")
# ~\.vimrc -> %AppData%\Vim\_vimrc :: Vim
New-Item -ItemType Directory -Path "$Env:AppData\Vim" -Force
[System.Environment]::SetEnvironmentVariable("VIM", "$Env:AppData\Vim", "User")
[System.Environment]::SetEnvironmentVariable("KOMOREBI_CONFIG_HOME", "$Env:AppData\komorebi", "User")
# ~\.vuerc -> %AppData%\vue\.vuerc :: Vue CLI
# Currently, Vue CLI doesn't support file path configuration:https://github.com/vuejs/vue-cli/blob/dev/packages/%40vue/cli/lib/confifile
# [System.Environment]::SetEnvironmentVariable("VUE_CLI_CONFIG_PATH", "$Env:AppData\vue\.vuerc", "User")
# ~\.wget-hsts -> %LocalAppData%\cache\wget-hsts :: wget
# Use Alias, wget host file path is not configurable
# ~\.yarnrc -> %AppData%\yarn\config.yaml :: Yarn v1
# Use Alias, yarnrc path is not configurable

# Reload required here to make sure the environment variables are set
