local options = {
	backup = true, -- creates a backup file
	cmdheight = 2, -- increase the height of the command line
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	cursorline = true, -- highlight the current line
	expandtab = true, -- convert tabs to spaces
	fileencoding = "utf-8", -- the encoding written to a file
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	incsearch = true, -- incremental search
	laststatus = 2, -- always show the status bar
	mouse = "a", -- allow the mouse to be used in neovim
	numberwidth = 4, -- set the width of the line numbers
	pumheight = 10, -- pop up menu height
	redrawtime = 10000, -- allow more time for loading syntax on large files
	relativenumber = true, -- set relative numbered lines
	ruler = true, -- always show the status bar
	scrolloff = 16, -- is one of my fav
	secure = true, -- do not allow autocommands etc.
	shell = "/opt/homebrew/bin/zsh", -- shell to use
	shiftwidth = 4, -- the number of spaces inserted for each indentation
	showmatch = true, -- Highlights the matching parenthesis
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	sidescrolloff = 16, -- how much to scroll when using the scrollbar
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	softtabstop = 4, -- On insert use 4 spaces for tab
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	tabstop = 4, -- insert 2 spaces for a tab
	termguicolors = true, -- set term gui colors (most terminals support this)
	timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
	title = true, -- show the current file name in the title bar
	undofile = true, -- enable persistent undo
	updatetime = 300, -- faster completion (4000ms default)
	vb = true, -- visual bell
	wildmenu = true, -- turn on wild menu
	wrap = false, -- display lines as one long line
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.backupdir:remove(".") -- keep backups out of the current directory
vim.opt.shortmess:append({ I = true }) -- disable the splash screen
