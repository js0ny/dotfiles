local M = {}

--- buffer that doesn't act as an editor or common buffer.
--- Use `q` to close the buffer.
local tmp_buf = {
  "qf", -- quickfix
  "crunner", -- code runner
}

local term_buf = {
  "floaterm",
  "term",
}

local term_mode = {
  "n",
  "i",
  "t",
}

local term_keymaps = {
  { mode = term_mode, keys = "<C-q>", cmd = ":FloatermToggle", desc = "Exit terminal mode" },
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

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    -- 检查当前 buffer 的 buftype
    local buftype = vim.bo.buftype
    if buftype == "terminal" then
      for _, map in ipairs(term_keymaps) do
        local opts = vim.tbl_extend("force", { buffer = 0 }, map.opts or {})
        vim.keymap.set(map.mode, map.keys, map.cmd, opts)
      end
    end
  end,
})

return M
