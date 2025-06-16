return {
  "hrsh7th/nvim-cmp",
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")

    if LazyVim.has("nvim-snippets") then
      table.insert(opts.sources, {
        name = "nvim_lsp_signature_help",
      })
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

    if LazyVim.has("minuet") then
      table.insert(opts.sources, {
        name = "minuet",
      })
    end

    opts = vim.tbl_deep_extend("force", opts, {
      performance = {
        -- It is recommended to increase the timeout duration due to
        -- the typically slower response speed of LLMs compared to
        -- other completion sources. This is not needed when you only
        -- need manual completion.
        fetching_timeout = 2000,
      },
      mapping = {
        ["<A-y>"] = require("minuet").make_cmp_map(),
      },
      window = {
        completion = cmp.config.window.bordered(opts),
        documentation = cmp.config.window.bordered(opts),
      },
    })
  end,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "SergioRibera/cmp-dotenv",
    "lukas-reineke/cmp-rg",
    {
      "epwalsh/obsidian.nvim",
      opts = function(_, opts)
        return vim.tbl_deep_extend("force", opts, {
          completion = {
            nvim_cmp = true,
          },
        })
      end,
    },
  },
}
