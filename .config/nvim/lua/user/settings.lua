local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- PHPActor
vim.cmd [[
  augroup PhpactorMappings
      au!
      au FileType php nmap <buffer> <Leader>u :PhpactorImportClass<CR>
      au FileType php nmap <buffer> <Leader>e :PhpactorClassExpand<CR>
      au FileType php nmap <buffer> <Leader>ua :PhpactorImportMissingClasses<CR>
      au FileType php nmap <buffer> <Leader>mm :PhpactorContextMenu<CR>
      au FileType php nmap <buffer> <Leader>nn :PhpactorNavigate<CR>
      au FileType php,cucumber nmap <buffer> <Leader>o
          \ :PhpactorGotoDefinition edit<CR>
      au FileType php nmap <buffer> <Leader>K :PhpactorHover<CR>
      au FileType php nmap <buffer> <Leader>tt :PhpactorTransform<CR>
      au FileType php nmap <buffer> <Leader>cc :PhpactorClassNew<CR>
      au FileType php nmap <buffer> <Leader>ci :PhpactorClassInflect<CR>
      au FileType php nmap <buffer> <Leader>fr :PhpactorFindReferences<CR>
      au FileType php nmap <buffer> <Leader>mf :PhpactorMoveFile<CR>
      au FileType php nmap <buffer> <Leader>cf :PhpactorCopyFile<CR>
      au FileType php nmap <buffer> <silent> <Leader>ee
          \ :PhpactorExtractExpression<CR>
      au FileType php vmap <buffer> <silent> <Leader>ee
          \ :<C-u>PhpactorExtractExpression<CR>
      au FileType php vmap <buffer> <silent> <Leader>em
          \ :<C-u>PhpactorExtractMethod<CR>
  augroup END
]]

-- Lazygit
vim.g.lazygit_floating_window_winblend = 0
vim.g.lazygit_floating_window_scaling_factor = 0.85
vim.g.lazygit_floating_window_use_plenary = 1

-- Open lazygit
keymap("n", "<Leader>lg", ":LazyGit<CR>", opts)

-- Toggle Vim Workspace
keymap("n", "<Leader>tw", ":ToggleWorkspace<CR>", opts)

-- Fern

vim.g["fern#disable_default_mappings"] = 1
vim.g["fern#renderer"] = "nerdfont"

vim.cmd [[
function! FernInit() abort
    nmap <buffer><expr>
          \ <Plug>(fern-my-open-expand-collapse)
          \ fern#smart#leaf(
          \   "\<Plug>(fern-action-open:select)",
          \   "\<Plug>(fern-action-expand)",
          \   "\<Plug>(fern-action-collapse)",
          \ )
    nmap <buffer> <CR> <Plug>(fern-action-open-or-enter)
    nmap <buffer> <BS> <Plug>(fern-action-leave)
    nmap <buffer> H <Plug>(fern-action-open:split)
    nmap <buffer> V <Plug>(fern-action-open:vsplit)
    nmap <buffer> R <Plug>(fern-action-rename)
    nmap <buffer> M <Plug>(fern-action-move)
    nmap <buffer> C <Plug>(fern-action-copy)
    nmap <buffer> P <Plug>(fern-action-new-path)
    nmap <buffer> N <Plug>(fern-action-new-file)
    nmap <buffer> D <Plug>(fern-action-new-dir)
    nmap <buffer> I <Plug>(fern-action-hidden:toggle)>
    nmap <buffer> dd <Plug>(fern-action-trash)
    nmap <buffer> l <Plug>(fern-action-expand)
    nmap <buffer> h <Plug>(fern-action-collapse)
    nmap <buffer> ff <Plug>(fern-action-fzf-both)
    nmap <buffer> fg <Plug>(fern-action-grep)
    nmap <buffer> <Leader> <Plug>(fern-action-mark)n
endfunction
]]

keymap("n", "<Leader><Leader>", ":Fern . -drawer -toggle -width=32<CR>", opts)
keymap("n", "<Leader>.", ":Fern . -drawer -reveal=% -width=32<CR>", opts)
keymap("n", "<C-n>.", ":Fern . -drawer -toggle -stay -reveal=%<CR>", opts)

vim.cmd [[
    augroup FernGroup
        autocmd!
        autocmd FileType fern call FernInit()
        autocmd FileType fern setlocal nonumber
    augroup END
]]

-- Markdown Preview
keymap("n", "<Leader>mp", "<Plug>MarkdownPreview", opts)
keymap("n", "<Leader>mps", "<Plug>MarkdownPreviewStop", opts)
keymap("n", "<Leader>mpt", "<Plug>MarkdownPreviewToggle", opts)

-- Copilot
vim.cmd [[
    imap <silent><script><expr> <Leader><TAB> copilot#Accept("\<CR>")
    let g:copilot_no_tab_map = v:true
]]

-- Treesitter
require 'nvim-treesitter.configs'.setup {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = { "c", "lua", "rust", "php", "vue", "typescript" },

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- list of language that will be disabled
        -- disable = { "c", "rust" },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        -- additional_vim_regex_highlighting = false,
    },

    context_commentstring = {
        enable = true
    }
}

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'challenger_deep',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {
        lualine_a = { 'branch' },
        lualine_b = { 'buffers' },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'tabs' }
    },
    extensions = {}
}

require("lualine").setup()

-- Git blame
vim.g.gitblame_enabled = 0
keymap("n", "<Leader>tgb", ":GitBlameToggle<CR>", opts)

-- Vim trouble
keymap("n", "<Leader>xx", "<CMD>TroubleToggle<CR>", opts)
keymap("n", "<Leader>xd", "<CMD>TroubleToggle document_diagnostics<CR>", opts)
keymap("n", "<Leader>xq", "<CMD>TroubleToggle quickfix<CR>", opts)
keymap("n", "<Leader>xl", "<CMD>TroubleToggle loclist<CR>", opts)
keymap("n", "gR", "<CMD>TroubleToggle lsp_references<CR>", opts)
