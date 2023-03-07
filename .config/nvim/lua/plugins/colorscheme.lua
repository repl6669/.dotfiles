return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      term_colors = true,
      transparent_background = false,
      integrations = {
        cmp = true,
        dashboard = true,
        gitsigns = true,
        harpoon = false,
        lsp_trouble = false,
        markdown = true,
        mason = true,
        neotest = true,
        noice = false,
        notify = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
        treesitter_context = false,
        which_key = false,
        dap = {
          enabled = false,
          enable_ui = false,
        },
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
      },
    },
  },
  {
    -- "rose-pine/neovim",
    "theimerj/rose-pine-neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    branch = "mini-indentscope",
    opts = {
      --- @usage 'auto'|'main'|'moon'|'dawn'
      variant = "auto",
      --- @usage 'main'|'moon'|'dawn'
      dark_variant = "main",
      disable_float_background = false,
      highlight_groups = {
        TabLineFill = { bg = "none" },
        MiniIndentscopeSymbol = { fg = "iris" },
        MiniIndentscopeSymbolOff = { fg = "iris" },
        IndentBlanklineChar = { fg = "overlay" },
        IndentBlanklineSpaceChar = { fg = "overlay" },
        IndentBlanklineSpaceCharBlankline = { fg = "overlay" },
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
