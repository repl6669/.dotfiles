local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Toggle Vim Workspace
keymap("n", "<Leader>tw", ":ToggleWorkspace<CR>", opts)
