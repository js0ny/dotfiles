--- `map` default for `cmp.mapping`
local map = function(map)
  return {
    { keys = "<C-n>",     cmd = map.select_next_item(),         opts = { desc = "Select next completion item" } },
    { keys = "<C-p>",     cmd = map.select_prev_item(),         opts = { desc = "Select previous completion item" } },
    { keys = "<C-f>",     cmd = map.confirm({ select = true }), opts = { desc = "Confirm completion" } },
    { keys = "<Tab>",     cmd = map.confirm({ select = true }), opts = { desc = "Confirm completion" } },
    { keys = "<C-Space>", cmd = map.complete(),                 opts = { desc = "Trigger completion" } },
    { keys = "<C-b>",     cmd = map.abort(),                    opts = { desc = "Abort completion" } },
  }
end

return map
