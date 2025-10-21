return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "FzfLua",
  --stylua: ignore start
  keys = {
    { "<leader><leader>", function() require("fzf-lua").files() end,                                          desc = "Find Files" },
    { "<leader>fc",       function() require("fzf-lua").files({ cwd="~/.dotfiles/home/dot_config/nvim"}) end, desc = "Edit configs" },
    { "<leader>/",        function() require("fzf-lua").live_grep() end,                                      desc = "Grep Files" },
    { "<leader>;",        function() require("fzf-lua").commands() end,                                       desc = "Show Telescope Commands" },
    { "<leader>ui",       function() require("fzf-lua").colorschemes() end,                                   desc = "Change colorscheme" },
    -- find_files { "<leader>pp",       require("fzf-lua").projects,                 des                      c = "Listfind_files  all Projects" },
    { "<leader>pd",       function() require("fzf-lua").zoxide() end,                                         desc = "List recent directories" },
    -- { "<leader>pg",       require("fzf-lua").projects,                 desc = "List all Git Projects" },
    { "<leader>gs",       function() require("fzf-lua").git_status() end,                                     desc = "Git Status" },
    { "<leader>gt",       function() require("fzf-lua").git_branches() end,                                   desc = "Git Branches" },
    { "<leader>gc",       function() require("fzf-lua").git_commits() end,                                    desc = "Show commits" },
    { "<leader>fb",       function() require("fzf-lua").buffers() end,                                        desc = "List Buffers" },
    { "<leader>ff",       function() require("fzf-lua").files() end,                                          desc = "Find Files" },
    { "<leader>fh",       function() require("fzf-lua").oldfiles() end,                                       desc = "Recent Files" },
    -- { "<leader>ce",       require("fzf-lua").diagnostics(),              desc = "Navi                      gate errors/warnings" },
    { "<leader>cs",       function() require("fzf-lua").treesitter() end,                                     desc = "Search symbols" },
    { "<leader>cS",       function() require("fzf-lua").grep_visual() end,                                    desc = "Search current symbol" },
    { "<leader>bB",       function() require("fzf-lua").buffers() end,                                        desc = "List Buffers" },
    { "<leader>fl",       function() require("fzf-lua").filetypes() end,                                      desc = "Set Filetype/Lang to ..." },
    { "<leader>R",        function() require("fzf-lua").resume() end,                                         desc = "Resume FzfLua" },
  },
  --stylua: ignore end
  opts = {},
}
