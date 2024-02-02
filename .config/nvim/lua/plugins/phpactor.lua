return {
  {
    "gbprod/phpactor.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required to update phpactor
      "neovim/nvim-lspconfig", -- required to automaticly register lsp server
    },
    ft = "php",
    build = function(plugin)
      plugin.handler.update()
    end,
    keys = {
      { "<leader>cpic", ":PhpActor import_class<CR>", mode = { "n" }, desc = "Import Class" },
      { "<leader>cpn", ":PhpActor class_new<CR>", desc = "New Class" },
      { "<leader>cpv", ":PhpActor change_visibility<CR>", mode = { "n" }, desc = "Change Visibility" },
      { "<leader>cpe", ":PhpActor expand_class<CR>", desc = "Expand Class" },
      { "<leader>cpt", ":PhpActor transform<CR>", mode = { "n" }, desc = "Transform Class" },
      { "<leader>cpc", ":PhpActor context_menu<CR>", mode = { "n" }, desc = "Copy Class Name" },
      { "<leader>cpx", ":PhpActor cache_clear<CR>", mode = { "n" }, desc = "Clear PhpActor Cache" },
      { "<leader>cpls", ":PhpActor lsp/status<CR>", mode = { "n" }, desc = "PhpActor LSP Status" },
      { "<leader>cplr", ":PhpActor lsp/reindex<CR>", mode = { "n" }, desc = "Reindex PhpActor LSP" },
      { "<leader>cpim", ":PhpActor import_missing_classes<CR>", mode = { "n" }, desc = "Import Missing Classes" },
    },
    config = {
      install = {
        -- path = vim.fn.stdpath("data") .. "/opt/",
        -- branch = "master",
        -- bin = vim.fn.stdpath("data") .. "/opt/phpactor/bin/phpactor",
        -- php_bin = "php",
        -- composer_bin = "composer",
        -- git_bin = "git",
        check_on_startup = "always",
      },
      lspconfig = {
        options = {
          language_server_diagnostics_on_update = false,
        },
      },
    },
  },
}

-- return {
--   {
--     "phpactor/phpactor",
--     ft = "php",
--     build = "composer install --no-dev -o",
--     keys = {
--       { "<leader>cpi", ":PhpactorImportClass<CR>", mode = { "n" }, desc = "Import Class" },
--       { "<leader>cpn", ":PhpactorClassNew<CR>", desc = "New Class" },
--       { "<leader>cpv", ":PhpactorChangeVisibility<CR>", mode = { "n" }, desc = "Change Visibility" },
--       { "<leader>cpe", ":PhpactorClassExpand<CR>", desc = "Expand Class" },
--       { "<leader>cpt", ":PhpactorTransform<CR>", mode = { "n" }, desc = "Transform Class" },
--       { "<leader>cpc", ":PhpactorCopyClassName<CR>", mode = { "n" }, desc = "Copy Class Name" },
--       { "<leader>cpm", ":PhpactorMoveFile<CR>", mode = { "n" }, desc = "Move File" },
--       { "<leader>cpe", ":PhpactorExtractMethod<CR>", mode = { "v" }, desc = "Extract Method" },
--       { "<leader>cpe", ":PhpactorExtractExpression<CR>", mode = { "v" }, desc = "Extract Expression" },
--       { "<leader>cpi", ":PhpactorImportMissingClasses<CR>", mode = { "v" }, desc = "Import Missing Classes" },
--     },
--     config = function()
--       --
--     end,
--   },
-- }
