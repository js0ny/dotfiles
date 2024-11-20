# Windows dotfiles

By following the Windows Directory Standard, assign the following directories corresponding to `$XDG_CONFIG` in Unix:

- `%APPDATA%` - `$XDG_CONFIG_HOME` (default: `%USERPROFILE%\AppData\Roaming`)


## PowerShell Profile

This is the *[PowerShell Core](https://github.com/PowerShell/PowerShell)* profile, not the legacy *Windows PowerShell* profile.

By default, PowerShell profile is stored in `~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`.

It is convenient to use `$PROFILE` to locate the profile file.

```pwsh
Test-Path $PROFILE
```

To link the profile file:

```pwsh
New-Item -ItemType SymbolicLink -Path $PROFILE -Target "$DOTFILES\win\Microsoft.PowerShell_profile.ps1" -Force
```

I use [starship](https://starship.rs/) to customize the prompt, which is located in [`.dotfiles/.config/starship/starship_pwsh.toml`](../.config/starship/starship_pwsh.toml). This prompt config is cross-platform for powershell core, since I use the promp to identify the shell.

## `.wslconfig` - WSL Configuration

`.wslconfig` only supports `~/.wslconfig` as the configuration path

```pwsh
New-Item -ItemType SymbolicLink -Path "~\.wslconfig" -Target "$DOTFILES\win\.wslconfig" -Force
```

## Windows Terminal

Use Hard Link to sync Windows Terminal Settings since it doesn't support symlink.

```pwsh
New-Item -ItemType HardLink -Path "$Env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Target "$DOTFILES\win\WindowsTerminal.json" -Force
```

## Neovide

Neovide configuration is (only) stored in `%APPDATA%\neovide\config.toml`

```pwsh
New-Item -ItemType SymbolicLink -Path "$Env:AppData\neovide\config.toml" -Target "$DOTFILES\win\neovide.toml" -Force
```