return {
  "phpactor/phpactor",
  branch = "master",
  ft = "php",
  build = "composer install --no-dev -o",
  config = function()
    -- vim.cmd([[
    --     augroup PhpactorMappings
    --         au!
    --         au FileType php nmap <buffer> <Leader>u :PhpactorImportClass<CR>
    --         au FileType php nmap <buffer> <Leader>e :PhpactorClassExpand<CR>
    --         au FileType php nmap <buffer> <Leader>ua :PhpactorImportMissingClasses<CR>
    --         au FileType php nmap <buffer> <Leader>mm :PhpactorContextMenu<CR>
    --         au FileType php nmap <buffer> <Leader>nn :PhpactorNavigate<CR>
    --         au FileType php,cucumber nmap <buffer> <Leader>o
    --             \ :PhpactorGotoDefinition edit<CR>
    --         au FileType php nmap <buffer> <Leader>K :PhpactorHover<CR>
    --         au FileType php nmap <buffer> <Leader>tt :PhpactorTransform<CR>
    --         au FileType php nmap <buffer> <Leader>cc :PhpactorClassNew<CR>
    --         au FileType php nmap <buffer> <Leader>ci :PhpactorClassInflect<CR>
    --         au FileType php nmap <buffer> <Leader>fr :PhpactorFindReferences<CR>
    --         au FileType php nmap <buffer> <Leader>mf :PhpactorMoveFile<CR>
    --         au FileType php nmap <buffer> <Leader>cf :PhpactorCopyFile<CR>
    --         au FileType php nmap <buffer> <silent> <Leader>ee
    --             \ :PhpactorExtractExpression<CR>
    --         au FileType php vmap <buffer> <silent> <Leader>ee
    --             \ :<C-u>PhpactorExtractExpression<CR>
    --         au FileType php vmap <buffer> <silent> <Leader>em
    --             \ :<C-u>PhpactorExtractMethod<CR>
    --     augroup END
    -- ]])

    vim.keymap.set("n", "<leader>pic", ":PhpactorImportClass<CR>", { desc = "Phpactor Import Class" })
    vim.keymap.set("n", "<leader>pcn", ":PhpactorClassNew<CR>", { desc = "Phpactor New Class" })
    vim.keymap.set("n", "<leader>pcv", ":PhpactorChangeVisibility<CR>", { desc = "Phpactor Change Visibility" })
    vim.keymap.set("n", "<leader>pce", ":PhpactorClassExpand<CR>", { desc = "Phpactor Expand Class" })
    vim.keymap.set("n", "<leader>pnn", ":PhpactorNavigate<CR>", { desc = "Phpactor Navigate" })
    vim.keymap.set("n", "<leader>ptt", ":PhpactorTransform<CR>", { desc = "Phpactor Transform" })
    vim.keymap.set(
      "v",
      "<leader>pem",
      ":PhpactorExtractMethod<CR>",
      { silent = true, desc = "Phpactor Extract Method" }
    )
    vim.keymap.set(
      "v",
      "<leader>pee",
      ":PhpactorExtractExpression<CR>",
      { silent = true, desc = "Phpactor Extract Expression" }
    )
    vim.keymap.set(
      "n",
      "<leader>pimc",
      ":PhpactorImportMissingClasses<CR>",
      { desc = "Phpactor Import Missing Classes" }
    )
  end,
}
