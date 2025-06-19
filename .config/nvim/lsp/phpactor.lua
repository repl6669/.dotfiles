return {
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/phpactor", "language-server" },
  filetypes = { "php" },
  root_dir = function(fname)
    return vim.fs.root(fname, {
      "composer.json",
      ".git",
      ".phpactor.json",
      ".phpactor.yml",
    })
  end,
  workspace_required = true,

  -- Custom initialization options
  init_options = {
    -- ["language_server_phpstan.enabled"] = false,
    -- ["language_server_psalm.enabled"] = false,
    -- ["language_server_worse_reflection.enabled"] = true,
    -- ["code_transform.import_missing_classes"] = true,
    -- ["code_transform.import_globals"] = false,
  },

  -- Server-specific settings
  settings = {
    phpactor = {
      -- Enable completion
      completion = {
        enabled = true,
      },
      -- Enable hover information
      hover = {
        enabled = true,
      },
      -- Enable goto definition
      references = {
        enabled = true,
      },
      -- Enable diagnostics
      diagnostics = {
        enabled = true,
      },
    },
  },

  -- Custom on_attach function for PHP-specific setup
  on_attach = function(client, bufnr)
    -- Enable completion
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    end

    -- Disable semantic tokens if causing issues
    -- client.server_capabilities.semanticTokensProvider = nil

    -- Custom PHP-specific keymaps (optional)
    local opts = { buffer = bufnr, silent = true }

    -- These keymaps complement the phpactor.nvim plugin commands
    -- You can uncomment if you want LSP-specific bindings
    -- vim.keymap.set('n', '<leader>lpi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', '<leader>lpr', vim.lsp.buf.references, opts)
    -- vim.keymap.set('n', '<leader>lps', vim.lsp.buf.document_symbol, opts)
  end,

  -- Capabilities - will be merged with global capabilities
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
          resolveSupport = {
            properties = {
              "documentation",
              "detail",
              "additionalTextEdits",
            },
          },
        },
      },
    },
  },

  -- Integration with native phpactor RPC commands
  -- This allows LSP and RPC commands to work together seamlessly
  commands = {
    PhpactorContextMenu = function()
      require("utils.phpactor").context_menu()
    end,
    PhpactorImportClass = function()
      require("utils.phpactor").import_class()
    end,
    PhpactorImportMissingClasses = function()
      require("utils.phpactor").import_missing_classes()
    end,
    PhpactorNewClass = function()
      require("utils.phpactor").new_class()
    end,
    PhpactorChangeVisibility = function()
      require("utils.phpactor").change_visibility()
    end,
    PhpactorExpandClass = function()
      require("utils.phpactor").expand_class()
    end,
    PhpactorTransform = function()
      require("utils.phpactor").transform()
    end,
    PhpactorCopyClass = function()
      require("utils.phpactor").copy_class()
    end,
    PhpactorCacheClear = function()
      require("utils.phpactor").cache_clear()
    end,
    PhpactorStatus = function()
      require("utils.phpactor").status()
    end,
    PhpactorReindex = function()
      require("utils.phpactor").reindex()
    end,
  },
}
