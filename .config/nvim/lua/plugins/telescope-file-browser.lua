return {
  "nvim-telescope/telescope-file-browser.nvim",
  keys = {
    {
      "<leader>bf",
      ":Telescope file_browser path=%:p:h=%:p:h<cr>",
      desc = "Browse Files",
    },
  },
  config = function()
    require("telescope").load_extension("file_browser")
  end,
}
