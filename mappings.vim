"------------------------Mappings--------------------------"

" Edit .vimrc in new tab
nmap <Leader>ev :tabedit $MYVIMRC<CR>

" Edit .gvimrc in new tab
nmap <Leader>egv :tabedit ~/.gvimrc<CR>

" Edit plugins
nmap <Leader>ep :tabedit ~/.vim/plugins.vim<CR>

" Edit mappings
nmap <Leader>em :tabedit ~/.vim/mappings.vim<CR>

" Edit snippets with UltiSnips
nmap <Leader>es :UltiSnipsEdit<cr>

" Install plugins with Vundle
nmap <Leader>pi :PluginInstall<CR>

" Add simple highlight removal
nmap <Leader><space> :nohlsearch<CR>


" Open lazygit
nmap <Leader>lg :term lazygit<CR>

" Disable arrow keys
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Copy & paste
map <Leader>y :.w !pbcopy<CR><CR>
map <Leader>p :r !pbpaste<CR>

"------------------------Window management--------------------------"

" Close window
nmap <Leader>wc :q<CR>

" Close tabs to the right
nmap <Leader>tcr :.+1,$tabdo :tabc<CR>

" Keep a list of the most recent two tabs.
let g:tablist = [1, 1]
autocmd TabLeave * let g:tablist[0] = g:tablist[1]
autocmd TabLeave * let g:tablist[1] = tabpagenr()
" When a tab is closed, return to the most recent tab.
" The way vim updates tabs, in reality, this means we must return
" to the second most recent tab.
autocmd TabClosed * exe "normal " . g:tablist[0] . "gt"

cnoremap bd<cr> b#<bar>bd#<cr>

nmap <Leader>tc :tabclose<CR>

" Open new tab
nmap <Leader>tn :tabedit<CR>

" Open horizontal split
nmap <Leader>hs :sp<CR>

" Open vertical split
nmap <Leader>vs :vsp<CR>

" Move between splits easily by pressing <CTRL-H> instead of <CTRL-W><CTRL-H> eg
nmap <C-H> <C-W><C-H>
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>

" Numbered tabs
nmap <Leader>1 1gt
nmap <Leader>2 2gt
nmap <Leader>3 3gt
nmap <Leader>4 4gt
nmap <Leader>5 5gt
nmap <Leader>6 6gt
nmap <Leader>7 7gt
nmap <Leader>8 8gt
nmap <Leader>9 9gt
nmap <Leader>0 0gt

" Move tab to left
nmap <Leader>th :tabm -1<CR>

" Move tab to right
nmap <Leader>tl :tabm +1<CR>

" Go to previous tab
nnoremap <Leader>h gT<CR>

" Go to next tab
nnoremap <Leader>l gt<CR>




"------------------------File management--------------------------"

nmap <Leader>s :w<CR>





