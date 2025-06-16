return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "repl69",
    },
  },

  {
    "repl6669/repl69",
    dir = "~/Developer/lua/neovim/repl69",
    name = "repl69",
    lazy = false,
    priority = 1000,
    opts = {
      style = "void",
      transparent = true,
      styles = {
        floats = "transparent",
        sidebars = "transparent",
      },
      on_highlights = function(highlights, colors)
        -- Dashboard
        local header_colors = {
          colors.green100,
          colors.orange100,
          colors.purple100,
          colors.blue100,
          colors.red100,
          colors.yellow100,
        }
        -- Seed the random number generator with the current time for randomness on each nvim start
        math.randomseed(os.time())
        local random_color = header_colors[math.random(#header_colors)]
        highlights.SnacksDashboardHeader = { fg = random_color }
      end,
    },
  },
}
