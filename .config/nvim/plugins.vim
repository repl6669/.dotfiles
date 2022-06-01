" ________    ___      ___  ___   _____ ______    ________   ________
" |\   ___  \ |\  \    /  /||\  \ |\   _ \  _   \ |\   __  \ |\   ____\
" \ \  \\ \  \\ \  \  /  / /\ \  \\ \  \\\__\ \  \\ \  \|\  \\ \  \___|
"  \ \  \\ \  \\ \  \/  / /  \ \  \\ \  \\|__| \  \\ \   _  _\\ \  \
"   \ \  \\ \  \\ \    / /    \ \  \\ \  \    \ \  \\ \  \\  \|\ \  \____
"    \ \__\\ \__\\ \__/ /      \ \__\\ \__\    \ \__\\ \__\\ _\ \ \_______\
"     \|__| \|__| \|__|/        \|__| \|__|     \|__| \|__|\|__| \|_______|
"

"----------------------------------------------------------------------
"                            PLUGINS
"----------------------------------------------------------------------

" Make sure you have vim-plug installed -> ~/.local/share/nvim/sit/autoload/plug.vim
call plug#begin('~/.vim/plugged')
    Plug 'dense-analysis/ale'                                                               " Async lint engine
    Plug 'thaerkh/vim-workspace'                                                            " Workspace manager
    " Plug 'itchyny/lightline.vim'                                                            " Lightline - sexy status line
    Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
    Plug 'kaicataldo/material.vim'                                                          " Material theme
    Plug 'SirVer/ultisnips'                                                                 " Snippets
    Plug 'tpope/vim-vinegar'
    Plug 'tpope/vim-eunuch'                                                                 " Easy file and directory manipulation
    Plug 'tpope/vim-fugitive'                                                               " Git support
    Plug 'tpope/vim-surround'
    Plug 'kyazdani42/nvim-web-devicons'                                                     " Icons
    Plug 'airblade/vim-gitgutter'                                                           " Git gutter
    Plug 'lambdalisue/fern.vim'                                                             " Fern file explorer
    Plug 'lambdalisue/fern-hijack.vim'                                                      " Makes fern the default file explorer instead of netrw
    Plug 'lambdalisue/fern-git-status.vim'                                                  " Fern git status
    Plug 'lambdalisue/nerdfont.vim'                                                         " Fern nerdfont
    Plug 'lambdalisue/fern-renderer-nerdfont.vim'                                           " Render Fern with nerdfont icons
    Plug 'lambdalisue/glyph-palette.vim'
    Plug 'tobyS/pdv'                                                                        " PHP documentor
    Plug 'tobyS/vmustache'                                                                  " PHP documentor dependency
    Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}                      " Autocompletion and much more
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'vim-test/vim-test'                                                                " Run tests from vim easily
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }                                     " Fuzzy finder - top
    Plug 'junegunn/fzf.vim'
    " Plug 'preservim/nerdcommenter'                                                          " Comment manager (mainly used for toggling comments)
    Plug 'tpope/vim-commentary'                                                             " Comment manager
    Plug 'JoosepAlviste/nvim-ts-context-commentstring'                                      " Context comment string
    Plug 'kdheepak/lazygit.nvim'                                                            " Lazygit
    Plug 'kristijanhusak/vim-carbon-now-sh'
    Plug 'github/copilot.vim'
    Plug 'rust-lang/rust.vim'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'ayu-theme/ayu-vim'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
    Plug 'tpope/vim-unimpaired'
    Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
    Plug 'sheerun/vim-polyglot'
    Plug 'jwalton512/vim-blade'
    Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}
    " PHPActor completions, dunno if want yet, because of ncm2 changes (may be big)
    " Plug 'ncm2/ncm2'
    " Plug 'roxma/nvim-yarp'
    " Plug 'phpactor/ncm2-phpactor'

    " LSP
    " Plug 'neovim/nvim-lspconfig'
    " Plug 'williamboman/nvim-lsp-installer'

    " Plug 'hrsh7th/cmp-nvim-lsp'
    " Plug 'hrsh7th/cmp-buffer'
    " Plug 'hrsh7th/cmp-path'
    " Plug 'hrsh7th/cmp-cmdline'
    " Plug 'hrsh7th/nvim-cmp'
    " Plug 'quangnguyen30192/cmp-nvim-ultisnips'
