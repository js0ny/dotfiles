# GlazeWM Setup

Link the whole `glzr` directory to the user's home directory.

```powershell
New-Item -ItemType SymbolicLink -Path $Env:UserProfile\.glzr -Target $DOTFILES\platforms\win\glzr -Force
```

The Zebar config should be downloaded from [this repository](https://github.com/js0ny/neobrutal-zebar) and extracted to the `glzr\zebar` directory.

Or use the minimal setup, by changing `glzr\zebar\settings.json`: `startupConfigs.path` to `minimal/bar.zebar.json`.

```json
{
  "$schema": "https://github.com/glzr-io/zebar/raw/v2.4.0/resources/settings-schema.json",
  "startupConfigs": [
    {
      "path": "minimal/bar.zebar.json",
      "preset": "default"
    }
  ]
}
```

```powershell
Invoke-WebRequest -Uri "https://github.com/js0ny/neobrutal-zebar/releases/download/2/neobrutal.zip" -OutFile "$Env:UserProfile\.glzr\zebar\neobrutal.zip"
Expand-Archive -Path "$Env:UserProfile\.glzr\zebar\neobrutal.zip" -DestinationPath "$Env:UserProfile\.glzr\zebar"
Remove-Item -Path "$Env:UserProfile\.glzr\zebar\neobrutal.zip"
```
