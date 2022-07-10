require("config.settings")
require("config.lsp")
require("config.plugins")

-- Close quickfix window when selecting an item from it
vim.cmd([[
:autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
]])

-- TODO
-- set up snippets
-- rework vim.cmd to lua as much as possible
-- if FZF is to be kept, swap to lua fzf?
-- switch to coq instead of cmp?
