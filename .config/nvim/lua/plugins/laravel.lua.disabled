return {
  "adalessa/laravel.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "tpope/vim-dotenv",
    "MunifTanjim/nui.nvim",
  },
  ft = { "php", "blade" },
  cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
  keys = {
    { "<leader>la", ":Laravel artisan<cr>", desc = "Laravel artisan" },
    { "<leader>lr", ":Laravel routes<cr>", desc = "Laravel routes" },
    { "<leader>lm", ":Laravel related<cr>", desc = "Laravel related" },
    {
      "<leader>lt",
      function()
        require("laravel.tinker").send_to_tinker()
      end,
      mode = "v",
      desc = "Send to tinker",
    },
  },
  opts = {
    lsp_server = "phpactor",
    features = {
      null_ls = {
        enable = false,
      },
      route_info = {
        enable = false,
        position = "right",
      },
    },
  },
  event = { "VeryLazy" },
  config = true,
}
