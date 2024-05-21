return {
  "wallpants/github-preview.nvim",
  cmd = { "GithubPreviewToggle" },
  keys = { { "<leader>gpt", "<cmd>GithubPreviewToggle<cr>", desc = "Toggle Github Preview" } },
  opts = {
    -- port used by local server
    port = 6041,

    cursor_line = {
      disable = false,

      color = "#c86414",
      opacity = 0.1,
    },
  },
  config = function(_, opts)
    local gpreview = require("github-preview")
    gpreview.setup(opts)

    local fns = gpreview.fns

    vim.keymap.set("n", "<leader>gpt", fns.toggle, { desc = "Toggle Github Preview" })
    vim.keymap.set("n", "<leader>gps", fns.single_file_toggle, { desc = "Github Preview Toggle Single File" })
    vim.keymap.set("n", "<leader>gpd", fns.details_tags_toggle, { desc = "Github Preview Toggle Tags" })
  end,
}
