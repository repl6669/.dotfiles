return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
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
    })

    return opts
  end,
}
