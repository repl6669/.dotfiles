return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "SergioRibera/cmp-dotenv",
    "lukas-reineke/cmp-rg",
  },
  opts = function(_, opts)
    if LazyVim.has("nvim-snippets") then
      table.insert(opts.sources, { name = "nvim_lsp_signature_help" })
    end

    table.insert(opts.sources, { name = "dotenv" })

    table.insert(opts.sources, {
      name = "rg",
      -- Try it when you feel cmp performance is poor
      -- keyword_length = 3,
    })

    opts.window = {
      completion = {
        border = "rounded",
        -- winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
      },
      documentation = {
        border = "rounded",
        -- winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
      },
    }
  end,
}
