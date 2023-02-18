require("FTerm").setup({
	-- border = "double",
	dimensions = {
		height = 0.9,
		width = 0.9,
	},
})

vim.api.nvim_create_user_command("Lazygit", function()
	require("FTerm").run("lazygit")
end, { bang = true })

-- Keybindings
vim.keymap.set("n", "<Leader>/", '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set("t", "<Leader>/", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set("n", "<Leader>lg", ":Lazygit<CR>")
