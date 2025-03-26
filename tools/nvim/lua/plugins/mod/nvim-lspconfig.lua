return {
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },
  event = {
    "BufReadPost",
    "BufWritePost",
    "BufNewFile",
  },

  -- example using `opts` for defining servers
  opts = {
    servers = {
      lua_ls = {},
      bashls = {},
      clangd = {},
      eslint = {}, -- JavaScript
      gopls = {}, -- Go
      jsonls = {}, -- JSON
      markdown_oxide = {}, -- Markdown
      omnisharp = {}, -- C# & F#
      powershell_es = {}, -- PowerShell
      pyright = {}, -- Python
      taplo = {}, -- TOML
      rust_analyzer = {}, -- Rust
      ts_ls = {}, -- TypeScript
      vimls = {}, -- vimscript
      yamlls = {}, -- YAML
      beancount = {}, -- Beancount
    },
  },
  config = function(_, opts)
    local lspconfig = require("lspconfig")
    for server, config in pairs(opts.servers) do
      -- passing config.capabilities to blink.cmp merges with the capabilities in your
      -- `opts[server].capabilities, if you've defined it
      config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end,

  -- example calling setup directly for each LSP
  -- config = function()
  --   local capabilities = require('blink.cmp').get_lsp_capabilities()
  --   local lspconfig = require('lspconfig')
  --
  --   lspconfig['lua_ls'].setup({ capabilities = capabilities })
  -- end
}
