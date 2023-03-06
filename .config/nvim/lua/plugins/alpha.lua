return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    local logo = [[
     __                   __
    /\ \                 /\ \__                 __
    \_\ \  __  __    ____\ \ ,_\   ___   _____ /\_\     __
    /'_` \/\ \/\ \  /',__\\ \ \/  / __`\/\ '__`\/\ \  /'__`\
    /\ \L\ \ \ \_\ \/\__, `\\ \ \_/\ \L\ \ \ \L\ \ \ \/\ \L\.\_
    \ \___,_\/`____ \/\____/ \ \__\ \____/\ \ ,__/\ \_\ \__/.\_\
    \/__,_ /`/___/> \/___/   \/__/\/___/  \ \ \/  \/_/\/__/\/_/
                /\___/                      \ \_\
                \/__/                        \/_/
    ]]

    dashboard.section.header.val = vim.split(logo, "\n")
    -- dashboard.section.buttons.val = {
    --   dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
    --   dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
    --   dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
    --   dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
    --   dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
    --   dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
    --   dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
    --   dashboard.button("q", " " .. " Quit", ":qa<CR>"),
    -- }
    return dashboard
  end,
}
