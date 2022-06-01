let g:python3_host_prog = $HOME."/.pyenv/versions/3.10.1/bin/python3"
source ~/.config/nvim/general.vim        " General Settings
source ~/.config/nvim/mappings.vim       " Remappings for Vim (Plugin specific in plugins)
source ~/.config/nvim/plugins.vim        " Plugin information and settings (vim-plug)

if has('gui_vimr')
  source ~/.config/nvim/ginit.vim
endif

"------------------------Visuals--------------------------"

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" let g:material_theme_style = 'ocean'
" let g:material_terminal_italics = 1
" colorscheme material
colorscheme challenger_deep
let g:challenger_deep_termcolors=1

" let ayucolor="dark"
" colorscheme ayu
"
" colorscheme spaceduck

"------------------------Auto commands--------------------------"

" Automatically source init.vim file on save

augroup autosourcing
    autocmd!
    autocmd BufWritePost init.vim nested source %
augroup END

