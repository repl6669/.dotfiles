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
            maxSize = 40000000,
            -- exclude = {}
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
        enabled = false,
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

-- Volar LSP config
require 'lspconfig'.volar.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
        typescript = {
            serverPath = '/opt/homebrew/lib/node_modules/typescript/lib/tsserverlibrary.js'
            -- Alternative location if installed as root:
            -- serverPath = '/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js'
        }
    },
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
}

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
