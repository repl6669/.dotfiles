local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

require("nvim-tree").setup()

keymap("n", "<Leader><Leader>", ":NvimTreeToggle .<CR>", opts)
