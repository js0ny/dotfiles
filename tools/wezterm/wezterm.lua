-- $DOTFILES/tools/wezterm/wezterm.lua
-- Date: 2024-12-22
-- Author: js0ny

--#region Import & Setup
local wezterm = require 'wezterm'
local action = wezterm.action

local config = {}
--#endregion

--#region Helper
--[[
local function detect_os()
  local detected_os = ""
  if package.config:sub(1, 1) == "\\" then
    -- Windows
    detected_os = "Windows"
  elseif package.config:sub(1, 1) == "/" then
    -- Unix-like (Linux, macOS, etc.)
    if os.getenv("HOME") then
      detected_os = "Unix-like"
      -- You can differentiate further by checking for macOS or Linux if needed
      if os.getenv("XDG_SESSION_TYPE") then
        -- Likely Linux
        detected_os = "Linux"
      elseif os.execute("uname -s | grep -i darwin") == 0 then
        -- macOS
        detected_os = "macOS"
      end
    end
  end
  return detected_os
end
--]]
--[[
wezterm.on("text-selection-callback", function(window, pane)
  local text = window:get_selection_text_for_pane(pane)
end)
--]]

local function detect_os()
  local os_type = ""
  if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    os_type = "Windows"
  elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
    os_type = "Linux"
  elseif wezterm.target_triple == "aarch64-apple-darwin" then
    os_type = "macOS"
  end
  return os_type
end

-- OS light/dark theme detection
local function detect_theme()
end
--#endregion

--#region Constant
local os_type = detect_os()
--#endregion


--#region Appearance
-- Font and color scheme
-- config.font = 'FiraCode Nerd Font'

config.max_fps = 120
config.font = wezterm.font({
  family = "CaskaydiaCove Nerd Font",
})
config.color_scheme = "Catppuccin Frappe"
config.font_size = 12.0
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
if os_type == "Windows" then
  config.window_background_opacity = 0.7 -- Not working under WebGpu
  config.win32_system_backdrop = "Mica"
end
-- Tab appearance
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
-- Cursor
config.animation_fps = 120
config.cursor_blink_ease_in = 'EaseOut'
config.cursor_blink_ease_out = 'EaseOut'
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 650
-- Visual Bell
config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 250,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 250,
  target = 'CursorColor',
}
--#endregion

--#region Keybindings
config.leader = { key = "q", mods = "CTRL" }
config.keys = {
  {
    key = 'q',
    mods = 'LEADER',
    action = action.SendKey { key = 'q', mods = 'CTRL' },
  },
  -- Windows Management
  { -- leader keys
    key = '|',
    mods = 'LEADER|SHIFT',
    action = action.SplitHorizontal { domain = "CurrentPaneDomain" }
  },
  {
    key = '-',
    mods = 'LEADER',
    action = action.SplitVertical { domain = "CurrentPaneDomain" }
  },
  {
    key = 'h',
    mods = 'LEADER',
    action = action.ActivatePaneDirection 'Left'
  },
  {
    key = 'n',
    mods = 'LEADER',
    action = action.ActivatePaneDirection 'Down'
  },
  {
    key = 'e',
    mods = 'LEADER',
    action = action.ActivatePaneDirection 'Up'
  },
  {
    key = 'i',
    mods = 'LEADER',
    action = action.ActivatePaneDirection 'Right'
  },
  {
    key = 'H',
    mods = 'LEADER',
    action = action.AdjustPaneSize { 'Left', 5 },
  },
  {
    key = 'N',
    mods = 'LEADER',
    action = action.AdjustPaneSize { 'Down', 5 },
  },
  {
    key = 'E',
    mods = 'LEADER',
    action = action.AdjustPaneSize { 'Up', 5 },
  },
  {
    key = 'I',
    mods = 'LEADER',
    action = action.AdjustPaneSize { 'Right', 5 },
  },
  {
    key = "/",
    mods = "LEADER",
    action = action.Search { Regex = "" }
  },
  {
    key = "?",
    mods = "LEADER|SHIFT",
    action = action.Search { CaseSensitiveString = "" }
  },
  {
    key = ";",
    mods = "LEADER",
    action = action.ShowLauncher
  },
  {
    key = ":",
    mods = "LEADER|SHIFT",
    action = action.ActivateCommandPalette
  },
  {
    key = "W",
    mods = "CTRL",
    action = action.CloseCurrentPane { confirm = true }
  },
  { -- ^C to copy if selection is active, otherwise send signal
    -- https://wezfurlong.org/wezterm/config/lua/keyassignment/ClearSelection.html?h=selection
    key = 'c',
    mods = 'CTRL',
    action = wezterm.action_callback(function(window, pane)
      local has_selection = window:get_selection_text_for_pane(pane) ~= ''
      if has_selection then
        window:perform_action(action.CopyTo 'ClipboardAndPrimarySelection', pane)

        window:perform_action(action.ClearSelection, pane)
      else
        window:perform_action(action.SendKey { key = 'c', mods = 'CTRL' }, pane)
      end
    end),
  },
}
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = action.OpenLinkAtMouseCursor,
  },
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'SUPER',
    action = action.OpenLinkAtMouseCursor,
  },
}
--#endregion

--#region Environment
config.set_environment_variables = {
  WEZTERM = "true", -- for `icat`
}
--#endregion

--#region Launching
if os_type == "Windows" then
  config.default_prog = { "pwsh.exe", "-NoLogo", "-NoProfileLoadTime" }
  config.launch_menu = {
    {
      label = "Local - PowerShell",
      args = { "pwsh.exe", "-NoLogo", "-NoProfileLoadTime" }
    },
    {
      label = "Local - PowerShell Administator",
      args = { "sudo.exe", "pwsh.exe", "-NoLogo", "-NoProfileLoadTime" }
    },
    {
      label = "WSL1 - Arch",
      args = { "wsl.exe", "-d", "Arch" }
    },
    {
      label = "WSL2 - kali-linux",
      args = { "wsl.exe", "-d", "kali-linux" }
    },
    {
      label = "Local - NuShell",
      args = { "nu" }
    },
    {
      label = "Local - Windows PowerShell",
      args = { "powershell.exe" }
    },
    {
      label = "Local - Command Prompt",
      args = { "cmd.exe" }
    },
    {
      label = "WSL1 - Arch Zsh",
      args = { "wsl.exe", "-d", "Arch", "zsh" }
    },
  }
else
  config.default_prog = { "fish" }
  config.launch_menu = {
    {
      label = "Local - Fish",
      args = { "fish", "-l" }
    },
    {
      label = "Local - Zsh",
      args = { "zsh", "-l" }
    },
    {
      label = "Local - PowerShell",
      args = { "pwsh", "-NoLogo", "-NoProfileLoadTime", "-Login" }
    },
    {
      label = "Local - NuShell",
      args = { "nu", "-l" }
    },
  }
end
--#endregion


return config
