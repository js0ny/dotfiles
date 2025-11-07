-- alpha-nvim.lua
return {
  {
    "goolord/alpha-nvim",
    dependencies = {},
    keys = {
      { "<leader>ba", "<cmd>Alpha<CR>", desc = "Toggle Alpha Dashboard" },
    },
    cmd = {
      "Alpha",
    },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        "                                                                              ",
        "=================     ===============     ===============   ========  ========",
        "\\\\ . . . . . . .\\\\   //. . . . . . .\\\\   //. . . . . . .\\\\  \\\\. . .\\\\// . . //",
        "||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\\/ . . .||",
        "|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||",
        "||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||",
        "|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\\ . . . . ||",
        "||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\\_ . .|. .||",
        "|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\\ `-_/| . ||",
        "||_-' ||  .|/    || ||    \\|.  || `-_|| ||_-' ||  .|/    || ||   | \\  / |-_.||",
        "||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \\  / |  `||",
        "||    `'         || ||         `'    || ||    `'         || ||   | \\  / |   ||",
        "||            .===' `===.         .==='.`===.         .===' /==. |  \\/  |   ||",
        "||         .=='   \\_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \\/  |   ||",
        "||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \\/  |   ||",
        "||   .=='    _-'          `-__\\._-'         `-_./__-'         `' |. /|  |   ||",
        "||.=='    _-'                                                     `' |  /==.||",
        "=='    _-'                 j s 0 n y        N E O V I M               \\/   `==",
        "\\   _-'                                                                `-_   /",
        " `''                                                                      ``'  ",
      }
      dashboard.section.buttons.val.leader = "SPC"
      dashboard.section.buttons.val = {
        -- leader = "SPC",
        dashboard.button("p", "󰈞 查找项目", "<cmd>Telescope projects<CR>"),
        dashboard.button("h", " 历史文件", "<cmd>Telescope oldfiles<CR>"),
        dashboard.button("l", " 加载会话", "<cmd>SessionSearch<CR>"),
        dashboard.button("c", " 转到设置", "<cmd>Telescope find_files cwd=~/.config/nvim<CR>"),
        dashboard.button("SPC q", "󱊷 退出", "<cmd>qa<CR>"),
      }
      dashboard.section.footer.val = "今日 " .. os.date("%Y-%m-%d %A") .. "  "

      dashboard.config.opts.noautocmd = true

      -- vim.cmd[[autocmd User AlphaReady echo 'Alpha ready!']]

      alpha.setup(dashboard.config)
    end,
  },
}
