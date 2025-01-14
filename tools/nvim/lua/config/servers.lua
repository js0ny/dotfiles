--- Available LSP goes here
--- Check https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
--- for available server and name
local M = {}
M.servers = {
  "clangd", -- C/C++
  -- "cmake",                   -- CMake
  "eslint", -- JavaScript
  "html", -- HTML
  "lua_ls", -- Lua
  "omnisharp", -- C# & F#
  "powershell_es", -- PowerShell
  "pyright", -- Python
  "vimls", -- vimscript
}

M.server_config = {
  lua_ls = {
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
      },
    },
  },
}

return M
