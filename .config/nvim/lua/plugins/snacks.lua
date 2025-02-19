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
          section = "terminal",
          cmd = "",
          height = 2,
        },
        {
          section = "header",
          indent = 40,
        },
        {
          section = "keys",
          gap = 1,
          padding = 2,
        },
        {
          section = "terminal",
          cmd = "",
          pane = 2,
          indent = 40,
          height = 13,
        },
        {
          section = "terminal",
          cmd = "",
          pane = 2,
          height = 2,
        },
        {
          pane = 2,
          icon = " ",
          desc = "Browse Repo",
          padding = 1,
          key = "b",
          action = function()
            Snacks.gitbrowse()
          end,
        },
        function()
          local in_git = Snacks.git.get_root() ~= nil
          local cmds = {
            {
              title = "Notifications",
              cmd = "echo '' && gh notify -n5 -s",
              action = function()
                vim.ui.open("https://github.com/notifications")
              end,
              key = "n",
              icon = " ",
              height = 6,
              enabled = true,
            },
            {
              title = "Open Issues",
              cmd = 'gh issue list -L 5 --json number,title,updatedAt --template \'\n{{range .}}{{tablerow (printf "#%v" .number | autocolor "green") .title (timeago .updatedAt)}}{{end}}\'',
              key = "i",
              action = function()
                vim.fn.jobstart("gh issue list --web", { detach = true })
              end,
              icon = " ",
              height = 6,
            },
            {
              icon = " ",
              title = "Open PRs",
              cmd = 'gh pr list -L 5 --json number,title,updatedAt --template \'\n{{range .}}{{tablerow (printf "#%v" .number | autocolor "green") .title (timeago .updatedAt)}}{{end}}\'',
              key = "P",
              action = function()
                vim.fn.jobstart("gh pr list --web", { detach = true })
              end,
              height = 6,
            },
            {
              icon = " ",
              title = "Git Status",
              cmd = "git --no-pager diff --stat -B -M -C",
              height = 8,
            },
          }
          return vim.tbl_map(function(cmd)
            return vim.tbl_extend("force", {
              pane = 2,
              section = "terminal",
              enabled = in_git,
              padding = 1,
              ttl = 5 * 60,
              indent = 0,
            }, cmd)
          end, cmds)
        end,
        {
          section = "terminal",
          -- cmd = "pokemon-colorscripts -n haunter --no-title; sleep .1",
          cmd = "pokemon-colorscripts -r --no-title; sleep .1",
          random = 10,
          height = 19,
        },
        { section = "startup" },
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
▓█████▄▓██   ██▓  ██████ ▄▄▄█████▓ ▒█████   ██▓███   ██▓ ▄▄▄
▒██▀ ██▌▒██  ██▒▒██    ▒ ▓  ██▒ ▓▒▒██▒  ██▒▓██░  ██▒▓██▒▒████▄
░██   █▌ ▒██ ██░░ ▓██▄   ▒ ▓██░ ▒░▒██░  ██▒▓██░ ██▓▒▒██▒▒██  ▀█▄
░▓█▄   ▌ ░ ▐██▓░  ▒   ██▒░ ▓██▓ ░ ▒██   ██░▒██▄█▓▒ ▒░██░░██▄▄▄▄██
░▒████▓  ░ ██▒▓░▒██████▒▒  ▒██▒ ░ ░ ████▓▒░▒██▒ ░  ░░██░ ▓█   ▓██▒
 ▒▒▓  ▒   ██▒▒▒ ▒ ▒▓▒ ▒ ░  ▒ ░░   ░ ▒░▒░▒░ ▒▓▒░ ░  ░░▓   ▒▒   ▓▒█░
 ░ ▒  ▒ ▓██ ░▒░ ░ ░▒  ░ ░    ░      ░ ▒ ▒░ ░▒ ░      ▒ ░  ▒   ▒▒ ░
 ░ ░  ░ ▒ ▒ ░░  ░  ░  ░    ░      ░ ░ ░ ▒  ░░        ▒ ░  ░   ▒
   ░    ░ ░           ░               ░ ░            ░        ░  ░
 ░      ░ ░
 ]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
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
