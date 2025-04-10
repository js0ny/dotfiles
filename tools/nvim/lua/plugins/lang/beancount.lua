-- 在 init.lua 或者你的配置文件中添加
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.bean",
  callback = function()
    vim.bo.filetype = "beancount"
  end,
})


return {
  "nathangrigg/vim-beancount",
  ft = "beancount",
}
