return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup({
      detection_methods = { "lsp", "pattern" },
      patterns = { ".git", "Makefile", "package.json" },
      sync_root_with_cwd = true,
      silent_chdir = true,
      scope_chdir = "global",
    })

    require("telescope").load_extension("projects")
  end,
  dependencies = { "nvim-telescope/telescope.nvim" },
}
