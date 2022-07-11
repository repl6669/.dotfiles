local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- disable autosave
vim.g.workspace_autosave_always = 0
vim.g.workspace_autosave = 0

-- Toggle Vim Workspace
keymap("n", "<Leader>tw", ":ToggleWorkspace<CR>", opts)
