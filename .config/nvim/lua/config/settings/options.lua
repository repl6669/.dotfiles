local options = {
	backup = false, -- creates a backup file
	cmdheight = 2, -- increase the height of the command line
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	cursorline = true, -- highlight the current line
	expandtab = true, -- convert tabs to spaces
	fileencoding = "utf-8", -- the encoding written to a file
	hlsearch = true, -- highlight all matches on previous search pattern
	incsearch = true, -- incremental search
	ignorecase = true, -- ignore case in search patterns
	laststatus = 2, -- always show the status bar
	mouse = "a", -- allow the mouse to be used in neovim
	numberwidth = 4, -- set the width of the line numbers
	relativenumber = true, -- set relative numbered lines
	ruler = true, -- always show the status bar
	secure = true, -- do not allow autocommands etc.
	shell = "/opt/homebrew/bin/zsh", -- shell to use
	shiftwidth = 4, -- the number of spaces inserted for each indentation
	showmatch = true, -- Highlights the matching parenthesis
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
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
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	pumheight = 10, -- pop up menu height
	scrolloff = 16, -- is one of my fav
	sidescrolloff = 16, -- how much to scroll when using the scrollbar
}

for k, v in pairs(options) do
	vim.opt[k] = v
end
