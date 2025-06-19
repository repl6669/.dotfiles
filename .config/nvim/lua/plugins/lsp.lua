return {
  -- LSP-related plugins that still provide value alongside native LSP
  {
    "j-hui/fidget.nvim",
    opts = {
      progress = {
        display = {
          progress_icon = { pattern = "dots", period = 1 },
        },
      },
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
  },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim",
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
  -- Disable LazyVim's automatic LSP server setup for servers we configure manually
  {
    "LazyVim/LazyVim",
    opts = {
      lsp = {
        servers = {
          -- Disable phpactor since we configure it manually in init.lua
          phpactor = false,
        },
      },
    },
  },
}
