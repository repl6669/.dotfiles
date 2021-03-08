"------------------------Mappings--------------------------"

" Edit .vimrc in new tab
nmap <Leader>ev :tabedit $MYVIMRC<CR>

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
nmap <Leader>lg :!lazygit<CR>

" Disable arrow keys
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Copy & paste
vnoremap <Leader>y "*y
vnoremap <Leader>p "*p

"------------------------Window management--------------------------"

" Close window
nmap <Leader>wc :q<CR>

" Close tab
nmap <Leader>tc :tabclose<CR>

" Open new tab
nmap <Leader>te :tabedit<CR>

" Open horizontal split
nmap <Leader>hs :sp<CR>

" Open vertical split
nmap <Leader>vs :vsp<CR>

" Move between splits easily by pressing <CTRL-H> instead of <CTRL-W><CTRL-H> eg
nmap <C-H> <C-W><C-H>
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>

" Tabs
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




"------------------------File management--------------------------"

nmap <Leader>s :w<CR>





