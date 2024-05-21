return {
  "gnikdroy/mdpreview.nvim",
  ft = "markdown",
  build = function()
    require("mdpreview").install_mlp()
  end,
  config = function()
    local mdpreview = require("mdpreview").setup({
      open_browser = true,
      port = 8567,
      localhost_only = true,
      follow = true,
    })

    -- Add commands :MarkdownPreview and :MarkdownPreviewClose
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*.md",
      callback = function(details)
        vim.api.nvim_buf_create_user_command(details.buf, "MarkdownPreview", function()
          mdpreview.preview_open(details.buf)
        end, {})
        vim.api.nvim_buf_create_user_command(details.buf, "MarkdownPreviewClose", function()
          mdpreview.preview_close(details.buf)
        end, {})
      end,
      desc = "mdpreview: Create preview commands",
    })

    -- Automatically close preview when buffer is deleted
    vim.api.nvim_create_autocmd("BufDelete", {
      pattern = "*.md",
      callback = function(details)
        mdpreview.preview_close(details.buf)
      end,
      desc = "mdpreview: Automatically close previews on buffer close",
    })
  end,
  keys = {
    {
      "<leader>mp",
      ft = "markdown",
      "<cmd>MarkdownPreview<cr>",
      desc = "Markdown Preview",
    },
  },
}
