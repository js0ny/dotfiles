local M = {}

-- Markdown

local function set_markdown_keymaps(bufnr)
  local markdown_opt = { noremap = true, silent = true, buffer = bufnr }
  for _, map in ipairs(M.markdown) do
    local opts = vim.tbl_extend("force", markdown_opt, map.opts or {})
    vim.keymap.set(map.mode, map.keys, map.cmd, opts)
  end
end

M.markdown = {
  { mode = "v", keys = "`", cmd = "c`<Esc>pi`<Esc>", desc = "Wrap selection in ` for inline code" },
  { mode = "v", keys = "*", cmd = "c**<Esc>pi**<Esc>", desc = "Wrap selection in ** for bold" },
  { mode = "v", keys = "_", cmd = "c*<Esc>pi*<Esc>", desc = "Wrap selection in * for italic" },
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    set_markdown_keymaps(0)
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

--- buffer that doesn't act as an editor or common buffer.
--- Use `q` to close the buffer.
local tmp_buf = {
  "qf", -- quickfix
  "crunner", -- code runner
}

M.tmp_buf_keymaps = {
  { mode = "n", keys = "q", cmd = "<Cmd>q<CR>", desc = "Close buffer" },
}

for _, buf in ipairs(tmp_buf) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = buf,
    callback = function()
      for _, map in ipairs(M.tmp_buf_keymaps) do
        local opts = vim.tbl_extend("force", { buffer = 0 }, map.opts or {})
        vim.keymap.set(map.mode, map.keys, map.cmd, opts)
      end
    end,
  })
end

return M
