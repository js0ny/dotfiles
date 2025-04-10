return {
  "hrsh7th/nvim-cmp",
  -- lazy = false,
  event = "InsertEnter",
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
    local luasnip = require("luasnip")
    local servers = servers_module.servers
    local servers_config = servers_module.server_config
    -- 默认 LSP 配置
    local default_server_config = {
      capabilities = capabilities,
    }

    -- local raw_keymaps = require("keymaps.cmp_map")(cmp.mapping) -- require("keymaps").cmp_nvim_keymaps(cmp.mapping)
    -- local mapped = set_keymaps(raw_keymaps)
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
      mapping = {
        -- cmp.mapping.preset.insert(mapped),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-f>"] = cmp.mapping.confirm({ select = true }),
        ["<C-b>"] = cmp.mapping.abort(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if luasnip.expandable() then
              luasnip.expand()
            else
              cmp.confirm({
                select = true,
              })
            end
          else
            fallback()
          end
        end),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }, -- cmp.mapping.preset.insert(mapped),
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

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
      matching = { disallow_symbol_nonprefix_matching = false },
    })

    -- 配置 LSP
    for _, server in ipairs(servers) do
      local config = vim.tbl_deep_extend("force", default_server_config, servers_config[server] or {})
      lspconfig[server].setup(config)
    end
  end,
}
