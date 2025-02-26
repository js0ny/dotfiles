return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
  },
  { import = "plugins.mod.render-markdown" },
  -- { import = "plugins.mod.markview" },
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "sioyek"
    end,
  },
  {
    "iurimateus/luasnip-latex-snippets.nvim",
    -- vimtex isn't required if using treesitter
    requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    config = function()
      require("luasnip-latex-snippets").setup()
      -- or setup({ use_treesitter = true })
      require("luasnip").config.setup({ enable_autosnippets = true })
    end,
  },
  { "williamboman/mason.nvim", config = true },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = {
      { "williamboman/mason.nvim" },
      { "neovim/nvim-lspconfig" },
    },
    opts = {
      ensure_installed = require("config.servers").servers,
      automatic_installation = false,
    },
  },
  { import = "plugins.mod.conform-nvim" },
  { "nvim-treesitter/nvim-treesitter-context" },
  {
    "NoahTheDuke/vim-just",
    ft = { "just" },
  },
  {
    "akinsho/org-bullets.nvim",
    config = function()
      require("org-bullets").setup()
    end,
  },
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = function()
      -- Setup orgmode
      require("orgmode").setup({
        org_agenda_files = "~/OrgFiles/tasks/*",
        org_default_notes_file = "~/OrgFiles/tasks/inbox.org",
        org_archive_location = "~/OrgFiles/archive/%s_archive::",
        org_todo_keywords = { "TODO(t)", "NEXT(n)", "WAIT(w)", "|", "DONE(d)", "CANCELLED(c)" },
        org_hide_leading_stars = true,
        org_hide_emphasis_markers = true,
        org_log_into_drawer = "LOGBOOK",
        org_highlight_latex_and_related = "native",
        org_startup_indented = true,
        org_deadline_warning_days = 10,
      })

      -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
      -- add ~org~ to ignore_install
      -- require('nvim-treesitter.configs').setup({
      --   ensure_installed = 'all',
      --   ignore_install = { 'org' },
      -- })
    end,
  },
  { import = "plugins.mod.trouble-nvim" },
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    opts = {
      ensure_installed = { "markdown", "markdown_inline", "latex", "python" },
      highlight = { enable = true },
      indent = { enable = true },
    },
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
