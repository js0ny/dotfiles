return {
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons", -- 图标支持
  after = "catppuccin",
  config = function()
    require("bufferline").setup({
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
        separator_style = "thin",
      },
      highlights = require("catppuccin.groups.integrations.bufferline").get(),
    })
  end,
}
