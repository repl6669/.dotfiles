return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = true,
      hijack_netrw_behavior = "open_default", -- "open_default" or "open_current" or "disabled",
    },
  },
  config = function()
    vim.keymap.set("n", "-", ":Neotree current %:p:h:h %:p<CR>") -- Simmulate netrw behaviour
  end,
}
