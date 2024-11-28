-- alpha-nvim.lua
return {
  {
    'goolord/alpha-nvim',
    dependencies = {
      -- 'echasnovski/mini.icons',
      -- 'nvim-lua/plenary.nvim'
    },
    config = function ()
      local alpha = require'alpha'
      local dashboard = require'alpha.themes.dashboard'
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
        dashboard.button('c', ' 新建文件', ':enew<CR>'),
        dashboard.button('SPC f f', '󰈞 查找文件', ':Telescope find_files<CR>'),
        dashboard.button('SPC f h', ' 历史文件', ':Telescope oldfiles<CR>'),
        dashboard.button('SPC s l', ' 加载会话', ':SessionSearch<CR>'),
        dashboard.button('SPC f c', ' 转到设置', ':Telescope find_files cwd=~/.config/nvim<CR>'),
        dashboard.button('SPC q', '󱊷 退出', ':qa<CR>'),
      }
      local handle = io.popen('fortune')
      --- Handle the case where fortune is not installed
      local fortune = ""
      if handle then
        fortune = handle:read("*a")
        handle:close()
      end
      dashboard.section.footer.val = "今日 " .. os.date("%Y-%m-%d %A") .. "  " .. fortune

      dashboard.config.opts.noautocmd = true

      -- vim.cmd[[autocmd User AlphaReady echo 'Alpha ready!']]

      alpha.setup(dashboard.config)
    end
  };
}
