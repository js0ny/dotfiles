return {
  "js0ny/multiple-cursors.nvim",
  version = "*",   -- Use the latest tagged version
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
}
