" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'                               " Plugin manager
Plugin 'dense-analysis/ale'                                 " Async lint engine
Plugin 'itchyny/lightline.vim'                              " Lightline - sexy status line
Plugin 'pineapplegiant/spaceduck'                           " Spaceduck theme
Plugin 'kaicataldo/material.vim'                            " Material theme
Plugin 'SirVer/ultisnips'                                   " Snippets
Plugin 'iamcco/markdown-preview.nvim'                       " Markdown preview
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-eunuch'                                   " Easy file and directory manipulation
Plugin 'tpope/vim-fugitive'                                 " Git support
Plugin 'ryanoasis/vim-devicons'                             " Icons
Plugin 'airblade/vim-gitgutter'                             " Git gutter
Plugin 'lambdalisue/fern.vim'                               " Fern file explorer
Plugin 'lambdalisue/fern-hijack.vim'                        " Makes fern the default file explorer instead of netrw
Plugin 'lambdalisue/fern-git-status.vim'                    " Fern git status
Plugin 'lambdalisue/nerdfont.vim'                           " Fern nerdfont
Plugin 'lambdalisue/fern-renderer-nerdfont.vim'             " Render Fern with nerdfont icons
Plugin 'lambdalisue/glyph-palette.vim'
Plugin 'thaerkh/vim-workspace'                              " Workspace manager
Plugin 'tobyS/pdv'                                          " PHP documentor
Plugin 'tobyS/vmustache'                                    " PHP documentor dependency
Plugin 'neoclide/coc.nvim'                                  " Autocompletion and much more
Plugin 'arnaud-lb/vim-php-namespace'                        " PHP namespace
Plugin 'ludovicchabant/vim-gutentags'                       " Tags manager basically, very good
Plugin 'sheerun/vim-polyglot'                               " Better syntax highlighting
Plugin 'vim-test/vim-test'                                  " Run tests from vim easily
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }       " Fuzzy finder - top
Plugin 'junegunn/fzf.vim'
Plugin 'preservim/nerdcommenter'                            " Comment manager (mainly used for toggling comments)
Plugin 'airblade/vim-rooter'                                " Project rooter

" All of your Plugins must be added before the following line
call vundle#end()            " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal




"------------------------Vim Workspace--------------------------"

nnoremap <leader>tw :ToggleWorkspace<CR>




"------------------------Fern--------------------------"

nmap <Leader><Leader> :Fern . -drawer -toggle -width=32<CR>
nmap <Leader>. :Fern . -drawer -reveal=% -width=32<CR>

function! s:init_fern() abort
    nmap <buffer> H <Plug>(fern-action-open:split)
    nmap <buffer> V <Plug>(fern-action-open:vsplit)
    nmap <buffer> R <Plug>(fern-action-rename)
    nmap <buffer> M <Plug>(fern-action-move)
    nmap <buffer> C <Plug>(fern-action-copy)
    nmap <buffer> P <Plug>(fern-action-new-path)
    nmap <buffer> N <Plug>(fern-action-new-file)
    nmap <buffer> D <Plug>(fern-action-new-dir)
    nmap <buffer> I <Plug>(fern-action-hidden-toggle)
    nmap <buffer> dd <Plug>(fern-action-trash)
    nmap <buffer> l <Plug>(fern-action-expand)
    nmap <buffer> h <Plug>(fern-action-collapse)
    nmap <buffer> ff <Plug>(fern-action-fzf-both)
    nmap <buffer> fg <Plug>(fern-action-grep)
    nmap <buffer> <Leader> <Plug>(fern-action-mark)
endfunction

augroup fern-custom
    autocmd! *
    autocmd FileType fern call s:init_fern()
augroup END

let g:fern#renderer = "nerdfont"




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




"------------------------Markdown Preview--------------------------"
"
nmap <Leader>mp <Plug>MarkdownPreview
nmap <Leader>mps <Plug>MarkdownPreviewStop
nmap <Leader>mpt <Plug>MarkdownPreviewToggle




"------------------------COC Settings--------------------------"

