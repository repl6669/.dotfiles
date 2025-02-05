return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp-signature-help",
  },
  opts = function(_, opts)
    if LazyVim.has("nvim-snippets") then
      table.insert(opts.sources, { name = "nvim_lsp_signature_help" })
    end

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
