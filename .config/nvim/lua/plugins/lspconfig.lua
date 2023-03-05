return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "b0o/SchemaStore.nvim",
    version = false, -- last release is way too old
  },
  opts = {
    -- make sure mason installs the server
    servers = {
      tsserver = {},
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
      tailwindcss = {},
      intelephense = {
        init_options = {
          licenseKey = "00TJPX959XHH6KQ",
        },
      },
      phpactor = {
        init_options = {
          ["language_server_phpstan.enabled"] = false,
          ["language_server_psalm.enabled"] = false,
          ["language_server.diagnostics_on_save"] = false,
          ["language_server.diagnostics_on_open"] = false,
          ["language_server.diagnostics_on_update"] = false,
        },
      },
      volar = {},
      sqls = {},
    },
    setup = {
      tsserver = function(_, opts)
        require("lazyvim.util").on_attach(function(client, buffer)
          -- vim.notify(vim.inspect(client.server_capabilities))
          if client.name == "tsserver" then
          -- stylua: ignore
          vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { buffer = buffer, desc = "Organize Imports" })
            vim.keymap.set(
              "n",
              "<leader>cR",
              "<cmd>TypescriptRenameFile<CR>",
              { desc = "Rename File", buffer = buffer }
            )
          end
          -- Intelephense
          if client.name == "intelephense" then
            client.server_capabilities.documentFormattingProvider = false -- Formatting handled by null-ls
            client.server_capabilities.documentRangeFormattingProvider = false -- Formatting handled by null-ls
            client.server_capabilities.codeActionProvider = false -- Code actions handled by phpactor
            client.server_capabilities.renameProvider = false -- Renaming handled by phpactor
          end
          -- Phpactor
          if client.name == "phpactor" then
            client.server_capabilities.documentDiagnostigsProvider = false -- Diagnostics handled by intelephense
            client.server_capabilities.documentFormattingProvider = false -- Formatting handled by null-ls
            client.server_capabilities.documentRangeFormattingProvider = false -- Formatting handled by null-ls
          end
        end)
        require("typescript").setup({ server = opts })
        return true
      end,
    },
  },
}
