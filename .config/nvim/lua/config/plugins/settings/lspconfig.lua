local util = require("lspconfig.util")

vim.keymap.set("n", "<leader>ca", ":CodeActionMenu<CR>")
vim.keymap.set("v", "<leader>ca", ":CodeActionMenu<CR>")
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")

-- vim.lsp.set_log_level("debug")

vim.diagnostic.config({
	virtual_text = true,
	severity_sort = true,
	float = {
		source = true,
		focus = false,
		format = function(diagnostic)
			if diagnostic.user_data ~= nil and diagnostic.user_data.lsp.code ~= nil then
				return string.format("%s: %s", diagnostic.user_data.lsp.code, diagnostic.message)
			end
			return diagnostic.message
		end,
	},
})

local on_attach = function(_, bufnr)
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
	vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", { buffer = bufnr })
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("lspconfig").bashls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").dockerls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").intelephense.setup({
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
	capabilities = capabilities,
	init_options = {
		licenseKey = "00TJPX959XHH6KQ",
	},
})

require("lspconfig").phpactor.setup({
	cmd = { "/Users/theimer/.local/share/nvim/site/pack/packer/opt/phpactor/bin/phpactor", "language-server" },
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		client.server_capabilities.documentDiagnostigsProvider = false
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
	capabilities = capabilities,
	init_options = {
		["language_server_phpstan.enabled"] = false,
		["language_server_psalm.enabled"] = false,
		["language_server.diagnostics_on_save"] = false,
		["language_server.diagnostics_on_open"] = false,
		["language_server.diagnostics_on_update"] = false,
	},
})

require("lspconfig").jsonls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
		},
	},
})

require("lspconfig").sqls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").tailwindcss.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").volar.setup({
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		-- client.server_capabilities.documentFormattingProvider = false
		-- client.server_capabilities.documentRangeFormattingProvider = false
	end,
	capabilities = capabilities,
	-- Enable "Take Over Mode" where volar will provide all TS LSP services
	-- This drastically improves the responsiveness of diagnostic updates on change
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
