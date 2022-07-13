require("config.settings")
require("config.lsp")
require("config.plugins")

-- Close quickfix window when selecting an item from it
-- vim.cmd([[
-- :autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
-- ]])

-- TODO
-- configure auto-session plugin instead of vim-workspace, because it has telescope support by other plugin lol
-- setup null-ls with pint (now making problmms)
-- make php snippets
-- rework vim.cmd to lua as much as possible
-- if FZF is to be kept, swap to lua fzf?
