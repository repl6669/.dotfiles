" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'dense-analysis/ale'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'pineapplegiant/spaceduck'
Plugin 'vim-syntastic/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'ryanoasis/vim-devicons'
Plugin 'iamcco/markdown-preview.nvim'
Plugin 'tpope/vim-vinegar'
Plugin 'airblade/vim-gitgutter'
Plugin 'preservim/nerdtree'
Plugin 'thaerkh/vim-workspace'
Plugin 'tobyS/pdv'
Plugin 'tobyS/vmustache'

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
nmap <C-R> :CtrlPBuffer<CR>

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




"------------------------Ale settings--------------------------"

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
let g:ale_linters = {'php': ['intelephense', 'phpcs']}

" Fix on save
let g:ale_fix_on_save = 1


"------------------------PHP Documentor--------------------------"

let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"

nmap <Leader>do :call pdv#DocumentWithSnip()<CR>

