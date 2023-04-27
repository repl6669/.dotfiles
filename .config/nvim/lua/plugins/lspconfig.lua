return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "b0o/SchemaStore.nvim",
    version = false, -- last release is way too old
  },
  opts = {
    -- make sure mason installs the server
    servers = {
      docker_compose_language_service = {},
      dockerls = {},
      ---@type lspconfig.options.tsserver
      tsserver = {
        settings = {
          typescript = {
            format = {
              indentSize = vim.o.shiftwidth,
              convertTabsToSpaces = vim.o.expandtab,
              tabSize = vim.o.tabstop,
            },
          },
          javascript = {
            format = {
              indentSize = vim.o.shiftwidth,
              convertTabsToSpaces = vim.o.expandtab,
              tabSize = vim.o.tabstop,
            },
          },
          completions = {
            completeFunctionCalls = true,
          },
        },
      },
      ---@type lspconfig.options.lua_ls
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },
          },
        },
      },
      ---@type lspconfig.options.jsonls
      jsonls = {
        -- lazy-load schemastore when needed
        on_new_config = function(new_config)
          new_config.settings.json.schemas = new_config.settings.json.schemas or {}
          vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
        end,
        settings = {
          json = {
            format = {
              enable = true,
            },
            validate = { enable = true },
          },
        },
      },
      -- tailwindcss = {},
      intelephense = {
        ---@type lspconfig.options.intelephense
        init_options = {
          licenseKey = "00TJPX959XHH6KQ",
          files = {
            maxSize = 1000000,
          },
        },
      },
      phpactor = {
        init_options = {
          ["language_server_phpstan.enabled"] = false,
          ["language_server_psalm.enabled"] = false,
          ["language_server.diagnostics_on_update"] = false,
          ["language_server.diagnostics_on_save"] = false,
          ["language_server.diagnostics_on_open"] = false,
        },
      },
      ---@type lspconfig.options.volar
      volar = {},
      sqlls = {},
    },
    setup = {
      tsserver = function(_, opts)
        require("lazyvim.util").on_attach(function(client, buffer)
          -- vim.notify(vim.inspect(client.server_capabilities))
          if client.name == "tsserver" then
            -- stylua: ignore
            vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { buffer = buffer, desc = "Organize Imports" })
            -- stylua: ignore
            vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = buffer })
          end
        end)
        require("typescript").setup({ server = opts })
        return true
      end,
      intelephense = function(_, opts)
        require("lazyvim.util").on_attach(function(client, buffer)
          -- Intelephense
          if client.name == "intelephense" then
            client.server_capabilities.documentFormattingProvider = false -- Formatting handled by null-ls
            client.server_capabilities.documentRangeFormattingProvider = false -- Formatting handled by null-ls

            client.server_capabilities.codeActionProvider = false -- Handled by phpactor
            client.server_capabilities.completionProvider = false -- Handled by phpactor
            client.server_capabilities.definitionProvider = false -- Handled by phpactor
            client.server_capabilities.renameProvider = false -- Handled by phpactor
            client.server_capabilities.hoverProvider = false -- Handled by phpactor
            client.server_capabilities.workspaceSymbolProvider = false -- Handled by phpactor
            client.server_capabilities.documentSymbolProvider = false -- Handled by phpactor

            -- vim.notify(vim.inspect(client.name))
            -- vim.notify(vim.inspect(client.server_capabilities))
          end
        end)
      end,
      phpactor = function(_, opts)
        require("lazyvim.util").on_attach(function(client, buffer)
          -- Phpactor
          if client.name == "phpactor" then
            client.server_capabilities.documentDiagnosticsProvider = false -- Diagnostics handled by intelephense

            client.server_capabilities.documentFormattingProvider = false -- Formatting handled by null-ls
            client.server_capabilities.documentRangeFormattingProvider = false -- Formatting handled by null-ls

            -- vim.notify(vim.inspect(client.name))
            -- vim.notify(vim.inspect(client.server_capabilities))
          end
        end)
      end,
    },
  },
}
