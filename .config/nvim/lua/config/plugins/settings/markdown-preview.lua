local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Markdown Preview
keymap("n", "<Leader>mp", "<Plug>MarkdownPreview", opts)
keymap("n", "<Leader>mps", "<Plug>MarkdownPreviewStop", opts)
keymap("n", "<Leader>mpt", "<Plug>MarkdownPreviewToggle", opts)