let g:coc_global_extensions = [
    \ 'coc-css',
    \ 'coc-dictionary',
    \ 'coc-emmet',
    \ 'coc-emoji',
    \ 'coc-eslint',
    \ 'coc-git',
    \ 'coc-go',
    \ 'coc-highlight',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-lua',
    \ 'coc-pairs',
    \ 'coc-phpls',
    \ 'coc-prettier',
    \ 'coc-snippets',
    \ 'coc-tailwindcss',
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

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
"
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



"------------------------Ale settings--------------------------"

" Disable ALE lsp as completion will be handled by coc
let g:ale_disable_lsp = 1

" Set phpcs settings
let g:ale_php_phpcs_executable='/usr/local/bin/phpcs'
let g:ale_php_phpcs_standard='PSR2'

" Set php-cs-fixer settings
let g:ale_php_cs_fixer_executable='/usr/local/bin/php-cs-fixer'
let g:ale_php_cs_fixer_options = '--config=' . $DOTFILES . '/.php_cs'

" Fixers
let g:ale_fixers = {
\   '*': ['trim_whitespace'],
\   'javascript': ['eslint', 'prettier'],
\   'php': ['php_cs_fixer'],
\}

" Linters
let g:ale_linters = {
\ 'php': ['intelephense', 'phpcs'],
\}

" Lint on save
let g:ale_lint_on_save = 1

" Lint on text change
let g:ale_lint_on_text_changed = 0

" Fix on save
let g:ale_fix_on_save = 1

" Fix on text change
let g:ale_fix_on_text_changed = 0





"------------------------PHP Documentor--------------------------"

let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"

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

let g:lightline = {
\   'colorscheme': 'spaceduck',
\   'active': {
\       'left': [
\           [ 'mode', 'paste' ],
\           [ 'filename', 'readonly', 'modified' ],
\           [ 'gitbranch' ],
\       ],
\       'right': [
\           [ 'percent' ],
\           [ 'lineinfo' ],
\           [ 'gutentags' ],
\       ],
\   },
\   'component_function': {
\       'gitbranch': 'fugitive#head',
\       'gutentags': 'gutentags#statusline',
\   },
\ }




"------------------------Gutentags--------------------------"

let g:gutentags_add_default_project_roots = 0               " Do not use default project roots
let g:gutentags_project_root = ['.git']                     " Set project root recognisers
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')   " Move cache elsewhere, so no need for gitignore
let g:gutentags_generate_on_new = 1                         " Generate on new project
let g:gutentags_generate_on_missing = 1                     " Generate on missing tag
let g:gutentags_generate_on_write = 1                       " Generate on write
let g:gutentags_generate_on_empty_buffer = 0                " Do not generate on empty buffer

                                                            " a: Access (or export) of class members
                                                            " i: Inheritance information
                                                            " l: Language of input file containing tag
                                                            " m: Implementation information
                                                            " n: Line number of tag definition
                                                            " \S: Signature of routine (e.g. prototype or parameter list)
" Make Gutentags generate more
let g:gutentags_ctags_extra_args = [
\ '--tag-relative=yes',
\ '--fields=+ailmnS',
\ ]

" Exclude files
let g:gutentags_ctags_exclude = [
\ '*.git', '*.svg', '*.hg',
\ '*-lock.json',
\ '*.Master',
\ '*.bak',
\ '*.cache',
\ '*.class',
\ '*.csproj',
\ '*.csproj.user',
\ '*.js',
\ '*.json',
\ '*.lock',
\ '*.map',
\ '*.md',
\ '*.min.*',
\ '*.pdb',
\ '*.pyc',
\ '*.sln',
\ '*.tmp',
\ '*.zip',
\ '*/tests/*',
\ '*build*.js',
\ '*bundle*.js',
\ '*sites/*/files/*',
\ '.*rc*',
\ 'bin',
\ 'bower_components',
\ 'build',
\ 'bundle',
\ 'cache',
\ 'compiled',
\ 'cscope.*',
\ 'dist',
\ 'docs',
\ 'example',
\ 'node_modules',
\ 'tags*',
\ 'vendor',
\ '*.xml',
\ '*.css',
\ '*.less',
\ '*.scss',
\ '*.exe', '*.dll',
\ '*.mp3', '*.ogg', '*.flac',
\ '*.swp', '*.swo',
\ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
\ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
\ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
\ ]

" Command for clearing gutentags cache easily
command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')




"------------------------Vim TEST--------------------------"

let test#strategy = "vimterminal"
let test#php#phpunit#executable = 'php artisan test'

" In a test file runs the test nearest to the cursor, otherwise runs the last nearest test.
nmap <silent> <Leader>tn :TestNearest<CR>

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





