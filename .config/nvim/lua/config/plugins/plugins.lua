local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use("wbthomason/packer.nvim") -- Have packer manage itself
    use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
    use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
    use("thaerkh/vim-workspace") -- Workspace manager
    use("tpope/vim-vinegar")
    use("tpope/vim-eunuch") -- Easy file and directory manipulation
    use("tpope/vim-fugitive") -- Git support
    use({
        "lewis6991/gitsigns.nvim",
        tag = "release", -- To use the latest release
    })
    use("tpope/vim-surround") -- Easily change surrounding characters
    use("kyazdani42/nvim-web-devicons") -- Icons
    use("lambdalisue/fern.vim") -- Fern file explorer
    use("lambdalisue/fern-hijack.vim") -- Makes fern the default file explorer instead of netrw
    use("lambdalisue/fern-git-status.vim") -- Fern git status
    use("lambdalisue/glyph-palette.vim")
    use("lambdalisue/nerdfont.vim") -- Fern nerdfont
    use("lambdalisue/fern-renderer-nerdfont.vim") -- Render Fern with nerdfont icons
    use("tobyS/pdv") -- PHP documentor
    use("tobyS/vmustache") -- PHP documentor dependency
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- Treesitter
    use("vim-test/vim-test") -- Run tests from vim easily
    use({ "junegunn/fzf", dir = "~/.fzf", run = "./install --all" })
    use({ "junegunn/fzf.vim" })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

    -- Comment manager
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })
    use("JoosepAlviste/nvim-ts-context-commentstring") -- Context comment string
    use("kdheepak/lazygit.nvim") -- Lazygit

    -- Copilot
    use("github/copilot.vim")

    use("nvim-lualine/lualine.nvim")
    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
    })
    use("jwalton512/vim-blade")
    use({
        "gbprod/phpactor.nvim",
        requires = {
            "nvim-lua/plenary.nvim", -- required to update phpactor
            "neovim/nvim-lspconfig", -- required to automaticly register lsp serveur
        },
    })

    -- Colorschemes
    use({ "challenger-deep-theme/vim", as = "challenger-deep" })
    use({
        "rose-pine/neovim",
        as = "rose-pine",
        tag = "v1.*",
    })
    use({ "projekt0n/github-nvim-theme" })

    -- LSP
    use("neovim/nvim-lspconfig")
    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    })

    -- cmp plugins
    use("hrsh7th/nvim-cmp") -- The completion plugin
    use("hrsh7th/cmp-nvim-lsp") -- lsp completion
    use("hrsh7th/cmp-buffer") -- buffer completions
    use("hrsh7th/cmp-path") -- path completions
    use("hrsh7th/cmp-cmdline") -- cmdline completions
    use("saadparwaiz1/cmp_luasnip") -- snippet completions
    use("uga-rosa/cmp-dictionary") -- dictionary completion
    use("onsails/lspkind-nvim") -- icons on the popups
    use("f3fora/cmp-spell") -- spell completion
    use("hrsh7th/cmp-nvim-lsp-signature-help") -- lsp signature help completion

    -- linting
    use({ -- Null-LS Use external formatters and linters
        "jose-elias-alvarez/null-ls.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })

    -- snippets
    use("L3MON4D3/LuaSnip") --snippet engine
    use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

    -- telescope
    use({
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" } },
    })
    use("nvim-telescope/telescope-media-files.nvim")
    use {'nvim-telescope/telescope-ui-select.nvim' }

    -- todos
    use("aserebryakov/vim-todo-lists")

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all use
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
