-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Clipboard
vim.keymap.set("n", "<D-c>", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<D-v>", '"+p', { desc = "Paste from system clipboard" })

-- Manage buffers
vim.keymap.set("n", "<Leader>.", ":bd<CR>", { desc = "Close buffer" })

-- Quick settings access
vim.keymap.set("n", "<Leader>evc", ":edit /Users/theimer/.config/nvim/init.lua<CR>", { desc = "Edit init.lua" })
