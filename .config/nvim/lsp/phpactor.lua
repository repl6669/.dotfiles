return {
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/phpactor", "language-server" },
  filetypes = { "php" },
  root_markers = {
    ".git",
    "composer.json",
    ".phpactor.json",
    ".phpactor.yml",
  },
  workspace_required = true,

  -- Essential settings for phpactor
  settings = {
    phpactor = {
      completion = { enabled = true },
      hover = { enabled = true },
      references = { enabled = true },
      diagnostics = { enabled = true },
    },
  },

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
