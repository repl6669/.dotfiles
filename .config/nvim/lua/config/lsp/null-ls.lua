local ok, null_ls = pcall(require, "null-ls")
if not ok then
    return
end

local utils_status_ok, utils = pcall(require, "null-ls.utils")
if not utils_status_ok then
    return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
     on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
    root_dir = utils.root_pattern("composer.json", "package.json", "Makefile", ".git"), -- Add composer
    diagnostics_format = "#{m} (#{c}) [#{s}]", -- Makes PHPCS errors more readeable
    debug = false,
    sources = {
        -- null_ls.builtins.diagnostics.eslint, -- Add eslint to js projects
        null_ls.builtins.diagnostics.phpcs.with({ -- Change how the php linting will work
            command = "/opt/homebrew/bin/phpcs",
            extra_args = {
                { "--standard", "PSR2" },
            },
        }),
        null_ls.builtins.formatting.pint.with({
        }),
        null_ls.builtins.formatting.prettier.with({
            filetypes = { "yaml", "markdown", "vue", "javascript", "typescript" },
            extra_args = {
                { "--tab-width", 2 },
                { "--print-width", 120 },
            },
        })
    },
})
