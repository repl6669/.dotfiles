-- Run tests
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "theutz/neotest-pest",
    "nvim-neotest/neotest-plenary",
  },
  config = function()
    local opts = { noremap = true, silent = true }

    require("neotest").setup({
      adapters = {
        require("neotest-pest")({
          pest_cmd = function()
            return "vendor/bin/pest"
          end,
        }),
        require("neotest-plenary"),
      },
      floating = {
        border = "rounded",
        max_height = 0.6,
        max_width = 0.6,
        options = {},
      },
      quickfix = {
        enabled = false,
        open = false,
      },
      output_panel = {
        enabled = true,
        open = "botright split | resize 30",
      },
    })

    vim.keymap.set("n", "<leader>tf", '<CMD>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', opts) -- Run all tests in current file
    vim.keymap.set("n", "<leader>ts", '<CMD>lua require("neotest").run.run({ suite = true })<CR>', opts) -- Run the whole test suite
    vim.keymap.set("n", "<leader>tnt", '<CMD>lua require("neotest").run.run()<CR>', opts) -- Run the nearest test to the cursor
    vim.keymap.set("n", "<leader>dnt", '<CMD>lua require("neotest").run.run({strategy = "dap"})<CR>', opts) -- Debug nearest test
    vim.keymap.set("n", "<leader>snt", '<CMD>lua require("neotest").run.stop()<CR>', opts) -- Stop running nearest test
    vim.keymap.set("n", "<leader>ant", '<CMD>lua require("neotest").run.attach()<CR>', opts) -- Attach to the nearest test
    vim.keymap.set("n", "<leader>ttop", '<CMD>lua require("neotest").output_panel.toggle()<CR>', opts) -- Toggle test output panel
    vim.keymap.set("n", "<leader>tts", '<CMD>lua require("neotest").summary.toggle()<CR>', opts) -- Toggle test summary
    vim.keymap.set("n", "<leader>to", '<CMD>lua require("neotest").output.open({ enter = true })<CR>', opts) -- Toggle test summary
  end,
}
