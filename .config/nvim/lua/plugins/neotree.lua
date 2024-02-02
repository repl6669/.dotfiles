return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      hijack_netrw_behavior = "open_default", -- "open_default" or "open_current" or "disabled",
    },
  },
  config = function()
    vim.keymap.set("n", "-", ":Neotree current %:p:h:h %:p<CR>") -- Simmulate netrw behaviour
  end,
}
