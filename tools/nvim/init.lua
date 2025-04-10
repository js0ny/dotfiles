--[[
-*- coding: utf-8 -*-
@Filename    init.lua
@Author      js0ny
@Date        2024-11-27
@Description neovim 配置文件
]]

-- Entry point of neovim configuration
require("config.options")
if vim.g.vscode then -- TODO: VSCode Neovim Integration
  require("config.vscode")
else -- Vanilla neovim
  require("config.plugins")
  require("config.colorscheme")
end
require("config.keymaps")
require("config.diagnostics")
require("config.migration")

-- If current session is spawn by neovide, do:
if vim.g.neovide then
  -- Enable input method
  vim.g.neovide_input_ime = true
  vim.g.neovide_transparency = 0.85
  vim.g.transparency = 0.85
  vim.g.neovide_normal_opacity = 0.85
  vim.g.neovide_window_blurred = true -- macOS only
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"
end
