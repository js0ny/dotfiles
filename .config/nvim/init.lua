--[[
-*- coding: utf-8 -*-
@Filename    init.lua
@Author      js0ny
@Date        2024-11-27
@Description neovim 配置文件
]]
-- 针对特定文件类型设置快捷键
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown", -- 指定文件类型
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "v", "`", "c`<C-r>\"`<Esc>", { noremap = true, silent = true, desc = "Wrap selection with backticks" })
    end,
})

-- 加载配置
require("config.options")
-- 加载键位映射
require("config.keymaps")

-- 加载插件
require("config.plugins")

-- 加载主题
require("config.colorscheme")


-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
