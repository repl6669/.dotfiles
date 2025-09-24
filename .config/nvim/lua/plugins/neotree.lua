return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      hijack_netrw_behavior = "open_current", -- "open_default" or "open_current" or "disabled",
    },
  },
  keys = {
    {
      "-",
      ":Neotree position=current<CR>",
      { noremap = true, silent = true },
    },
  },
}
