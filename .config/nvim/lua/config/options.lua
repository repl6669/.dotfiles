-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.opt.autowrite = false -- Disable auto write
vim.opt.shiftwidth = 4 -- The number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- Insert 4 spaces for a tab
vim.opt.softtabstop = 4 -- On insert use 4 spaces for tab
vim.opt.numberwidth = 4 -- Set the width of the line numbers
vim.opt.signcolumn = "yes" -- Always show the sign column, otherwise it would shift the text each time
vim.opt.number = false -- Together with relativenumber set to true, it is aligned to the right, which is nicer
vim.opt.conceallevel = 2 -- Level of text hiding
vim.opt.scrolloff = 16 -- Minimum number of screen lines to keep above and below the cursor
vim.opt.laststatus = 3

vim.opt.spelllang = {} -- Set spell checking languages { "en", "cs" }

-- Transparency
vim.opt.winblend = 0 -- Global transparency for floating windows (has to be 20 for rose-pine, 0 for catppuccin)
vim.opt.pumblend = 0 -- Popup transparency

-- Set filetype to `bigfile` for files larger than 1.5 MB
-- Only vim syntax will be enabled (with the correct filetype)
-- LSP, treesitter and other ft plugins will be disabled.
-- mini.animate will also be disabled.
vim.g.bigfile_size = 1024 * 1024 * 10 -- 10 MB
vim.opt.redrawtime = 10000 -- Allow more time for loading syntax on large files

-- vim.opt.backup = true -- Automatically save a backup file
-- vim.opt.backupdir:remove(".") -- Keep backups out of the current directory

-- vim.opt.backupdir = vim.fn.stdpath("data") .. "/backup" -- where to store backup files
-- vim.opt.directory = vim.fn.stdpath("data") .. "/swap" -- where to store swap files
-- vim.opt.undodir = vim.fn.stdpath("data") .. "/undo" -- where to store undo files

-- Disable animations
vim.g.snacks_animate = false

-- if the completion engine supports the AI source,
-- use that instead of inline suggestions
vim.g.ai_cmp = false

-- set to `true` to follow the main branch
-- you need to have a working rust toolchain to build the plugin
-- in this case.
vim.g.lazyvim_blink_main = true

LazyVim.terminal.setup("/bin/zsh")
