return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
    "nvim-treesitter/nvim-treesitter-context",
  },
  opts = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, {
        "php",
        "phpdoc",
        "typescript",
        "tsx",
        "json",
        "json5",
        "jsonc",
        "python",
        "rust",
        "vue",
        "sql",
      })
      vim.list_extend(opts, {
        context_commentstring = {
          enable = true,
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "markdown" },
        },
      })
    end
  end,
}
