if vim.g.neovide then
	-- Set up font
	vim.opt.guifont = { "DankMono Nerd Font Mono", ":h18" }

	-- Helper function for transparency formatting
	local alpha = function()
		return string.format("%x", math.floor(255 * 0.9))
	end
	-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
	-- vim.g.neovide_transparency = 0.0
	-- vim.g.transparency = 0.9
	vim.g.neovide_background_color = "#1f1e2f" .. alpha()

	-- Light theme settings
	-- vim.opt.background = "light"
	-- vim.g.neovide_background_color = "#ffffff" .. alpha()

	-- Disable cursor animation
	vim.g.neovide_cursor_animation_length = 0

	-- Enable cursor ripple effect
	vim.g.neovide_cursor_vfx_mode = "ripple"

	-- Remember window size
	vim.g.neovide_remember_window_size = true

	vim.api.nvim_set_keymap("", "<D-v>", '"+p<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("v", "<D-c>", '"+y<CR>', { noremap = true, silent = true })
end
