-- Debugging
return {
	"mfussenegger/nvim-dap",
	config = function()
		require("dap").adapters.php = {
			type = "executable",
			command = "node",
			args = { "/Users/theimer/.local/share/nvim/mason/bin/php-debug-adapter" },
		}

		require("dap").configurations.php = {
			{
				type = "php",
				request = "launch",
				name = "Listen for Xdebug",
				port = 9000,
			},
		}
	end,
}
