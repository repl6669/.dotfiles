" Set font
set guifont=DankMono_Nerd_Font_Mono:h20

" Hide scrollbars
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

set macligatures
set guioptions-=e

" Increase lineheight
set linespace=6

set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50  "Fix cursor in insert mode
     \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
     \,sm:block-blinkwait175-blinkoff150-blinkon175
let &t_SI = "\e[6 q"                                        " Just block vim cursor things
let &t_EI = "\e[2 q"                                        " Just block vim cursor things

" Disable the print key for macvim
if has("gui_macvim")
    macmenu &File.Print key=<nop>
endif
