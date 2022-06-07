require "user.options"
require "user.mappings"
require "user.plugins"
require "user.colorscheme"
require "user.settings"
require "user.cmp"
require "user.lsp"
require "user.telescope"

-- Autocommand that reloads neovim whenever you save the init.lua file
vim.cmd [[
  augroup autosourcing
    autocmd!
    autocmd BufWritePost init.lua nested source <afile>
  augroup END
]]

-- TODO
-- 1. set up autocomplete
-- 2. set up LSP (get rid of Ale and coc)
-- PHP Actor
-- PHP Intelephense
-- Vue
-- More?
-- 3. set up snippets
-- 4. learn about tabs vs buffers
-- 5. rework vim.cmd to lua as much as possible
-- 6. if FZF is to be kept, swap to lua fzf
