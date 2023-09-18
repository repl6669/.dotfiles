return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
    "nvim-treesitter/nvim-treesitter-context",
    "windwp/nvim-ts-autotag",
  },
  opts = {
    ensure_installed = {
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
      "yaml",
    },
    context_commentstring = {
      enable = true,
    },
    autotag = {
      enable = true,
      enable_rename = true,
      enable_close = true,
      enable_close_on_slash = true,
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "markdown" },
    },
  },
}
