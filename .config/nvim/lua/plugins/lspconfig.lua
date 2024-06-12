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
        on_attach = function(client)
          -- disable formatting, since we use prettier
          client.server_capabilities.documentFormattingProvider = false
        end,
      },
      sqlls = {},
    },
  },
}
