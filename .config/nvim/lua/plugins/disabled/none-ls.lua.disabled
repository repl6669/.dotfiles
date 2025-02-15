if true then
  return {}
end

return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local nls = require("null-ls")
    return {
      root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
      sources = {
        nls.builtins.code_actions.gitsigns,
        -- nls.builtins.formatting.prettierd.with({
        --   condition = function(utils)
        --     return utils.root_has_file({ ".prettierrc.json" })
        --   end,
        -- }),
        nls.builtins.formatting.rustywind,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.xmlformat,
        nls.builtins.formatting.pint.with({
          command = vim.fn.expand("/Users/theimer/.local/share/nvim/mason/packages/pint/vendor/bin/pint"),
          -- prefer_local = vim.fn.expand("./vendor/bin/pint"),
          -- extra_args = { "--config", vim.fn.expand("~/.config/pint.json") },
        }),
        -- nls.builtins.diagnostics.phpstan,
        -- nls.builtins.diagnostics.shellcheck,
      },
      temp_dir = "/tmp",
    }
  end,
}
