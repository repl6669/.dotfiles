return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.icons",
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    checkbox = {
      enabled = true,
      checked = { scope_highlight = "@markup.strikethrough" },
    },
    code = {
      border = "none",
    },
    overrides = {
      buftype = {
        nofile = {
          code = {
            style = "normal",
            highlight = "NormalFloat",
            highlight_inline = "NormalFloat",
          },
        },
      },
      filetype = {},
    },
    file_types = {
      "markdown",
      "Avante",
    },
  },
  ft = {
    "Avante",
    "markdown",
  },
}
