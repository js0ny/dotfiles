return {
  "yetone/avante.nvim",
  event = "BufRead",
  -- lazy = false,
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  opts = {
    -- add any opts here
    -- for example
    provider = "openai",
    openai = {
      endpoint = "https://aihubmix.com/v1",
      model = "claude-3-7-sonnet-20250219", -- your desired model (or use gpt-4o, etc.)
      timeout = 30000,                      -- timeout in milliseconds
      temperature = 0,                      -- adjust if needed
      max_tokens = 4096,
      -- reasoning_effort = "high"    -- only supported for "o" models
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
    "hrsh7th/nvim-cmp",            -- autocompletion for avante commands and mentions
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua",      -- for providers='copilot'
    "HakonHarnes/img-clip.nvim",
  },
}
