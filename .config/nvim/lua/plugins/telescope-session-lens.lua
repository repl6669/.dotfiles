return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = {
    "rmagatti/auto-session",
  },
  keys = {
    {
      "<leader>fs",
      ":Telescope session-lens search_session<cr>",
      desc = "Browse Sessions",
    },
  },
  config = function()
    require("telescope").load_extension("session-lens")
  end,
}
