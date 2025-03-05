return {
  {
    "echasnovski/mini.surround",
    optional = true,
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
    keys = {
      { "gz", "", desc = "+surround" },
    },
  },

  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    opts = function(_, opts)
      local colors = require("utils.colors")

      opts.highlighters = vim.tbl_deep_extend("force", opts.highlighters or {}, {
        hex_color_short = {
          pattern = "#%x%x%x%f[%X]",
          group = colors.hex_color_short,
        },

        rgb_color = {
          pattern = "rgb%(%d+, ?%d+, ?%d+%)",
          group = colors.rgb_color,
        },

        rgba_color = {
          pattern = "rgba%(%d+, ?%d+, ?%d+, ?%d*%.?%d*%)",
          group = colors.rgba_color,
        },

        hsl_color = {
          pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
          group = colors.hsl_color,
        },
      })
    end,
  },

  {
    "echasnovski/mini.splitjoin",
    opts = {
      mappings = {
        toggle = "gS",
        split = "",
        join = "",
      },
    },
  },
}
