-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.opt.autowrite = false -- Disable auto write
vim.opt.shiftwidth = 4 -- The number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- Insert 4 spaces for a tab
vim.opt.softtabstop = 4 -- On insert use 4 spaces for tab
vim.opt.conceallevel = 2 -- Level of text hiding
vim.opt.scrolloff = 16 -- Minimum number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8 -- The minimal number of columns to keep to the left and to the right of the cursor if 'nowrap' is set
vim.opt.ignorecase = true -- Ignore case in searches
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.smoothscroll = true -- Enable smooth scrolling
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.termguicolors = true -- True color support
vim.opt.laststatus = 3
vim.opt.completeopt = { "menuone", "noselect" } -- Completion opions for code completion

-- Buffer options
vim.bo.autoindent = true
vim.bo.expandtab = true -- Use spaces instead of tabs
vim.bo.shiftwidth = 4 -- Size of an indent
vim.bo.smartindent = true -- Insert indents automatically
vim.bo.softtabstop = 4 -- Number of spaces tabs count for
vim.bo.tabstop = 4 -- Number of spaces in a tab

vim.opt.spelllang = {} -- Set spell checking languages { "en", "cs" }

-- Transparency
vim.opt.winblend = 0 -- Global transparency for floating windows
vim.opt.pumblend = 0 -- Popup transparency

-- Floating windows
vim.o.winborder = "rounded"

-- Set filetype to `bigfile` for files larger than 1.5 MB
-- Only vim syntax will be enabled (with the correct filetype)
-- LSP, treesitter and other ft plugins will be disabled.
-- mini.animate will also be disabled.
vim.g.bigfile_size = 1024 * 1024 * 4 -- 4 MB
vim.opt.redrawtime = 10000 -- Allow more time for loading syntax on large files

-- Create folders for our backups, undos, swaps and sessions if they don't exist
vim.schedule(function()
  vim.cmd("silent call mkdir(stdpath('data').'/backups', 'p', '0700')")
  vim.cmd("silent call mkdir(stdpath('data').'/undos', 'p', '0700')")
  vim.cmd("silent call mkdir(stdpath('data').'/swaps', 'p', '0700')")
  vim.cmd("silent call mkdir(stdpath('data').'/sessions', 'p', '0700')")

  vim.opt.backupdir = vim.fn.stdpath("data") .. "/backups" -- Use backup files
  vim.opt.directory = vim.fn.stdpath("data") .. "/swaps" -- Use Swap files
  vim.opt.undodir = vim.fn.stdpath("data") .. "/undos" -- Set the undo directory
end)

vim.opt.undofile = true -- Maintain undo history between sessions
vim.opt.undolevels = 1000 -- Ensure we can undo a lot!

-- Window options
vim.wo.numberwidth = 4 -- Set the width of the line numbers
vim.wo.signcolumn = "yes" -- Always show the sign column, otherwise it would shift the text each time
vim.wo.number = false -- Together with relativenumber set to true, it is aligned to the right, which is nicer
vim.wo.colorcolumn = "120" -- Make a ruler at 120px

-- vim.opt.backup = true -- Automatically save a backup file
-- vim.opt.backupdir:remove(".") -- Keep backups out of the current directory

-- Disable animations
vim.g.snacks_animate = false

-- if the completion engine supports the AI source,
-- use that instead of inline suggestions
vim.g.ai_cmp = true

-- set to `true` to follow the main branch
-- you need to have a working rust toolchain to build the plugin
-- in this case.
vim.g.lazyvim_blink_main = true

vim.g.lazyvim_php_lsp = "phpactor"

LazyVim.terminal.setup("/bin/zsh")
