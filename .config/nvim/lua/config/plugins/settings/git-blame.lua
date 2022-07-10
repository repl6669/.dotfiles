local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Git blame
vim.g.gitblame_enabled = 0
keymap("n", "<Leader>tgb", ":GitBlameToggle<CR>", opts)
