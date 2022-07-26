local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>tnt", "<cmd>TestNearest<cr>", opts) -- Run the nearest test to the cursor
keymap("n", "<leader>tf", "<cmd>TestFile<cr>", opts) -- Run all tests in current file
keymap("n", "<leader>ts", "<cmd>TestSuite<cr>", opts) -- Run the whole test suite
keymap("n", "<leader>tl", "<cmd>TestLast<cr>", opts) -- Run last test
keymap("n", "<leader>tv", "<cmd>TestVisit<cr>", opts) -- Visit the test from which you last ran your test
