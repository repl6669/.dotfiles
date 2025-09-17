return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      blade = { "blade-formatter" },
      css = { "prettierd" },
      html = { "prettierd" },
      javascript = { "prettierd" },
      kdl = { "kdlfmt" },
      json = { "prettierd" },
      jsonc = { "prettierd" },
      json5 = { "prettierd" },
      lua = { "stylua" },
      markdown = { "prettierd" },
      php = { "pint" },
      typescript = { "prettierd" },
      vue = { "prettierd" },
      yaml = { "prettierd" },
    },
    formatters = {
      pint = {
        meta = {
          url = "https://github.com/laravel/pint",
          description = "Laravel Pint is an opinionated PHP code style fixer for minimalists.",
        },
        command = "pint",
        args = { "$FILENAME", "--repair" },
        stdin = false,
        exit_codes = { 0, 1 },
      },
    },
  },
}