call plug#end()

" Brief help
" :PlugInstall      - installs plugins; append `!` to update or just :PluginUpdate
" :PlugClean        - confirms removal of unused plugins; append `!` to auto-approve removal




"------------------------Phpactor--------------------------"

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




"------------------------Lazygit--------------------------"

" Open lazygit
nnoremap <silent> <leader>lg :LazyGit<CR>




"------------------------Vim Workspace--------------------------"

nnoremap <leader>tw :ToggleWorkspace<CR>




"------------------------Fern--------------------------"

let g:fern#disable_default_mappings = 1

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

let g:fern#renderer = "nerdfont"

nmap <Leader><Leader> :Fern . -drawer -toggle -width=32<CR>
nmap <Leader>. :Fern . -drawer -reveal=% -width=32<CR>

augroup FernGroup
    autocmd!
    autocmd FileType fern call FernInit()
    autocmd FileType fern setlocal nonumber
augroup END

nmap <C-n> :Fern . -drawer -toggle -stay -reveal=%<CR>




"-------------------------FZF--------------------------"

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Mapped in iTerm2 from CMD+P
nmap <C-p> :Files<CR>
" Mapped for Macvim
nmap <D-p> :Files<CR>

" Mapped in iTerm2 from CMD+R
nmap <C-f> :BTags<CR>
" Mapped for Macvim
nmap <D-r> :BTags<CR>

nmap <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>m :Marks<CR>

let g:fzf_tags_command = 'ctags -R'

let g:fzf_layout = { 'up': '40%' }

" Make FZF display up top instead of bottom
" --layout=reverse
let $FZF_DEFAULT_OPTS = '--info=inline'

" Make FZF better contextually -> ignore gitignore stuff & work if not in git dir
let $FZF_DEFAULT_COMMAND = "rg --files --hidden -g '!.git' -g '!node_modules' -g '!vendor'"

let g:fzf_colors = {
\ 'fg': ['fg', 'Normal'],
\ 'bg': ['bg', 'Normal'],
\ 'hl': ['fg', 'Comment'],
\ 'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\ 'bg+': ['bg', 'CursorLine', 'CursorColumn'],
\ 'hl+': ['fg', 'Statement'],
\ 'info': ['fg', 'PreProc'],
\ 'border': ['fg', 'Ignore'],
\ 'prompt': ['fg', 'Conditional'],
\ 'pointer': ['fg', 'Exception'],
\ 'marker': ['fg', 'Keyword'],
\ 'spinner': ['fg', 'Label'],
\ 'header': ['fg', 'Comment'],
\}


"------------------------UltiSnips Settings--------------------------"

let g:UltiSnipsExpandTrigger="<TAB>"
let g:UltiSnipsJumpForwardTrigger="<TAB>"
let g:UltiSnipsJumpBackwardTrigger="<S-TAB>"
let g:UltiSnipsSnippetDirectories=["~/.config/nvim/UltiSnips"]




"------------------------Markdown Preview--------------------------"

nmap <Leader>mp <Plug>MarkdownPreview
nmap <Leader>mps <Plug>MarkdownPreviewStop
nmap <Leader>mpt <Plug>MarkdownPreviewToggle




"------------------------Ale settings--------------------------"

" Disable ALE lsp as completion will be handled by coc
let g:ale_disable_lsp = 1
let g:ale_completion_enabled = 0

" Set phpcs settings
let g:ale_php_phpcs_executable='/opt/homebrew/bin/phpcs'
let g:ale_php_phpcs_standard='PSR2'

" Set php-cs-fixer settings
let g:ale_php_cs_fixer_executable='/opt/homebrew/bin/php-cs-fixer'
let g:ale_php_cs_fixer_options = '--config=' . '/Users/theimer/.dotfiles/.php-cs-fixer.php'

" Fixers
let g:ale_fixers = {
\   '*': ['trim_whitespace'],
\   'javascript': ['eslint', 'prettier'],
\   'php': ['php_cs_fixer'],
\}

