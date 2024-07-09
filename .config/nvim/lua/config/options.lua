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
vim.opt.winblend = 0 -- Global transparency for floating windows (has to be 20 for rose-pine, 0 for catppuccin)
vim.opt.conceallevel = 2 -- Level of text hiding
vim.opt.scrolloff = 16 -- Minimum number of screen lines to keep above and below the cursor

-- Set filetype to `bigfile` for files larger than 1.5 MB
-- Only vim syntax will be enabled (with the correct filetype)
-- LSP, treesitter and other ft plugins will be disabled.
-- mini.animate will also be disabled.
vim.g.bigfile_size = 1024 * 1024 * 5 -- 5 MB

-- vim.opt.backupdir = vim.fn.stdpath("data") .. "/backup" -- where to store backup files
-- vim.opt.directory = vim.fn.stdpath("data") .. "/swap" -- where to store swap files
-- vim.opt.undodir = vim.fn.stdpath("data") .. "/undo" -- where to store undo files

LazyVim.terminal.setup("/bin/zsh")
