local M = {}
-- local mode_arrow = { "n", "v", "o", "s", "x" }

local default_opts = { noremap = true, silent = true }
local default_mode = { "n" }

M.set_keymaps = function(maps)
  for _, map in ipairs(maps) do
    local opts = vim.tbl_extend("force", default_opts, map.opts or {})
    local mode = map.mode or default_mode
    vim.keymap.set(mode, map.keys, map.cmd, opts)
  end
end

M.set_lang_keymaps = function(maps)
  vim.api.create_autocmd("FileType", {
    pattern = maps.filetype,
    callback = function()
      M.set_keymaps(maps.keymaps)
    end,
  })
end

M.set_buf_keymaps = function(maps)
  vim.api.create_autocmd("BufEnter", {
    pattern = maps.filetype,
    callback = function()
      M.set_keymaps(maps.keymaps)
    end,
  })
end

return M
