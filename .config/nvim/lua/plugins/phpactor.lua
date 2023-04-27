return {
  {
    "phpactor/phpactor",
    ft = "php",
    build = "composer install --no-dev -o",
    keys = {
      { "<leader>cpi", ":PhpactorImportClass<CR>", mode = { "n" }, desc = "Import Class" },
      { "<leader>cpn", ":PhpactorClassNew<CR>", desc = "New Class" },
      { "<leader>cpv", ":PhpactorChangeVisibility<CR>", mode = { "n" }, desc = "Change Visibility" },
      { "<leader>cpe", ":PhpactorClassExpand<CR>", desc = "Expand Class" },
      { "<leader>cpt", ":PhpactorTransform<CR>", mode = { "n" }, desc = "Transform Class" },
      { "<leader>cpc", ":PhpactorCopyClassName<CR>", mode = { "n" }, desc = "Copy Class Name" },
      { "<leader>cpm", ":PhpactorMoveFile<CR>", mode = { "n" }, desc = "Move File" },
      { "<leader>cpe", ":PhpactorExtractMethod<CR>", mode = { "v" }, desc = "Extract Method" },
      { "<leader>cpe", ":PhpactorExtractExpression<CR>", mode = { "v" }, desc = "Extract Expression" },
      { "<leader>cpi", ":PhpactorImportMissingClasses<CR>", mode = { "v" }, desc = "Import Missing Classes" },
    },
    config = function()
      --
    end,
  },
}
