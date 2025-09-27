--- Available LSP goes here
--- Check https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
--- for available server and name
local M = {}
-- Ensure that the following servers are installed and set
-- Use :Mason to list all available servers
M.servers = {
  "bashls", -- Bash
  "clangd", -- C/C++
  "gopls", -- Go
  "html", -- HTML
  "jsonls", -- JSON
  "lua_ls", -- Lua
  -- "markdown_oxide", -- Markdown
  "pyright", -- Python
  "rust_analyzer", -- Rust
  "taplo", -- TOML
  "ts_ls", -- TypeScript
  "vimls", -- vimscript
  "yamlls", -- YAML
  "beancount", -- Beancount
}

-- Configuration for each server defines here
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
