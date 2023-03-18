return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function()
    local nls = require("null-ls")
    return {
      sources = {
        -- nls.builtins.formatting.prettierd,
        nls.builtins.formatting.stylua,
        nls.builtins.diagnostics.flake8,
        nls.builtins.formatting.pint.with({
          command = vim.fn.expand("~/.composer/vendor/bin/pint"),
          prefer_local = vim.fn.expand("./vendor/bin/pint"),
          extra_args = { "--config", vim.fn.expand("~/.config/pint.json") },
        }),
      },
    }
  end,
}
