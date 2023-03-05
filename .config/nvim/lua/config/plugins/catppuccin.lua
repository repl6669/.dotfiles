return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			background = { -- :h background
				light = "latte",
				dark = "mocha",
			},
			term_colors = true,
			-- transparent_background = true,
			integrations = {
				cmp = true,
				dashboard = true,
				gitsigns = true,
				harpoon = false,
				lsp_trouble = false,
				markdown = true,
				mason = true,
				neotest = true,
				noice = false,
				notify = true,
				nvimtree = true,
				telescope = true,
				treesitter = true,
				treesitter_context = false,
				which_key = false,
				dap = {
					enabled = false,
					enable_ui = false,
				},
				indent_blankline = {
					enabled = true,
					colored_indent_levels = false,
				},
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
				},
			},
		})
		-- load the colorscheme here
		vim.cmd([[colorscheme catppuccin]])
	end,
}
