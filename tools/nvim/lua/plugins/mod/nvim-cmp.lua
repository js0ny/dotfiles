local function set_keymaps(keymaps_cmp)
  local mappings = {}
  for _, map in ipairs(keymaps_cmp) do
    mappings[map.keys] = map.cmd
  end
  return mappings
end

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
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local servers_module = require("config.servers")
    local servers = servers_module.servers
    local servers_config = servers_module.server_config
    -- 默认 LSP 配置
    local default_server_config = {
      capabilities = capabilities,
    }

    local raw_keymaps = require("keymaps").cmp_nvim_keymaps(cmp.mapping)
    local mapped = set_keymaps(raw_keymaps)
    local kind_icons = require("config.icons").lsp_kind
    -- 配置 nvim-cmp
    cmp.setup({
      formatting = {
        format = function(entry, vim_item)
          vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind] or "", vim_item.kind)
          return vim_item
        end,
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert(mapped),
      sources = cmp.config.sources({
        { name = "copilot", priority = 10 },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "lazydev", group_index = 0 },
      }, {
        { name = "buffer" },
        { name = "path" },
      }),
    })

    -- 配置 cmdline 模式
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "cmdline" },
        -- path completion is slow under WSL
        -- Since WSL loads Windows Environment Variables
      },
    })

    -- 配置 LSP
    for _, server in ipairs(servers) do
      local config = vim.tbl_deep_extend("force", default_server_config, servers_config[server] or {})
      lspconfig[server].setup(config)
    end
  end,
}
