return {
	"phpactor/phpactor",
	branch = "master",
	ft = "php",
	build = "composer install --no-dev -o",
	config = function()
		vim.cmd([[
          augroup PhpactorMappings
            au!
            au FileType php nmap <buffer> <Leader>pn :PhpactorClassNew<CR>
          augroup END
        ]])
	end,
}
