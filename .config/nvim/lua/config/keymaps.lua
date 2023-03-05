-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Disable arrow keys
vim.keymap.set("n", "<Left>", ':echo "Use h"')
vim.keymap.set("n", "<Right>", ':echo "Use l"')
vim.keymap.set("n", "<Up>", ':echo "Use k"')
vim.keymap.set("n", "<Down>", ':echo "Use j"')

-- Clipboard
vim.keymap.set("n", "<D-c>", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<D-v>", '"+p', { desc = "Paste from system clipboard" })

-- Manage buffers
vim.keymap.set("n", "<Leader>.", ":bd<CR>", { desc = "Close buffer" })

-- Quick settings access
vim.keymap.set("n", "<Leader>evc", ":edit /Users/theimer/.config/nvim/init.lua<CR>", { desc = "Edit init.lua" })
