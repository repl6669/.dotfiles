local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

require("config.lsp.options").setup() -- options
require("config.lsp.null-ls") -- null-ls config

local on_attach = require("config.lsp.options").on_attach
local capabilities = require("config.lsp.options").capabilities

-- Intelephese LSP config
require 'lspconfig'.intelephense.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
        licenseKey = "00TJPX959XHH6KQ",
    },
    settings = {
        diagnostics = {
            enable = true,
        },
        files = {
            maxSize = 10000000
        },
    },
}

-- Phpactor LSP config
require("phpactor").setup({
    install = {
        path = vim.fn.stdpath("data") .. "/opt/",
        branch = "master",
        bin = vim.fn.stdpath("data") .. "/opt/phpactor/bin/phpactor",
        php_bin = "php",
        composer_bin = "composer",
        git_bin = "git",
        check_on_startup = "none",
    },
    lspconfig = {
        enabled = true,
        options = {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                files = {
                    maxSize = 10000000
                }
            }
        },
    },
})

-- Lua LSP config
require 'lspconfig'.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
            completion = { keywordSnippet = "Disable" },
            diagnostics = {
                enable = true,
                globals = {
                    "vim",
                    "describe",
                    "it",
                    "before_each",
                    "after_each",
                },
            },
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "4",
                }
            },
            workspace = {
                preloadFileSize = 1000,
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
            },
        },
    },

}
