local function my_on_attach(bufnr)
  -- local keymaps = require("config.keymaps")
  local api = require("nvim-tree.api")
  local default_mode = { "n" }
  local keymaps = require("keymaps")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  local function set_keymaps(maps)
    for _, map in ipairs(maps) do
      local mode = map.mode or default_mode
      vim.keymap.set(mode, map.keys, map.cmd, map.opts)
    end
  end

  local raw_keymaps = require("keymaps.nvim-tree").plugin(api, opts)
  set_keymaps(raw_keymaps)
end

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      on_attach = my_on_attach,
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
    })
  end,
}
