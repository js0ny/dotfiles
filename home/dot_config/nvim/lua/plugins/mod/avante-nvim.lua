return {
  "yetone/avante.nvim",
  event = "BufRead",
  -- lazy = false,
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  ---@module "avante"
  ---@type avante.Config
  opts = {
    provider = "openrouter",

    -- add any opts here
    -- for example
    providers = {
      ---@type AvanteProvider
      openrouter = {
        __inherited_from = "openai",
        endpoint = "https://openrouter.ai/api/v1",
        model = "anthropic/claude-sonnet-4.5",
        model_names = {
          "openai/gpt-5.1-codex",
          "google/gemini-3-pro-preview",
          "anthropic/claude-sonnet-4.5",
          "x-ai/grok-code-fast-1",
        },
        api_key_name = "OPENROUTER_API_KEY",
      },
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    -- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "ibhagwan/fzf-lua",
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    "HakonHarnes/img-clip.nvim",
  },
}
