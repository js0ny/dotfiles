vim.g.input_layout = nil

local function fcitx2en()
  local current_layout = vim.fn.system("fcitx5-remote -n")
  vim.g.input_layout = vim.trim(current_layout)
  vim.fn.system("fcitx5-remote -s keyboard-us")
end

local function fcitx2zh()
  if vim.g.input_layout ~= nil and vim.g.input_layout ~= "" then
    vim.fn.system("fcitx5-remote -s " .. vim.g.input_layout)
  end
end

vim.opt.ttimeoutlen = 150

local fcitx_group = vim.api.nvim_create_augroup("FcitxToggle", { clear = true })

vim.api.nvim_create_autocmd("InsertLeave", {
  group = fcitx_group,
  callback = fcitx2en,
})

vim.api.nvim_create_autocmd("InsertEnter", {
  group = fcitx_group,
  callback = fcitx2zh,
})
