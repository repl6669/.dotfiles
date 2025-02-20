return {
  "snacks.nvim",
  opts = {
    notifier = {
      enabled = true,
      style = "compact",
      timeout = 5000,
    },
    dashboard = {
      enabled = true,
      width = 60,
      sections = {
        {
          section = "header",
        },
        {
          section = "keys",
          gap = 1,
          padding = 2,
        },
        function()
          local in_git = Snacks.git.get_root() ~= nil
          local cmds = {
            {
              -- icon = " ",
              -- title = "Git Status",
              cmd = "git --no-pager diff --stat -B -M -C",
              height = 8,
            },
          }
          return vim.tbl_map(function(cmd)
            return vim.tbl_extend("force", {
              section = "terminal",
              enabled = in_git,
              padding = 1,
              ttl = 5 * 60,
              indent = 0,
            }, cmd)
          end, cmds)
        end,
        -- {
        --   section = "terminal",
        --   -- cmd = "pokemon-colorscripts -n haunter --no-title; sleep .1",
        --   cmd = "pokemon-colorscripts -r --no-title; sleep .1",
        --   random = 10,
        --   height = 19,
        -- },
        -- { section = "startup" },
        -- {
        --   section = "terminal",
        --   cmd = "chafa ~/Downloads/pics/d.png --format symbols --symbols vhalf --size 50x34 --fit-width; sleep .1",
        --   pane = 2,
        --   indent = 4,
        --   height = 30,
        -- },
      },
      preset = {
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,
        header = [[
⠉⠁⠀⠀⠀⠀⣒⡂⠀⠈⠛⢧⣼⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⠀⡀⠀⠀⠈⢱⠉⠁⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⠛⣿⣿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⠀⠀⠨⠳⡶⣘⢦⣶⣦⠀⠀⠀⠀⠀⠈⠋⠛⠋⠀⢈⣛⣄⡛⠛⠻⠿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⣿
⠓⠀⢀⣤⣾⡇⠸⡿⠟⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠙⠻⣿⣷⡄⠀⠀⠀⠀⢹⣿⣿⣿⣿⢹⣴⣿⣧⣬⣿
⣠⣶⣿⣿⣿⡇⠀⠀⠀⠀⠀⠤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠀⠀⠀⠀⢸⣿⣿⣿⡟⠘⣿⣿⣿⣿⣿
⠀⢸⣿⣿⣿⣷⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠶⠶⠾⣿⣿⣿⣿⠀⠀⠀⠀⢸⣿⣿⣿⠃⣄⣿⣿⣿⣿⣿
⠀⢸⣿⣿⣿⣿⠀⠀⠈⠒⠊⠉⠛⠀⠀⠀⠀⠀⠀⠀⠀⣤⢀⣽⡟⠀⠀⠀⠀⣼⡏⣿⡇⢀⡿⢻⠿⠿⠿⢿
⠀⠀⣿⣿⣿⠃⠀⠀⠀⠀⠤⠀⠨⠀⠀⠀⠀⠀⠀⠀⠀⠙⢺⡿⠀⠀⠀⠀⠀⣽⣿⣷⣶⣬⣷⣿⣶⣶⣶⣶
⠀⠀⢻⡿⠁⠀⠀⠀⠀⠀⢀⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠨⠟⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⠀⣰⡟⠁⠀⠀⠀⢠⡀⠊⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣼⡟⣀⣤⣴⣿⣷⣠⡤⠌⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿
⠟⠘⠛⣻⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿
⢲⣀⣴⣛⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿
⠘⣿⣿⣿⣿⣿⣿⠏⠀⢀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣘⢿⣿⣿⣿⣿⣿⣿
⠀⠙⢌⡉⢽⣿⣿⡀⢤⣻⠃⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣶⣿⣞⢿⣿⣿⣿⣿⣿
⣷⣬⢀⠈⣂⠉⣿⣀⣨⣿⠀⠘⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⣿⣿⣿⣿⡌⢿⡼⠿⠛⠻
⠀⠀⠀⠀⠀⠀⠀⠁⠈⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠊⡸⢻⠷⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠀⠀⠀⠀⣾⣾⣾⣶⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⢁⣬⡅⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣿⣿⡄⢀⣀⣀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠉⠁⡐⠀⠟⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠋⠙⣏⠀⠈⢱⡄⠀⠀⠀
 ]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "b", desc = "Browse Repo", action = function() Snacks.gitbrowse() end, },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          -- { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          -- { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
  },
}
