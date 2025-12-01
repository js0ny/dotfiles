---@type vim.lsp.Config
return {
  cmd = { "svelteserver" },
  root_markers = { "package.json", "svelte.config.js" },
  filetypes = { "svelte" },
  settings = {},
}
