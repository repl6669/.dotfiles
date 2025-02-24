-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Clipboard
vim.keymap.set("n", "<D-c>", '"+y', { desc = "Copy to System Clipboard" })
vim.keymap.set("n", "<D-v>", '"+p', { desc = "Paste from System Clipboard" })

-- Manage buffers
vim.keymap.set("n", "<Leader>.", ":bd<CR>", { desc = "Close Buffer" })

-- Quick settings access
vim.keymap.set("n", "<Leader>C", ":edit /Users/theimer/.config/nvim/init.lua<CR>", { desc = "Edit Configuration" })
