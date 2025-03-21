return {
  "nvim-orgmode/orgmode",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-orgmode/telescope-orgmode.nvim",
    "nvim-orgmode/org-bullets.nvim",
    "Saghen/blink.cmp",
  },
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
    vim.keymap.set("n", "<leader>r", require("telescope").extensions.orgmode.refile_heading)
    vim.keymap.set("n", "<leader>fh", require("telescope").extensions.orgmode.search_headings)
    vim.keymap.set("n", "<leader>li", require("telescope").extensions.orgmode.insert_link)
  end,
}
