--[[
-*- coding: utf-8 -*-
@Filename    init.lua
@Author      js0ny
@Date        2024-11-27
@Description neovim 配置文件
]]

-- Entry point of neovim configuration
require("config.options")

local minimal = os.getenv("NVIM_MINIMAL") or os.getenv("EDITOR_POPUP")
local disable_ai = os.getenv("DISABLE_AI_ASSISTANT") or "0"

if disable_ai == "1" then
  vim.g.ai_enabled = false
else
  vim.g.ai_enabled = true
end

if minimal == "1" then
  -- require("profiles.minimal")
  vim.keymap.set("n", "<C-s>", ":wq!<CR>", { noremap = true, silent = true })
  return
end

local term = os.getenv("TERM") or ""
if vim.g.vscode then -- TODO: VSCode Neovim Integration
  require("profiles.vscode")
-- Under tty
-- if under gui, the term will be set to linux as well, additional check required.
elseif term == "linux" and not vim.fn.has("gui_running") then
  require("profiles.tty")
  vim.cmd("colorscheme vim") -- Use minimal colorscheme
else
  require("profiles.vanilla")
  require("config.colorscheme")
end
require("config.keymaps")
require("config.diagnostics")
require("config.lsp")

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

-- TODO: Refractor this part to submodules
-- 存储输入法状态的变量
vim.g.input_layout = nil

-- 退出插入模式时：记录当前输入法并切换到英文
local function fcitx2en()
  -- 使用 fcitx5-remote -n 获取当前输入法名称
  local current_layout = vim.fn.system("fcitx5-remote -n")
  -- 去除换行符
  vim.g.input_layout = vim.trim(current_layout)

  -- 切换到英文输入法
  vim.fn.system("fcitx5-remote -s keyboard-us")
end

-- 进入插入模式时：恢复之前的输入法状态
local function fcitx2zh()
  -- 如果之前记录了输入法状态，则恢复
  if vim.g.input_layout ~= nil and vim.g.input_layout ~= "" then
    vim.fn.system("fcitx5-remote -s " .. vim.g.input_layout)
  end
end

-- 设置 ttimeoutlen
vim.opt.ttimeoutlen = 150

-- 创建自动命令组
local fcitx_group = vim.api.nvim_create_augroup("FcitxToggle", { clear = true })

-- 退出插入模式时切换到英文并记录状态
vim.api.nvim_create_autocmd("InsertLeave", {
  group = fcitx_group,
  callback = fcitx2en,
})

-- 进入插入模式时恢复之前的输入法
vim.api.nvim_create_autocmd("InsertEnter", {
  group = fcitx_group,
  callback = fcitx2zh,
})
