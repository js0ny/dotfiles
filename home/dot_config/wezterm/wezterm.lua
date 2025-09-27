-- vim: foldmethod=marker  foldmarker=#region,#endregion
-- $DOTFILES/tools/wezterm/wezterm.lua
-- Date: 2024-12-22
-- Author: js0ny

local wezterm = require("wezterm")
local color = require("color")

local config = wezterm.config_builder()

require("tab")(config)
require("appearance")(config)
require("keymaps")(config)
require("launcher")(config)
require("misc")(config)

return config
