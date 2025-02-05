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
      ":Neotree current %:p:h:h %:p<CR>",
      { noremap = true, silent = true },
    },
  },
}
