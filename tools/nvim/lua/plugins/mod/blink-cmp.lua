return {
  "saghen/blink.cmp",
  -- optional: provides snippets for the snippet source
  dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },

  -- use a release tag to download pre-built binaries
  version = "*",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "default",
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
      ["<C-f>"] = { "select_and_accept" },
      ["<C-b>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    },
    completion = {
      menu = { border = "single" },
      documentation = { window = { border = "single" } },
    },
    signature = { window = { border = "single" } },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "normal",
    },

    snippets = {
      preset = "luasnip",
    },

    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        org = { "orgmode" },
      },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        orgmode = {
          name = "Orgmode",
          module = "orgmode.org.autocompletion.blink",
          fallbacks = { "buffer" },
        },
      },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
