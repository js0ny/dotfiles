local os_type = require("utils").detected_os

return function(config)
  if os_type.is_win then
    config.default_prog = { "pwsh.exe", "-NoLogo", "-NoProfileLoadTime" }
    config.launch_menu = {
      {
        label = "Local - PowerShell",
        args = { "pwsh.exe", "-NoLogo", "-NoProfileLoadTime" },
      },
      {
        label = "Local - PowerShell Administator",
        args = { "sudo.exe", "pwsh.exe", "-NoLogo", "-NoProfileLoadTime" },
      },
      {
        label = "WSL1 - Arch",
        args = { "wsl.exe", "-d", "Arch" },
      },
      {
        label = "WSL2 - kali-linux",
        args = { "wsl.exe", "-d", "kali-linux" },
      },
      {
        label = "Local - NuShell",
        args = { "nu" },
      },
      {
        label = "Local - Windows PowerShell",
        args = { "powershell.exe" },
      },
      {
        label = "Local - Command Prompt",
        args = { "cmd.exe" },
      },
      {
        label = "WSL1 - Arch Zsh",
        args = { "wsl.exe", "-d", "Arch", "zsh" },
      },
    }
  elseif os_type.is_mac then
    config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
  else
    config.default_prog = { "fish" }
    config.launch_menu = {
      {
        label = "Local - Fish",
        args = { "fish", "-l" },
      },
      {
        label = "Local - Zsh",
        args = { "zsh", "-l" },
      },
      {
        label = "Local - PowerShell",
        args = { "pwsh", "-NoLogo", "-NoProfileLoadTime", "-Login" },
      },
      {
        label = "Local - NuShell",
        args = { "nu", "-l" },
      },
    }
  end
end
