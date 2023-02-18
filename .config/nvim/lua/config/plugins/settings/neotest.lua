local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

require("neotest").setup({
    adapters = {
        require('neotest-pest')({
            pest_cmd = function()
                return "vendor/bin/pest"
            end
        }),
        -- require("neotest-plenary")
    }
})

keymap('n', '<leader>tnt', '<CMD>lua require("neotest").run.run()<CR>', opts) -- Run the nearest test to the cursor
keymap('n', '<leader>tf', '<CMD>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', opts) -- Run all tests in current file
keymap('n', '<leader>ts', '<CMD>lua require("neotest").run.run({ suite = true })<CR>', opts) -- Run the whole test suite
keymap('n', '<leader>dnt', '<CMD>lua require("neotest").run.run({strategy = "dap"})<CR>', opts) -- Debug nearest test
keymap('n', '<leader>snt', '<CMD>lua require("neotest").run.stop()<CR>', opts) -- Stop running nearest test