" Linters
let g:ale_linters = {
\ 'php': ['intelephense'],
\}

" Linting
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

" Fixing
let g:ale_fix_on_save = 1
let g:ale_fix_on_text_changed = 'never'
let g:ale_fix_on_insert_leave = 0




"------------------------COC Settings--------------------------"

let g:coc_global_extensions = [
\ 'coc-css',
\ 'coc-highlight',
\ 'coc-dictionary',
\ 'coc-emmet',
\ 'coc-eslint',
\ 'coc-git',
\ 'coc-go',
\ 'coc-html',
\ 'coc-json',
\ 'coc-pairs',
\ 'coc-prettier',
\ 'coc-python',
\ 'coc-styled-components',
\ 'coc-tsserver',
\ 'coc-word',
\ 'coc-yaml',
\ ]

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Use <Leader><space> to retrigger completion
" inoremap <silent><expr> <Leader><space> coc#refresh()

" Use enter to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Select range based on AST
nmap <silent><Leader>r <Plug>(coc-range-select)
xmap <silent><Leader>r <Plug>(coc-range-select)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" List code actions available for the current buffer
nmap <leader>ca<space>  <Plug>(coc-codeaction)

" Use <CR> to validate completion (allows auto import on completion)
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Mappings to format selected
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use gh to show documentation in preview window
nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation() abort
    if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
    else
    execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction




"------------------------Copilot--------------------------"

imap <silent><script><expr> <Leader><TAB> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true




"------------------------PHP Documentor--------------------------"

let g:pdv_template_dir = $HOME ."/.vim/plugged/pdv/templates_snip"

nmap <Leader>do :call pdv#DocumentWithSnip()<CR>





"------------------------PHP Namespace--------------------------"

function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction

" Use <Leader>u to import PHP Namespace
autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction

" User <Leader>e to expand PHP Namespace
autocmd FileType php inoremap <Leader>e <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>




"------------------------Lightline--------------------------"

" let g:lightline = {
" \   'colorscheme': 'spaceduck',
" \   'active': {
" \       'left': [
" \           [ 'mode', 'paste' ],
" \           [ 'filename', 'readonly', 'modified' ],
" \           [ 'gitbranch' ],
" \       ],
" \       'right': [
" \           [ 'percent' ],
" \           [ 'lineinfo' ],
" \           [ 'gutentags' ],
" \       ],
" \   },
" \   'component_function': {
" \       'gitbranch': 'fugitive#head',
" \       'gutentags': 'gutentags#statusline',
" \   },
" \ }

"------------------------Treesitter--------------------------"

lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ensure_installed = "maintained",

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
EOF



"------------------------Lualine--------------------------"

lua << END
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'challenger_deep',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {},
        always_divide_middle = true,
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {
        lualine_a = {'branch'},
        lualine_b = {'filename'},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {'tabs'}
    },
    extensions = {}
}
END

lua require("lualine").setup()




"------------------------Vim TEST--------------------------"

let g:test#neovim#start_normal = 1 " start in normal mode
let test#strategy = "neovim"
let test#php#phpunit#executable = './vendor/bin/phpunit'
let test#php#pest#executable = './vendor/bin/pest'

" In a test file runs the test nearest to the cursor, otherwise runs the last nearest test.
nmap <silent> <Leader>tnt :TestNearest<CR>

" In a test file runs all tests in the current file, otherwise runs the last file tests.
nmap <silent> <Leader>tf :TestFile<CR>

" Runs the whole test suite.
nmap <silent> <Leader>ts :TestSuite<CR>

" Runs the last test.
nmap <silent> <Leader>tl :TestLast<CR>

" Visits the test file from which you last run your tests.
nmap <silent> <Leader>tg :TestVisit<CR>




"------------------------NERD Commenter--------------------------"

let g:NERDCreateDefaultMappings = 1                         " Create default mappings
let g:NERDSpaceDelims = 1                                   " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 0                               " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left'                             " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDCommentEmptyLines = 1                             " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1                        " Enable trimming of trailing whitespace when uncommenting
let g:NERDToggleCheckAllLines = 1                           " Enable NERDCommenterToggle to check all selected lines is commented or not




