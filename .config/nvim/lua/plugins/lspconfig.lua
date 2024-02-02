return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  opts = {
    -- make sure mason installs the server
    servers = {
      docker_compose_language_service = {},
      dockerls = {},
      lua_ls = {
        -- mason = false, -- set to false if you don't want this server to be installed with mason
        -- Use this to add any additional keymaps
        -- for specific lsp servers
        ---@type LazyKeysSpec[]
        -- keys = {},
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },
          },
        },
      },
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
      tsserver = {
        on_attach = function(client)
          -- disable formatting, since we use prettier
          client.resolved_capabilities.document_formatting = false
        end,
      },
      volar = {
        on_attach = function(client)
          -- disable formatting, since we use prettier
          client.resolved_capabilities.document_formatting = false
        end,
      },
      sqlls = {},
    },
  },
}
