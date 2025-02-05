local float = { style = "minimal", border = "rounded" }

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float)

return {
  "neovim/nvim-lspconfig",
  dependencies = {
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
    -- make sure mason installs the server
    servers = {
      docker_compose_language_service = {},
      dockerls = {},
      lua_ls = {},
      -- intelephense = {
      --   ---@type lspconfig.options.intelephense
      --   init_options = {
      --     licenseKey = "00TJPX959XHH6KQ",
      --     files = {
      --       maxSize = 10000000,
      --     },
      --   },
      -- },
      phpactor = {},
      emmet_language_server = {
        filetypes = {
          "css",
          "html",
          "xhtml",
          "xml",
          "javascript",
          "javascript.jsx",
          "javascriptreact",
          "json",
          "typescript",
          "typescript.tsx",
          "typescriptreact",
          "vue",
        },
        init_options = {
          showSuggestionsAsSnippets = true,
        },
      },
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
      sqlls = {},
    },
  },
}
