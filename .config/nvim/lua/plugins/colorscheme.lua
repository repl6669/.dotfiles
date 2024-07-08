return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {
      --- @usage 'auto'|'main'|'moon'|'dawn'
      variant = "auto",
      --- @usage 'main'|'moon'|'dawn'
      dark_variant = "main",

      extend_background_behind_borders = true,

      enable = {
        legacy_highlights = false,
        migrations = false,
        terminal = true,
      },

      styles = {
        bold = true,
        italic = true,
        transparency = false,
      },

      highlight_groups = {
        DashboardHeader = { fg = "love" },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
