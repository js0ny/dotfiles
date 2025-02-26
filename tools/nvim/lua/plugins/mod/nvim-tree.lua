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
  keys = {
    { "<leader>ft", ":NvimTreeToggle<CR>", desc = "Toggle File Explorer" },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    on_attach = my_on_attach,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    disable_netrw = true,
    renderer = {
      icons = {
        glyphs = {
          git = { -- https://github.com/nvim-neo-tree/neo-tree.nvim/blob/main/doc/neo-tree.txt#L1077C1-L1077C29
            unmerged = "",
            renamed = "➜",
            deleted = "",
            untracked = "",
            ignored = "",
            unstaged = "󰄱",
            staged = "",
          },
        },
      },
    },
  },
}
