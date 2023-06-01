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

-- Lazydocker
-- stylua: ignore
vim.keymap.set("n", "<leader>gd", function() require("lazyvim.util").float_term({ "lazydocker" }, { cwd = require("lazyvim.util").get_root(), esc_esc = false }) end, { desc = "Lazydocker (root dir)" })
-- stylua: ignore
vim.keymap.set("n", "<leader>gD", function() require("lazyvim.util").float_term({ "lazydocker" }, {esc_esc = false}) end, { desc = "Lazydocker (cwd)" })
