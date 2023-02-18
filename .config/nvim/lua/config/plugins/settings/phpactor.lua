vim.cmd([[
  augroup PhpactorMappings
    au!
    au FileType php nmap <buffer> <Leader>pn :PhpactorClassNew<CR>
  augroup END
]])
