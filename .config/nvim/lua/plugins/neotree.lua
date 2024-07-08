return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      hijack_netrw_behavior = "open_current", -- "open_default" or "open_current" or "disabled",
      follow_current_file = { enabled = false },
    },
  },
  config = function()
    vim.keymap.set("n", "-", ":Neotree current %:p:h:h %:p<CR>") -- Simmulate netrw behaviour
  end,
}
