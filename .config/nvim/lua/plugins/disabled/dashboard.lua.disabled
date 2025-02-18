return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  opts = function()
    local logo = [[
████████▄  ▄██   ▄      ▄████████     ███      ▄██████▄     ▄███████▄  ▄█     ▄████████
███   ▀███ ███   ██▄   ███    ███ ▀█████████▄ ███    ███   ███    ███ ███    ███    ███
███    ███ ███▄▄▄███   ███    █▀     ▀███▀▀██ ███    ███   ███    ███ ███▌   ███    ███
███    ███ ▀▀▀▀▀▀███   ███            ███   ▀ ███    ███   ███    ███ ███▌   ███    ███
███    ███ ▄██   ███ ▀███████████     ███     ███    ███ ▀█████████▀  ███▌ ▀███████████
███    ███ ███   ███          ███     ███     ███    ███   ███        ███    ███    ███
███   ▄███ ███   ███    ▄█    ███     ███     ███    ███   ███        ███    ███    ███
████████▀   ▀█████▀   ▄████████▀     ▄████▀    ▀██████▀   ▄████▀      █▀     ███    █▀
    ]]

    logo = string.rep("\n", 8) .. logo .. "\n\n"

    local opts = {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          { action = "Telescope find_files",                                     desc = " Find file",       icon = " ", key = "f" },
          { action = "ene | startinsert",                                        desc = " New file",        icon = " ", key = "n" },
          { action = "Telescope oldfiles",                                       desc = " Recent files",    icon = " ", key = "r" },
          { action = "Telescope live_grep",                                      desc = " Find text",       icon = " ", key = "g" },
          { action = [[lua require("lazyvim.util").telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
          { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s" },
          { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
          { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    return opts
  end,
}

-- return {
--   "nvimdev/dashboard-nvim",
--   event = "VimEnter",
--   opts = function(_, opts)
--     local logo = [[
--      __                   __
--     /\ \                 /\ \__                 __
--     \_\ \  __  __    ____\ \ ,_\   ___   _____ /\_\     __
--     /'_` \/\ \/\ \  /',__\\ \ \/  / __`\/\ '__`\/\ \  /'__`\
--     /\ \L\ \ \ \_\ \/\__, `\\ \ \_/\ \L\ \ \ \L\ \ \ \/\ \L\.\_
--     \ \___,_\/`____ \/\____/ \ \__\ \____/\ \ ,__/\ \_\ \__/.\_\
--     \/__,_ /`/___/> \/___/   \/__/\/___/  \ \ \/  \/_/\/__/\/_/
--                 /\___/                      \ \_\
--                 \/__/                        \/_/
--     ]]
--
--     table.insert(opts.config.header, vim.split(logo, "\n"))
--   end,
-- }
