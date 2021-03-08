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
Plugin 'airblade/vim-gitgutter'
Plugin 'preservim/nerdtree'
Plugin 'thaerkh/vim-workspace'
Plugin 'tobyS/pdv'
Plugin 'tobyS/vmustache'
Plugin 'neoclide/coc.nvim'

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

"" Open Nerd Tree when vim starts
" autocmd vimenter * NERDTree | call feedkeys("\<C-\>\<C-n>\<c-w>l", 'n')
"" Close vim when only open window is nerd tree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let NERDTreeIgnore = ['(vendor|node_modules|bower_components)$']
let NERDTreeMinimalUI=1
let NERDTreeHijackNetrw=0

" Toggle NERDTree
nmap <Leader><Leader> :NERDTreeToggle<CR>
nmap <leader>. :NERDTreeFind<cr>





"------------------------Control-P Setting--------------------------"

" For example, hitting CMD + P will open the CtrlP fuzzyfinder
nmap <D-P> :CtrlP<CR>

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/vendor/*
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:20,results:20'




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

inoremap <silent><expr> <Leader><space> coc#refresh()

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

