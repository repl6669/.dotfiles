local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- Packer itself
	use("wbthomason/packer.nvim")

	-- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/popup.nvim")

	-- Useful lua functions used ny lots of plugins
	use("nvim-lua/plenary.nvim")

	-- Better netrw
	use("tpope/vim-vinegar")

	-- Ability to repeate plugin commands
	use("tpope/vim-repeat")

	-- Session management
	use({
		"rmagatti/auto-session",
		config = function()
			require("config.plugins.settings.auto-session")
		end,
	})

	-- Git support
	use("tpope/vim-fugitive")

	-- Auto pair brackets and more
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	-- Smooth scrolling
	use({
		"karb94/neoscroll.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- Git signs
	use({
		"lewis6991/gitsigns.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("config.plugins.settings.gitsigns")
		end,
	})

	-- Easily change surrounding characters
	use("tpope/vim-surround")

	-- Split or join blocks of code
	use({
		"Wansmer/treesj",
		requires = { "nvim-treesitter" },
		config = function()
			require("treesj").setup({})
		end,
	})

	-- Tree explorer
	use("kyazdani42/nvim-web-devicons")
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	})

	-- PHP documentor
	use("tobyS/pdv")
	use("tobyS/vmustache") -- PHP documentor dependency

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		requires = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/nvim-treesitter-context",
		},
		config = function()
			require("config.plugins.settings.treesitter")
		end,
	})

	-- Run tests
	use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"theutz/neotest-pest",
			"nvim-neotest/neotest-plenary",
		},
		config = function()
			require("config.plugins.settings.neotest")
		end,
	})

	-- Comment manager
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- Context comment string
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- Copilot
	use({
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("config.plugins.settings.copilot")
		end,
	})

	-- ChatGPT
	use({
		"jackMort/ChatGPT.nvim",
		requires = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	})

	-- Create directories which do not exist when creating a file
	use("jessarcher/vim-heritage")

	-- Status line
	use("nvim-lualine/lualine.nvim")

	-- Markdown previews in browser
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	-- Colorschemes
	use({ "challenger-deep-theme/vim", as = "challenger-deep" })
	use({
		"rose-pine/neovim",
		as = "rose-pine",
	})
	use({ "catppuccin/nvim", as = "catppuccin" })

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		requires = {
			"b0o/schemastore.nvim",
			"folke/lsp-colors.nvim",
		},
		config = function()
			require("config.plugins.settings.lspconfig")
		end,
	})

	use({
		"williamboman/mason.nvim",
		requires = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				automatic_installation = true,
			})
		end,
	})

	use({
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
	})

	use({
		"phpactor/phpactor",
		branch = "master",
		ft = "php",
		run = "composer install --no-dev -o",
		config = function()
			require("config.plugins.settings.phpactor")
		end,
	})

	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	-- UI for lsp progress
	use("j-hui/fidget.nvim")

	-- Debugging
	use("mfussenegger/nvim-dap")

	-- CMP
	use({
		"hrsh7th/nvim-cmp", -- The completion plugin
		requires = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-buffer", -- buffer completions
			"hrsh7th/cmp-cmdline", -- cmdline completions
			"hrsh7th/cmp-nvim-lsp", -- lsp completion
			"hrsh7th/cmp-nvim-lsp-signature-help", -- lsp signature help completion
			"hrsh7th/cmp-nvim-lua",
			"jessarcher/cmp-path", -- path completions
			"onsails/lspkind-nvim", -- icons on the popups
			"saadparwaiz1/cmp_luasnip", -- snippet completions
		},
		config = function()
			require("config.plugins.settings.cmp")
		end,
	})

	-- Null-LS Use external formatters and linters
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("config.plugins.settings.null-ls")
		end,
	})

	-- Snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- Floating terminal
	use({
		"numToStr/FTerm.nvim",
		config = function()
			require("config.plugins.settings.fterm")
		end,
	})

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			"nvim-telescope/telescope-media-files.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = function()
			require("config.plugins.settings.telescope")
		end,
	})
	use({
		"rmagatti/session-lens",
		requires = {
			"rmagatti/auto-session",
			"nvim-telescope/telescope.nvim",
		},
	})

	-- Todo comments
	use("aserebryakov/vim-todo-lists")
	use("folke/todo-comments.nvim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all use
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
