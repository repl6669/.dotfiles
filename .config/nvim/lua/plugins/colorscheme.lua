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

      styles = {
        bold = true,
        italic = true,
        transparency = false,
      },

      highlight_groups = {

        -- Dashboard
        SnacksDashboardHeader = { fg = "green100" },
      },
    },
  },
}
