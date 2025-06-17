return {
  "neovim/nvim-lspconfig",
  dependencies = {
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
  },
  opts = {
    diagnostics = {
      virtual_text = true,
      -- virtual_text = false,
      -- virtual_lines = {
      --   current_line = true,
      -- },
    },
    -- make sure mason installs the server
    servers = {
      docker_compose_language_service = {},
      dockerls = {},
      vtsls = {
        on_attach = function(client)
          -- disable formatting, since we use prettier
          client.server_capabilities.documentFormattingProvider = false
        end,
        ---@diagnostic disable-next-line: missing-fields
        settings = {},
      },
      tailwindcss = {
        -- exclude a filetype from the default_config
        filetypes_exclude = { "php", "md", "markdown" },
        -- add additional filetypes to the default_config
        filetypes_include = {},
        -- to fully override the default_config, change the below
        -- filetypes = {}
      },
      vectorcode_server = {},
      volar = {
        filetypes = {
          "javascript",
          "javascript.jsx",
          "javascriptreact",
          "json",
          "typescript",
          "typescript.tsx",
          "typescriptreact",
          "vue",
        },
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
        on_attach = function(client)
          -- disable formatting, since we use prettier
          client.server_capabilities.documentFormattingProvider = false
        end,
      },
    },
  },
}
