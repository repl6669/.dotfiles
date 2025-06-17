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

  {
    "j-hui/fidget.nvim",
    opts = {

      notification = {
        window = {
          normal_hl = "Comment", -- Base highlight group in the notification window
          winblend = 100, -- Background color opacity in the notification window
          x_padding = 1, -- Padding from right edge of window boundary
          y_padding = 0, -- Padding from bottom edge of window boundary
          align = "bottom", -- How to align the notification window
          relative = "editor", -- What the notification window position is relative to
        },
      },
    },

    integration = {
      ["nvim-tree"] = {
        enable = true,
      },
    },
  },

  {
    "3rd/image.nvim",
    filetypes = { "markdown" },
    dependencies = { "leafo/magick" },
    cond = function()
      return vim.fn.executable("magick") == 1 and vim.fn.executable("lua5.1") == 1
    end,
    opts = function()
      return {
        backend = "kitty",
        max_width_window_percentage = 200 / 3,
        integrations = {
          markdown = {
            clear_in_insert_mode = true,
            only_render_image_at_cursor = true,
          },
        },
        window_overlap_clear_enabled = true,
        editor_only_render_when_focused = true,
      }
    end,
  },
}
