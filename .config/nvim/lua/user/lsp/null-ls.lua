local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
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
            vim.api.nvim_create_autocmd("BufWritePost", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.formatting_sync()
                end,
            })
        end
    end,
    root_dir = utils.root_pattern("composer.json", "package.json", "Makefile", ".git"), -- Add composer
    diagnostics_format = "#{m} (#{c}) [#{s}]", -- Makes PHPCS errors more readeable
    debug = false,
    sources = {
        -- null_ls.builtins.completion.spell, -- You still need to execute `:set spell`
        -- null_ls.builtins.diagnostics.eslint, -- Add eslint to js projects
        null_ls.builtins.diagnostics.phpcs.with({ -- Change how the php linting will work
            command = "/opt/homebrew/bin/phpcs",
        }),
        null_ls.builtins.formatting.phpcsfixer.with({
            command = "/opt/homebrew/bin/php-cs-fixer",
            to_temp_file = false, -- otherwise psr_autoloading does not work
            extra_args = {
                "--config", vim.fn.expand("/Users/theimer/.dotfiles/.php-cs-fixer.php"),
            }
        }),
        -- null_ls.builtins.formatting.prettier.with({
        --     filetypes = { "json", "yaml", "markdown", "vue", "typescript" },
        -- }),
    },
})
