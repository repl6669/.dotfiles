let mapleader = ','                                         " Map leader to ','

so ~/.vim/plugins.vim
so ~/.vim/mappings.vim

"------------------------Basic settings--------------------------"


filetype plugin indent on " Turn on plugins, auto indentation, and syntax highlighting

set nocompatible                                            " Use Vim settings, rather then Vi settings
set nobackup                                                " Stop vim from leaving temp files everywhere
set nowritebackup                                           " Don't write your undo history to a file
set history=200                                             " Only save 200 undos
set ruler                                                   " show the cursor position all the time
set showcmd                                                 " display incomplete commands
set incsearch                                               " do incremental searching
set vb                                                      " Turn on vim internal visual bell
set t_vb=                                                   " 🔕
set wildmenu                                                " Turn on the WiLd menu
set laststatus=2                                            " Always display the status line
set mousefocus                                              " gvim mouse click will select pane
set shell=/bin/sh                                           " Ensure that vim always runs from a shell https://rvm.io/integration/vim
set backspace=indent,eol,start                              " http://vim.wikia.com/wiki/Backspace_and_delete_problems
set list listchars=tab:»·,trail:·                           " Display extra whitespace
set nowrap                                                  " Do not automatically wrap on load
set formatoptions-=t                                        " Do not automatically wrap text when typing

set tabstop=4                                               " The width of a TAB is set to 4.
                                                            " Still it is a \t. It is just that
                                                            " Vim will interpret it to be having
                                                            " a width of 4.

set shiftwidth=4                                            " Indents will have a width of 4
set softtabstop=4                                           " Sets the number of columns for a TAB
set expandtab                                               " Expand TABs to spaces

" Ignore compiled files
set wildignore+=*.o,*~,*.pyc
set wildignore+="bin/*"
set wildignore+="build/*"

set relativenumber                                          " Set relative numbers
set numberwidth=4                                           " Set number width




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

colorscheme spaceduck




"------------------------Search--------------------------"

set hlsearch                                                " Turn on search highlighting
set incsearch                                               " Turn on incremental search




"------------------------Splits--------------------------"

" Splits
set splitbelow                                              " Always open splits below current window
set splitright                                              " Always open splits to the right




"------------------------Auto commands--------------------------"

" Automatically source .vimrc file on save
augroup autosourcing
    autocmd!
    autocmd BufWritePost .vimrc nested source %
augroup END




"------------------------Other configuration--------------------------"

" Load the Local config if available
if filereadable("~/.vimrc.local")
  source ~/.vimrc.local
endif

" Use Ack instead of Grep when available (You should really check out Ack it is awesome http://beyondgrep.com/)
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor
endif




