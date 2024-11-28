--[[
-*- coding: utf-8 -*-
@Filename    init.lua
@Author      js0ny
@Date        2024-11-27
@Description neovim 配置文件
]]
-- 加载配置
require("config.options")
-- 加载键位映射
require("config.keymaps")

-- 加载插件
require("plugins")

-- 加载主题
require("config.colorscheme")


-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
