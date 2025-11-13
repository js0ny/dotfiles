---@type vim.lsp.Config
return {
  cmd = { 'tinymist' },
  filetypes = { 'typst' },
  root_markers = { '.git' },
  on_attach = function(client, bufnr)
    for _, command in ipairs {
      'tinymist.exportSvg',
      'tinymist.exportPng',
      'tinymist.exportPdf',
      -- 'tinymist.exportHtml', -- Use typst 0.13
      'tinymist.exportMarkdown',
      'tinymist.exportText',
      'tinymist.exportQuery',
      'tinymist.exportAnsiHighlight',
      'tinymist.getServerInfo',
      'tinymist.getDocumentTrace',
      'tinymist.getWorkspaceLabels',
      'tinymist.getDocumentMetrics',
      'tinymist.pinMain',
    } do
      local cmd_func, cmd_name, cmd_desc = create_tinymist_command(command, client, bufnr)
      vim.api.nvim_buf_create_user_command(bufnr, 'Lsp' .. cmd_name, cmd_func, { nargs = 0, desc = cmd_desc })
    end
  end,
}
