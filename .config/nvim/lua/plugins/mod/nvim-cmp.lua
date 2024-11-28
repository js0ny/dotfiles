
--- Available LSP goes here
--- Check https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
--- for available server and name



return {
  "hrsh7th/nvim-cmp",
  lazy = false,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    local lspconfig = require("lspconfig")
    local capabitilies = require("cmp_nvim_lsp").default_capabilities()
    local servers = require("config.servers").servers
    local servers_config = require("config.servers").server_config
    local default_server_config = {
      capabilities = capabitilies,
    }

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },

      sources = cmp.config.sources(
      -- This order defines the priority of sources.
      {
        { name = "nvim_lsp" },
        { name = "luasnip" },
      },
      {
        { name = "buffer" },
        { name = "path" },
      }
      ),
    })
    local keymaps = require("keymaps")
    local keymaps_cmp = keymaps.cmp_nvim_keymaps(cmp.mapping)

    local function set_keymaps()
      local mappings = {}
        for _, map in ipairs(keymaps_cmp) do
          mappings[map.keys] = map.cmd
        end
        return mappings
    end
    cmp.setup.mapping = cmp.mapping.preset.insert(set_keymaps())
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "cmdline" },
        -- Use `path` is slow under WSL since WSL loads Windows paths
        -- https://github.com/zsh-users/zsh-syntax-highlighting/issues/790
        -- { name = "path" },
      }
    })

    for _, server in ipairs(servers) do
      local config = servers_config[server] or {}
      config = vim.tbl_extend("force", default_server_config, config)
      lspconfig[server].setup(config)
    end
  end,
}
