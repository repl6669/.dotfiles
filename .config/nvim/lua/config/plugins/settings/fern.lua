local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Fern

vim.g["fern#disable_default_mappings"] = 1
vim.g["fern#renderer"] = "nerdfont"

vim.cmd([[
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
]])

keymap("n", "<Leader><Leader>", ":Fern . -drawer -toggle -width=32<CR>", opts)
keymap("n", "<Leader>.", ":Fern . -drawer -reveal=% -width=32<CR>", opts)
keymap("n", "<C-n>.", ":Fern . -drawer -toggle -stay -reveal=%<CR>", opts)

vim.cmd([[
    augroup FernGroup
        autocmd!
        autocmd FileType fern call FernInit()
        autocmd FileType fern setlocal nonumber
    augroup END
]])
