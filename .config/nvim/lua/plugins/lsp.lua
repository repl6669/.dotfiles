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

  -- Keep mason-lspconfig from auto-enabling servers we don't want running.
  -- (LazyVim reads `servers` from the nvim-lspconfig spec, not LazyVim/LazyVim.)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- phpactor stays installed in Mason only for the RPC refactor commands
        -- in lua/utils/phpactor.lua; phpantom_lsp is the PHP language server.
        phpactor = false,
      },
    },
  },
}
