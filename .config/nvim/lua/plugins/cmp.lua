return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "SergioRibera/cmp-dotenv",
    "lukas-reineke/cmp-rg",
  },
  opts = function(_, opts)
    local cmp = require("cmp")

    if LazyVim.has("nvim-snippets") then
      table.insert(opts.sources, { name = "nvim_lsp_signature_help" })
    end

    table.insert(opts.sources, {
      name = "dotenv",
    })

    table.insert(opts.sources, {
      name = "rg",
      -- Try it when you feel cmp performance is poor
      -- keyword_length = 3,
    })

    table.insert(opts.sources, {
      name = "render-markdown",
    })

    opts.window = {
      completion = cmp.config.window.bordered(opts),
      documentation = cmp.config.window.bordered(opts),
    }
  end,
}
