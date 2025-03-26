return {
  {
    "folke/flash.nvim",
    event = "BufEnter",
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  {
    "js0ny/multiple-cursors.nvim",
    version = "*", -- Use the latest tagged version
    -- opts = , -- This causes the plugin setup function to be called
    keys = {
      { "<A-n>",         "<Cmd>MultipleCursorsAddDown<CR>",        mode = { "n", "x" },      desc = "Add cursor and move down" },
      { "<A-e>",         "<Cmd>MultipleCursorsAddUp<CR>",          mode = { "n", "x" },      desc = "Add cursor and move up" },

      { "<C-Up>",        "<Cmd>MultipleCursorsAddUp<CR>",          mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
      { "<C-Down>",      "<Cmd>MultipleCursorsAddDown<CR>",        mode = { "n", "i", "x" }, desc = "Add cursor and move down" },

      { "<A-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = { "n", "i" },      desc = "Add or remove cursor" },
    },
    config = function()
      local normal_mode_motion = require("multiple-cursors.normal_mode.motion")
      local normal_mode_edit = require("multiple-cursors.normal_mode.edit")

      local visual_mode_edit = require("multiple-cursors.visual_mode.edit")
      local normal_mode_mode_change = require("multiple-cursors.normal_mode.mode_change")

      local visual_mode_modify_area = require("multiple-cursors.visual_mode.modify_area")
      require("multiple-cursors").setup({
        pre_hook = function()
          require("nvim-autopairs").disable()
        end,
        post_hook = function()
          require("nvim-autopairs").enable()
        end,
        custom_key_maps = {
          { { "n", "x" }, { "e", "<Up>" },               normal_mode_motion.k,      "nowrap" },
          { { "n", "x" }, { "n", "<Down>" },             normal_mode_motion.j,      "nowrap" },
          { { "n", "x" }, { "i", "<Right>", "<Space>" }, normal_mode_motion.l,      "nowrap" },
          { { "n", "x" }, "j",                           normal_mode_motion.e,      "nowrap" },
          { { "n", "x" }, "J",                           normal_mode_motion.E,      "nowrap" },
          { { "n", "x" }, "gj",                          normal_mode_motion.ge,     "nowrap" },
          { { "n", "x" }, "gJ",                          normal_mode_motion.gE,     "nowrap" },
          { "n",          "E",                           normal_mode_edit.J,        "nowrap" },
          { "n",          "gE",                          normal_mode_edit.gJ,       "nowrap" },
          { "n",          { "l", "<Insert>" },           normal_mode_mode_change.i, "nowrap" },
          { "n",          "L",                           normal_mode_mode_change.I, "nowrap" },
          { "x",          "l",                           visual_mode_modify_area.i, "nowrap" },
          { "x",          "E",                           visual_mode_edit.J,        "nowrap" },
          { "x",          "gE",                          visual_mode_edit.gJ,       "nowrap" },
        },
      })
    end,
  },
  { import = "plugins.mod.autopairs" },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "BufEnter",
    opts = {},
  },
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>fF",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
}
