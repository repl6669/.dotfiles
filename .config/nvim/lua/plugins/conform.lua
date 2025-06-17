return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
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
  },
}
