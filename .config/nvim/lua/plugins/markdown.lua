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

  keys = {
    {
      "<leader>mt",
      function()
        require("utils.markdown").update_markdown_toc("## Table of Contents")
      end,
      mode = { "n" },
      desc = "Upsert Markdown TOC",
    },
  },
}
