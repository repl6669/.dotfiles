local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "gS", "<cmd>TSJSplit<cr>", opts) -- Split lines
keymap("n", "gJ", "<cmd>TSJJoin<cr>", opts) -- Join lines

