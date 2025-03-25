return {
  {
    -- "js0ny/nvim-orgmode",
    name = "orgmode",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-orgmode/telescope-orgmode.nvim",
      "nvim-orgmode/org-bullets.nvim",
      "Saghen/blink.cmp",
    },
    branch = "feat-image-match-latex",
    cmd = {
      "Org",
    },
    keys = {
      { "<leader>A", "<cmd>Org agenda<CR>", desc = "Org Agenda" },
    },
    dir = "~/Source/Forks/nvim-orgmode",
    dev = true,
    event = "VeryLazy",
    config = function()
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
        mappings = {
          agenda = {
            org_agenda_schedule = "<C-c><C-s>",
            org_agenda_deadline = "<C-c><C-d>",
            org_agenda_todo = "<C-c><C-t>",
            org_agenda_set_tags = "<C-c><C-c>",
            org_agenda_earlier = { "[[", "<" },
            org_agenda_later = { "]]", ">" },
          },
          org = {
            org_deadline = "<C-c><C-d>",
            org_schedule = "<C-c><C-s>",
            org_todo = "<C-c><C-t>",
            org_set_tags_command = "<C-c><C-c>",
          },
        },
      })
      require("org-bullets").setup()
      require("blink.cmp").setup({
        sources = {
          per_filetype = {
            org = { "orgmode" },
          },
          providers = {
            orgmode = {
              name = "Orgmode",
              module = "orgmode.org.autocompletion.blink",
              fallbacks = { "buffer" },
            },
          },
        },
      })

      require("telescope").setup()
      require("telescope").load_extension("orgmode")
      -- vim.keymap.set("n", "<leader>r", require("telescope").extensions.orgmode.refile_heading)
      vim.keymap.set("n", "<leader>oP", require("telescope").extensions.orgmode.search_headings)
      vim.keymap.set("n", "<leader>op", "<cmd>Telescope find_files cwd=~/OrgFiles<CR>")
      -- vim.keymap.set("n", "<leader>li", require("telescope").extensions.orgmode.insert_link)
    end,
  },
  -- {
  --   dir = "~/Source/org-pomodoro.nvim",
  --   name = "org-pomodoro.nvim",
  --   lazy = false,
  --   opts = {},
  --   dependencies = {
  --     "nvim-orgmode/orgmode",
  --   },
  --   cmd = {
  --     "OrgPomodoro",
  --   },
  -- },
}
