local function get_highlight()
  if vim.g.colors_name == "catppuccin" then
    return require("catppuccin.groups.integrations.bufferline").get()
  elseif vim.g.colors_name == "rose-pine" then
    return require("rose-pine.plugins.bufferline")
  end
end

return {
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons", -- 图标支持
  after = "catppuccin",
  event = "VeryLazy",
  keys = {
    { "<leader>b1", "<cmd>BufferLineGoToBuffer 1<CR>", desc = "Switch to Buffer #1" },
    { "<leader>b2", "<cmd>BufferLineGoToBuffer 2<CR>", desc = "Switch to Buffer #2" },
    { "<leader>b3", "<cmd>BufferLineGoToBuffer 3<CR>", desc = "Switch to Buffer #3" },
    { "<leader>b4", "<cmd>BufferLineGoToBuffer 4<CR>", desc = "Switch to Buffer #4" },
    { "<leader>b5", "<cmd>BufferLineGoToBuffer 5<CR>", desc = "Switch to Buffer #5" },
    { "<leader>b6", "<cmd>BufferLineGoToBuffer 6<CR>", desc = "Switch to Buffer #6" },
    { "<leader>b7", "<cmd>BufferLineGoToBuffer 7<CR>", desc = "Switch to Buffer #7" },
    { "<leader>b8", "<cmd>BufferLineGoToBuffer 8<CR>", desc = "Switch to Buffer #8" },
    { "<leader>b9", "<cmd>BufferLineGoToBuffer 9<CR>", desc = "Switch to Buffer #9" },
    { "<leader>b#", "<cmd>BufferLineGoToBuffer #<CR>", desc = "Switch to Buffer #" },
    { "<leader>bb", "<cmd>BufferLinePick<CR>", desc = "Quick Switch Buffers" },
    { "<leader>bD", "<cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
    { "<leader>bxx", "<cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
    { "<leader>bxh", "<cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers Left" },
    { "<leader>bxl", "<cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers Right" },
    { "<leader>bX", "<cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
    { "<leader>bt", "<cmd>BufferLineTogglePin<CR>", desc = "Pin Buffer" },
  },
  opts = {
    options = {
      indicator = {
        icon = "▎", -- this should be omitted if indicator style is not 'icon'
        style = "icon",
      },
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,

      show_buffer_icons = true,
      numbers = "ordinal", -- 显示 buffer 序号
      close_command = "bdelete! %d", -- 关闭 buffer 的命令
      right_mouse_command = "bdelete! %d", -- 右键关闭
      offsets = {
        { filetype = "NvimTree", text = "资源管理器", text_align = "center" },
      },
      separator_style = "slope",
    },
    highlights = get_highlight(),
  },
}
