return {
  { import = "plugins.mod.nvim-lspconfig" },
  {
    "lervag/vimtex",
    ft = { "tex", "bib" },
    -- lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "okular"
    end,
  },
  {
    "js0ny/luasnip-latex-snippets.nvim",
    ft = { "tex", "markdown" },
    -- vimtex isn't required if using treesitter
    requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    config = function()
      require("luasnip-latex-snippets").setup()
      -- or setup({ use_treesitter = true })
      require("luasnip").config.setup({ enable_autosnippets = true })
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      -- ensure_installed = require("config.servers").servers,
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "BufReadPre",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "neovim/nvim-lspconfig" },
    },
    opts = {
      -- ensure_installed = require("config.servers").servers,
      -- automatic_installation = false,
    },
  },
  { import = "plugins.mod.conform-nvim" },
  { "nvim-treesitter/nvim-treesitter-context", lazy = true },
  {
    "NoahTheDuke/vim-just",
    ft = { "just" },
  },
  { import = "plugins.mod.lang.org" },
  { import = "plugins.mod.lang.markdown" },
  { import = "plugins.mod.trouble-nvim" },
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    cmd = {
      "TSInstall",
      "TSUpdate",
      "TSUpdateSync",
    },
    event = {
      "VeryLazy",
    },
    opts = {
      ensure_installed = { "c", "lua", "vim", "vimdoc", "markdown", "markdown_inline" },
      highlight = { enable = true },
      indent = { enable = true },
    },
    -- config = function(_, opts)
    --   require("nvim-treesitter.configs").setup(opts)
    -- end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
