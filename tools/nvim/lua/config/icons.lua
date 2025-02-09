-- icons.lua
-- All icons used in the configuration are defined in this file.
-- Currently are only used in diagnostics, lualine, gitsigns
local M = {
  diagnostics = {
    Error = "",
    Warning = "",
    Hint = "",
    Information = "",
  },
  lsp = "",
  indent = "",
  git = {
    Change = "",
    Add = "",
    Delete = "",
    Rename = "",
    Branch = "",
  },
  lsp_kind = {
    Text = "󰉿",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰜢",
    Variable = "󰀫",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "󰑭",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "󰈇",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "󰙅",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰅲",
  },
}

return M
