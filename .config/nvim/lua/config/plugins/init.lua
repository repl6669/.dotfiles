-- require("config.plugins.fidget")

return {
	-- An implementation of the Popup API from vim in Neovim
	{ "nvim-lua/popup.nvim" },

	-- Better netrw
	{ "tpope/vim-vinegar" },

	-- Ability to repeate plugin commands
	{ "tpope/vim-repeat" },

	-- Git support
	{ "tpope/vim-fugitive" },

	-- Easily change surrounding characters
	{ "tpope/vim-surround" },

	-- PHP documentor
	{
		"tobyS/pdv",
		dependencies = {
			"tobyS/vmustache",
		},
	},

	-- Context comment string
	{ "JoosepAlviste/nvim-ts-context-commentstring" },

	-- Create directories which do not exist when creating a file
	{ "jessarcher/vim-heritage" },

	{
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
	},

	-- Todo comments
	{ "aserebryakov/vim-todo-lists" },

	-- Notifications
	{ "rcarriga/nvim-notify" },
}
