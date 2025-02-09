local wezterm = require("wezterm")
local os_type = require("utils").detected_os
local color = require("color")

return function(config)
  config.max_fps = 120
  config.font = wezterm.font({
    family = "JetBrainsMono Nerd Font",
  })
  config.color_scheme = "Catppuccin Mocha"
  config.font_size = 12.0
  config.front_end = "WebGpu"
  config.webgpu_power_preference = "HighPerformance"
  if os_type.is_win then
    config.window_background_opacity = 0.7 -- Not working under WebGpu
    config.win32_system_backdrop = "Mica"
  end
  config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  }
  -- Cursor
  config.animation_fps = 120
  config.cursor_blink_ease_in = "EaseOut"
  config.cursor_blink_ease_out = "EaseOut"
  config.default_cursor_style = "BlinkingBlock"
  config.cursor_blink_rate = 650
  -- Visual Bell
  config.visual_bell = {
    fade_in_function = "EaseIn",
    fade_in_duration_ms = 250,
    fade_out_function = "EaseOut",
    fade_out_duration_ms = 250,
    target = "CursorColor",
  }
  -- Command Palette
  config.window_frame = {
    font = wezterm.font("PingFang SC"),
  }

  config.command_palette_fg_color = color.lavender
  config.command_palette_bg_color = color.base
  -- UnixLong / Emacs / AppleSymbols / WindowsLong / WindowsSymbols
  config.ui_key_cap_rendering = "AppleSymbols"
end
