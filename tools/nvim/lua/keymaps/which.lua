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
    { "<leader>p", group = "Project" },
    { "<leader>q", group = "Quit" },
    { "<leader>t", group = "Toggle" },
    { "<leader>u", group = "UI" },
    { "<leader>w", group = "Window" },
  },
  {
    "l",
    mode = { "o", "x" },
    group = "inside",
  },
})
