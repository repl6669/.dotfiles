local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Vim trouble
keymap("n", "<Leader>xx", "<CMD>TroubleToggle<CR>", opts)
keymap("n", "<Leader>xd", "<CMD>TroubleToggle document_diagnostics<CR>", opts)
keymap("n", "<Leader>xq", "<CMD>TroubleToggle quickfix<CR>", opts)
keymap("n", "<Leader>xl", "<CMD>TroubleToggle loclist<CR>", opts)
keymap("n", "gR", "<CMD>TroubleToggle lsp_references<CR>", opts)
