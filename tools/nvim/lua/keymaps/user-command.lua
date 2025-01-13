vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

vim.api.nvim_create_user_command("FormatToggle", function(args)
  local buffer_local = args.bang
  if buffer_local then
    -- Toggle buffer-local formatting
    vim.b.disable_autoformat = not vim.b.disable_autoformat
  else
    -- Toggle global formatting
    vim.g.disable_autoformat = not vim.g.disable_autoformat
  end

  -- Print current status
  local scope = buffer_local and "buffer" or "global"
  local status = buffer_local and vim.b.disable_autoformat or vim.g.disable_autoformat
  print(string.format("Format-on-save %s: %s", scope, status and "disabled" or "enabled"))
end, {
  desc = "Toggle autoformat-on-save (use ! for buffer-local)",
  bang = true,
})
