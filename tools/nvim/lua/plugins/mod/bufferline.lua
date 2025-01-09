return {
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons", -- 图标支持
  config = function()
    require("bufferline").setup({
      options = {
        numbers = "ordinal", -- 显示 buffer 序号
        close_command = "bdelete! %d", -- 关闭 buffer 的命令
        right_mouse_command = "bdelete! %d", -- 右键关闭
        offsets = {
          { filetype = "NvimTree", text = "资源管理器", text_align = "center" },
        },
        separator_style = "thin",
      },
    })
  end,
}
