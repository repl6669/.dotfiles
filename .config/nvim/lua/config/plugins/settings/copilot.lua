-- Copilot
vim.cmd([[
    imap <silent><script><expr> <Leader><TAB> copilot#Accept("\<CR>")
    let g:copilot_no_tab_map = v:true
]])
