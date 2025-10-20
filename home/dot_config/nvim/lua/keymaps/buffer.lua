local bufmap = {
  markdown = {
    { mode = "x", keys = "i", cmd = 'c*<C-r>"*', opt = { desc = "Add italic to selected text" } },
    { mode = "x", keys = "b", cmd = 'c**<C-r>"**', opt = { desc = "Add bold to selected text" } },
    { mode = "x", keys = "c", cmd = 'c`<CR><C-r>"<CR>`', opt = { desc = "Add code block to selected text" } },
    { mode = "x", keys = "d", cmd = 'c~~<C-r>"~~', opt = { desc = "Add strikethrough to selected text" } },
    { mode = "x", keys = "h", cmd = 'c==<C-r>"==', opt = { desc = "Add highlight to selected text" } },
  },
  tex = {
    { mode = "x", keys = "i", cmd = 'c\\textit{<C-r>"}', opt = { desc = "Add italic to selected text" } },
    { mode = "x", keys = "b", cmd = 'c\\textbf{<C-r>"}', opt = { desc = "Add bold to selected text" } },
    {
      mode = "x",
      keys = "c",
      cmd = 'c\\begin{verbatim}<CR><C-r>"<CR>\\end{verbatim}',
      opt = { desc = "Add code block to selected text" },
    },
    { mode = "x", keys = "d", cmd = 'c\\sout{<C-r>"}', opt = { desc = "Add strikethrough to selected text" } },
    { mode = "x", keys = "h", cmd = 'c\\hl{<C-r>"}', opt = { desc = "Add highlight to selected text" } },
    { mode = "n", keys = "<leader>cc", cmd = "<cmd>w<CR>", opt = { desc = "Save and compile tex file" } },
    -- { mode = "i", keys = "<C-m><C-m>", cmd = "<cmd>w<CR>", opt = { desc = "Save and compile tex file" } },
  },
  org = {
    { mode = "x", keys = "i", cmd = 'c/<C-r>/"', opt = { desc = "Add italic to selected text" } },
    { mode = "x", keys = "b", cmd = 'c*<C-r>"*', opt = { desc = "Add bold to selected text" } },
    -- {
    --   mode = "x",
    --   keys = "c",
    --   cmd = 'c#+BEGIN_SRC<CR><C-r>"<CR>#+END_SRC',
    --   opt = { desc = "Add code block to selected text" },
    -- },
    { mode = "x", keys = "d", cmd = 'c+<C-r>"+', opt = { desc = "Add strikethrough to selected text" } },
    { mode = "x", keys = "h", cmd = 'c~<C-r>"~', opt = { desc = "Add highlight to selected text" } },
  },
}

local function setup_buffer_maps(buffer_map)
  -- 遍历 buffer_map 中的每个文件类型
  for ft, mappings in pairs(buffer_map) do
    -- 1. 为现有缓冲区设置键位映射
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_get_option(buf, "filetype") == ft then
        for _, mapping in ipairs(mappings) do
          -- 合并选项，添加 buffer 以确保映射是缓冲区局部的
          if mapping.mode ~= "n" then
            mapping.keys = "<C-m>" .. mapping.keys
          end
          local opts = vim.tbl_extend("force", mapping.opt, { buffer = buf })
          vim.keymap.set(mapping.mode, mapping.keys, mapping.cmd, opts)
        end
      end
    end

    -- 2. 为未来缓冲区设置自动命令
    vim.api.nvim_create_autocmd("FileType", {
      pattern = ft, -- 匹配文件类型，例如 "markdown"
      callback = function(args)
        local buf = args.buf -- 获取触发事件的缓冲区号
        for _, mapping in ipairs(mappings) do
          local opts = vim.tbl_extend("force", mapping.opt, { buffer = buf })
          if mapping.mode ~= "n" then
            mapping.keys = "<C-m>" .. mapping.keys
          end
          vim.keymap.set(mapping.mode, mapping.keys, mapping.cmd, opts)
        end
      end,
    })
  end
end

setup_buffer_maps(bufmap)
