local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Lazygit
vim.g.lazygit_floating_window_winblend = 0
vim.g.lazygit_floating_window_scaling_factor = 0.85
vim.g.lazygit_floating_window_use_plenary = 1

-- Open lazygit
keymap("n", "<Leader>lg", ":LazyGit<CR>", opts)
