local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

require("project_nvim").setup {
    detection_methods = { "lsp", "pattern" },
    atterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile" },
    exclude_dirs = { "~/vendor/*", "~/node_modules/*" },
}
