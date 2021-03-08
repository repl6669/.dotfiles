" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'dense-analysis/ale'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'pineapplegiant/spaceduck'
Plugin 'SirVer/ultisnips'
Plugin 'ryanoasis/vim-devicons'
Plugin 'iamcco/markdown-preview.nvim'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'preservim/nerdtree'
Plugin 'thaerkh/vim-workspace'
Plugin 'tobyS/pdv'
Plugin 'tobyS/vmustache'
Plugin 'neoclide/coc.nvim'
Plugin 'arnaud-lb/vim-php-namespace'
Plugin 'ludovicchabant/vim-gutentags'

" All of your Plugins must be added before the following line
call vundle#end()            " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal




"------------------------Vim Workspace--------------------------"

nnoremap <leader>tw :ToggleWorkspace<CR>




"------------------------NERD TREE Settings--------------------------"

" Close vim when only open window is nerd tree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Ignore package directories
let NERDTreeIgnore = ['(vendor|node_modules|bower_components)$']

" Do not show help
let NERDTreeMinimalUI=1
" Do not block Vinegar / Netrw
let NERDTreeHijackNetrw=0

" Close NERDtree when files was opened
let NERDTreeQuitOnOpen=1

" Display arrows instead of ascii art in NERDTree
let NERDTreeDirArrows=1

" Toggle NERDTree
nmap <Leader><Leader> :NERDTreeToggle<CR>
nmap <leader>. :NERDTreeFind<cr>




"------------------------Control-P Setting--------------------------"

" For example, hitting CMD + P will open the CtrlP fuzzyfinder
nmap <D-P> :CtrlP<CR>
nmap <C-P> :CtrlPBufTag<CR>

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:20,results:20'

" Keep cache between sessions
let g:ctrlp_clear_cache_on_exit = 0

let g:ctrlp_prompt_mappings = {
\ 'AcceptSelection("e")': ['<2-LeftMouse>'],
\ 'AcceptSelection("t")': ['<cr>'],
\ }



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
\ 'coc-snippets',
\ 'coc-pairs',
\ 'coc-eslint',
\ 'coc-prettier',
\ 'coc-json',
\ ]

" Use <Leader><space> to retrigger completion
inoremap <silent><expr> <Leader><space> coc#refresh()

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

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
"
" Use gh to show documentation in preview window
nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
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

" Fix on save
let g:ale_fix_on_save = 1




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
\           [ 'fileformat', 'fileencoding' ],
\           [ 'gutentags' ],
\           [ 'absolutepath' ],
\       ],
\   },
\   'component_function': {
\       'gitbranch': 'fugitive#head',
\       'gutentags': 'gutentags#statusline',
\   },
\ }




"------------------------Gutentags--------------------------"

let g:gutentags_add_default_project_roots = 0               " Do not use default project roots
let g:gutentags_project_root = ['.git', 'Session.vim']      " Set project root recognisers
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
\ '*/tests/*',
\ 'build',
\ 'dist',
\ '*sites/*/files/*',
\ 'bin',
\ 'node_modules',
\ 'bower_components',
\ 'cache',
\ 'compiled',
\ 'docs',
\ 'example',
\ 'bundle',
\ 'vendor',
\ '*.md',
\ '*-lock.json',
\ '*.lock',
\ '*bundle*.js',
\ '*build*.js',
\ '.*rc*',
\ '*.json',
\ '*.min.*',
\ '*.map',
\ '*.bak',
\ '*.zip',
\ '*.pyc',
\ '*.class',
\ '*.sln',
\ '*.Master',
\ '*.csproj',
\ '*.tmp',
\ '*.csproj.user',
\ '*.cache',
\ '*.pdb',
\ 'tags*',
\ 'cscope.*',
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






