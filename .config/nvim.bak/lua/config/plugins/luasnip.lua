-- Snippets
return {
	"L3MON4D3/LuaSnip",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local opts = { noremap = true, silent = true }

		local luasnip = require("luasnip")
		local types = require("luasnip.util.types")

		luasnip.config.set_config({
			history = true,
			updateevents = "TextChanged,TextChangedI",
			enable_autosnippets = true,
			ext_opts = {
				[types.choiceNode] = {
					active = {
						virt_text = { { " <- Current Choice", "NonTest" } }, -- display when choice is to be made
					},
				},
			},
		})

		local snippets_path = string.format("%s/lua/config/snippets", vim.fn.stdpath("config")) -- local snippets path

		require("luasnip.loaders.from_vscode").lazy_load() -- load friendly snippets
		require("luasnip.loaders.from_lua").load({ paths = snippets_path }) -- load local snippets

		-- <c-k> to expand
		-- this will expand the current item or jump to the next item within the snippet
		vim.keymap.set({ "i", "s" }, "<c-k>", function()
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			end
		end, opts)

		-- <c-j> to jump backwards
		-- this always moves to the previous item within the snippet
		vim.keymap.set({ "i", "s" }, "<c-j>", function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end, opts)

		-- <c-l> is selecting within a list of options.
		-- This is useful for choice nodes (introduced in the forthcoming episode 2)
		vim.keymap.set("i", "<c-l>", function()
			if luasnip.choice_active() then
				luasnip.change_choice(1)
			end
		end, opts)

		vim.keymap.set("i", "<c-u>", require("luasnip.extras.select_choice")) -- select choice
	end,
}
