-- Settings
require("config.settings.mappings")
require("config.settings.options")
-- require("config.settings.colorscheme")
require("config.settings.neovide")

-- Set up lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("config.plugins", opts)

-- Close quickfix window when selecting an item from it
-- vim.cmd([[
-- :autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
-- ]])

-- TODO
-- make php snippets
-- rework vim.cmd to lua as much as possible
-- if FZF is to be kept, swap to lua fzf?
