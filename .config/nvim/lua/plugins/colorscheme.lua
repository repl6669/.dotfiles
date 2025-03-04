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
        transparency = true,
      },

      highlight_groups = {

        -- Dashboard
        SnacksDashboardHeader = { fg = "orange" },
      },
    },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    enabled = false,
    priority = 1000,

    opts = function(_, opts)
      local colors = require("catppuccin.palettes").get_palette("mocha")

      return vim.tbl_deep_extend("force", opts, {
        flavour = "auto", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },

        transparent_background = true, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false, -- dims the background color of inactive window
          shade = "dark",
          percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },

        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = true, -- Force no underline

        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { "italic" }, -- Change the style of comments
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
          -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },

        custom_highlights = {
          SnacksDashboardHeader = { fg = colors.peach },
          SnacksDashboardIcon = { fg = colors.peach },
          SnacksDashboardDesc = { fg = colors.rosewater },
          SnacksDashboardTitle = { fg = colors.peach },
          SnacksDashboardSpecial = { fg = colors.rosewater },
          DashboardHeader = { fg = colors.peach },
        },

        default_integrations = true,
        integrations = {
          blink_cmp = true,
          cmp = true,
          fzf = true,
          gitsigns = true,
          lsp_trouble = true,
          mini = { enabled = true, indentscope_color = colors.sky },
          neotest = true,
          neotree = true,
          notify = true,
          nvimtree = true,
          snacks = true,
          telescope = true,
          treesitter = true,
          which_key = true,
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },

        color_overrides = {
          -- latte = {
          --   rosewater = "#c14a4a",
          --   flamingo = "#c14a4a",
          --   red = "#c14a4a",
          --   maroon = "#c14a4a",
          --   pink = "#945e80",
          --   mauve = "#945e80",
          --   peach = "#c35e0a",
          --   yellow = "#b47109",
          --   green = "#6c782e",
          --   teal = "#4c7a5d",
          --   sky = "#4c7a5d",
          --   sapphire = "#4c7a5d",
          --   blue = "#45707a",
          --   lavender = "#45707a",
          --   text = "#654735",
          --   subtext1 = "#73503c",
          --   subtext0 = "#805942",
          --   overlay2 = "#8c6249",
          --   overlay1 = "#8c856d",
          --   overlay0 = "#a69d81",
          --   surface2 = "#bfb695",
          --   surface1 = "#d1c7a3",
          --   surface0 = "#e3dec3",
          --   base = "#f9f5d7",
          --   mantle = "#f0ebce",
          --   crust = "#e8e3c8",
          -- },
          -- mocha = {
          --   rosewater = "#ea6962",
          --   flamingo = "#ea6962",
          --   red = "#ea6962",
          --   maroon = "#ea6962",
          --   pink = "#d3869b",
          --   mauve = "#d3869b",
          --   peach = "#e78a4e",
          --   yellow = "#d8a657",
          --   green = "#a9b665",
          --   teal = "#89b482",
          --   sky = "#89b482",
          --   sapphire = "#89b482",
          --   blue = "#7daea3",
          --   lavender = "#7daea3",
          --   text = "#ebdbb2",
          --   subtext1 = "#d5c4a1",
          --   subtext0 = "#bdae93",
          --   overlay2 = "#a89984",
          --   overlay1 = "#928374",
          --   overlay0 = "#595959",
          --   surface2 = "#4d4d4d",
          --   surface1 = "#404040",
          --   surface0 = "#292929",
          --   base = "#1d2021",
          --   mantle = "#191b1c",
          --   crust = "#141617",
          -- },
        },
      })
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {
      --- @usage 'auto'|'main'|'moon'|'dawn'
      variant = "auto",
      --- @usage 'main'|'moon'|'dawn'
      dark_variant = "moon",

      extend_background_behind_borders = true,

      enable = {
        legacy_highlights = true,
        migrations = true,
        terminal = true,
      },

      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },

      palette = {
        -- Override the builtin palette per variant
        moon = {
          base = "#191724",
          surface = "#1f1d2e",
          overlay = "#26233a",
          muted = "#6e6a86",
          subtle = "#908caa",
          text = "#e0def4",
          -- leaf = "#95b1ac",
          -- pine = "#31748f",
          highlight_low = "#21202e",
          highlight_med = "#403d52",
          highlight_high = "#524f67",
        },
      },

      highlight_groups = {

        -- Treesitter
        -- ["@type"] = { fg = "rose" },
        -- ["@module"] = { fg = "subtle" },

        -- Dashboard
        SnacksDashboardHeader = { fg = "iris" },
        SnacksDashboardIcon = { fg = "gold" },
        SnacksDashboardDesc = { fg = "iris" },
        SnacksDashboardTitle = { fg = "iris" },
        SnacksDashboardSpecial = { fg = "iris" },

        -- DashboardHeader = { fg = "love" },
      },
    },
  },
}
