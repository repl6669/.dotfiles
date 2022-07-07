local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local utils_status_ok, utils = pcall(require, "null-ls.utils")
if not utils_status_ok then
	return
end

null_ls.setup({
	root_dir = utils.root_pattern("composer.json", "package.json", "Makefile", ".git"), -- Add composer
	diagnostics_format = "#{m} (#{c}) [#{s}]", -- Makes PHPCS errors more readeable
	debug = false,
	sources = {
		null_ls.builtins.diagnostics.eslint, -- Add eslint to js projects
		null_ls.builtins.diagnostics.phpcs.with({ -- Change how the php linting will work
			command = "/opt/homebrew/bin/phpcs",
			extra_args = {
				{ "--standard", "PSR2" },
			},
		}),
		null_ls.builtins.formatting.phpcsfixer.with({
			command = "/opt/homebrew/bin/php-cs-fixer",
			args = {
				"--no-interaction",
				"--quiet",
				"--config=/Users/theimer/.dotfiles/.php-cs-fixer.php",
				"fix",
				"$FILENAME",
			},
			-- extra_args = {
			--     { "--config", vim.fn.expand("/Users/theimer/.dotfiles/.php-cs-fixer.php") },
			-- },
			to_temp_file = false, -- otherwise psr_autoloading does not work
		}),
		null_ls.builtins.formatting.prettier.with({
			filetypes = { "yaml", "markdown", "vue", "javascript", "typescript" },
			extra_args = {
				{ "--tab-width", 2 },
				{ "--print-width", 120 },
			},
		}),
		null_ls.builtins.formatting.stylua, -- Add lua formatter
	},
})
