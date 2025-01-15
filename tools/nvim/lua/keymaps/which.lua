local wk = require("which-key")
wk.add({
  -- https://github.com/folke/which-key.nvim/tree/main?tab=readme-ov-file#%EF%B8%8F-mappings
  {
    -- Nested mappings are allowed and can be added in any order
    -- Most attributes can be inherited or overridden on any level
    -- There's no limit to the depth of nesting
    mode = { "n" },
    { "<leader>b", group = "Buffer" }, -- no need to specify mode since it's inherited
    { "<leader>c", group = "Code/Compile" },
    { "<leader>f", group = "File" },
    { "<leader>p", group = "Project", icon = "" },
    { "<leader>q", group = "Quit" },
    { "<leader>t", group = "Toggle" },
    { "<leader>u", group = "UI" },
    { "<leader>w", group = "Window" },
  },
  { -- https://github.com/folke/which-key.nvim/blob/1f8d414f61e0b05958c342df9b6a4c89ce268766/lua/which-key/plugins/presets.lua#L57-L98
    -- text objects
    mode = { "o", "x" },
    { "l", group = "inside" },
    { 'l"', desc = 'inner " string' },
    { "l'", desc = "inner ' string" },
    { "l(", desc = "inner [(])" },
    { "l)", desc = "inner [(])" },
    { "l<", desc = "inner <>" },
    { "l>", desc = "inner <>" },
    { "lB", desc = "inner [{]}" },
    { "lW", desc = "inner WORD" },
    { "l[", desc = "inner []" },
    { "l]", desc = "inner []" },
    { "l`", desc = "inner ` string" },
    { "lb", desc = "inner [(])" },
    { "lp", desc = "inner paragraph" },
    { "ls", desc = "inner sentence" },
    { "lt", desc = "inner tag block" },
    { "lw", desc = "inner word" },
    { "l{", desc = "inner [{]}" },
    { "l}", desc = "inner [{]}" },
    { "i", desc = "Right" },
  },
})
