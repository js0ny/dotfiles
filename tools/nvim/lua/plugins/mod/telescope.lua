return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      prompt_prefix = require("config.icons").telescope,
      selection_caret = " ",
      entry_prefix = " ",
      layout_config = { -- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/configs/telescope.lua
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
        },
        width = 0.87,
        height = 0.80,
      },
      mappings = {
        n = {
          ["n"] = "move_selection_next",
          ["e"] = "move_selection_previous",
          ["w"] = "preview_scrolling_up",
          ["r"] = "preview_scrolling_down",
          ["a"] = "preview_scrolling_left",
          ["s"] = "preview_scrolling_right",
          ["q"] = require("telescope.actions").close,
        },
      },
    },
  },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader><leader>", ":Telescope find_files<CR>", desc = "Find Files" },
    { "<leader>/", ":Telescope live_grep<CR>", desc = "Grep Files" },
    { "<leader>;", ":Telescope<CR>", desc = "Show Telescope Commands" },
    { "<leader>ui", ":Telescope colorscheme<CR>", desc = "Change colorscheme" },
    { "<leader>pp", ":Telescope projects<CR>", desc = "List all Projects" },
    { "<leader>pg", ":Telescope projects<CR>", desc = "List all Git Projects" },
    { "<leader>ps", ":Telescope session-lens<CR>", desc = "List all sessions" },
    { "<leader>gs", ":Telescope git_status<CR>", desc = "Git Status" },
    { "<leader>gt", ":Telescope git_branches<CR>", desc = "Git Branches" },
    { "<leader>gc", ":Telescope git_commits<CR>", desc = "Show commits" },
    { "<leader>fb", ":Telescope buffers<CR>", desc = "List Buffers" },
    { "<leader>ff", ":Telescope fd<CR>", desc = "Find Files" },
    { "<leader>ce", ":Telescope diagnostics<CR>", desc = "Navigate errors/warnings" },
    { "<leader>cs", ":Telescope treesitter<CR>", desc = "Search symbols" },
    { "<leader>cS", ":Telescope grep_string<CR>", desc = "Search current symbol" },
    { "<leader>bB", ":Telescope buffers<CR>", desc = "List Buffers" },
    { "<leader>fl", ":Telescope filetypes", desc = "Set Filetype/Lang to ..." },
  },
}
