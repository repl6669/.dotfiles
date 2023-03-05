-- Null-LS Use external formatters and linters
return {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		require("null-ls").setup({
			on_attach = function(client, bufnr)
				vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

				vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { buffer = bufnr })
				vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { buffer = bufnr })
				vim.keymap.set("n", "gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { buffer = bufnr })
				vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { buffer = bufnr })
				vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { buffer = bufnr })
				vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { buffer = bufnr })
				vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer = bufnr })
				vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { buffer = bufnr })
				vim.keymap.set("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", { buffer = bufnr })
				vim.keymap.set(
					"n",
					"<leader>f",
					"<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
					{ buffer = bufnr }
				)

				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
							vim.lsp.buf.formatting_sync()
						end,
					})
				end
			end,
			sources = {
				require("null-ls").builtins.code_actions.eslint_d.with({
					condition = function(utils)
						return utils.root_has_file({ ".eslintrc.js" })
					end,
				}),
				require("null-ls").builtins.diagnostics.eslint_d.with({
					condition = function(utils)
						return utils.root_has_file({ ".eslintrc.js" })
					end,
				}),
				require("null-ls").builtins.diagnostics.gitlint,
				-- require("null-ls").builtins.diagnostics.phpstan,
				require("null-ls").builtins.diagnostics.trail_space.with({
					disabled_filetypes = { "NvimTree" },
				}),
				require("null-ls").builtins.formatting.eslint_d.with({
					condition = function(utils)
						return utils.root_has_file({ ".eslintrc.js" })
					end,
				}),
				-- require("null-ls").builtins.formatting.prettierd,
				require("null-ls").builtins.formatting.pint.with({
					-- extra_args = { "--config", vim.fn.expand("~/.config/pint.json") },
				}),
				require("null-ls").builtins.formatting.stylua,
			},
		})
	end,
}
