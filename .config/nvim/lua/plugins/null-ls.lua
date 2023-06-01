return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, opts)
    table.insert(opts.sources, require("typescript.extensions.null-ls.code-actions"))
    local nls = require("null-ls")
    return {
      root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
      sources = {
        -- nls.builtins.formatting.prettierd,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.xmlformat,
        nls.builtins.formatting.pint.with({
          command = vim.fn.expand("~/.local/share/nvim/mason/packages/pint/vendor/bin/pint"),
          -- prefer_local = vim.fn.expand("./vendor/bin/pint"),
          -- extra_args = { "--config", vim.fn.expand("~/.config/pint.json") },
        }),
      },
    }
  end,
}
