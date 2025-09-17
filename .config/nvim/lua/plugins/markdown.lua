return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.icons",
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      render_modes = true, -- Render in all modes
      sign = { enabled = false }, -- Turn off in the status column
      checkbox = {
        enabled = true,
        checked = { scope_highlight = "@markup.strikethrough" },
      },
      -- code = {
      --   border = "none",
      -- },
      overrides = {
        buftype = {
          nofile = {
            code = {
              -- style = "normal",
              -- highlight = "NormalFloat",
              -- highlight_inline = "NormalFloat",
            },
          },
        },
        filetype = {},
      },
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
  },

  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    cmd = {
      "PeekOpen",
      "PeekClose",
    },
    config = function()
      require("peek").setup()

      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },

  {
    "sotte/presenting.nvim",
    cmd = { "Presenting" },
    opts = {
      options = {
        -- The width of the slide buffer.
        width = 80,
      },
    },
  },
}
