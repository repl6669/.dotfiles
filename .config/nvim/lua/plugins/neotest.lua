-- Run tests
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    { "theutz/neotest-pest" },
    "rouge8/neotest-rust",
    "nvim-neotest/neotest-plenary",
  },
  -- dev = true,
  config = function()
    require("neotest").setup({
      discovery = {
        enabled = true,
        concurrent = 2,
        -- filter_dir = function(name, rel_path, root)
        --   return name ~= "vendor"
        -- end,
      },
      adapters = {
        -- require("neotest-plenary"),
        require("neotest-pest")({
          pest_cmd = function()
            return "/vendor/bin/pest"
          end,
        }),
        -- require("neotest-rust"),
      },
      open = {
        enabled = true,
        open_on_run = true,
      },
      floating = {
        border = "rounded",
        max_height = 0.6,
        max_width = 0.6,
        options = {},
      },
      output_panel = {
        enabled = true,
        open = "botright split | resize 30",
      },
      log_level = vim.log.levels.INFO,
    })

    -- stylua: ignore
    vim.keymap.set( "n", "<leader>tt", '<CMD>lua require("neotest").run.run()<CR>', { desc = "Run the nearest test to the cursor" })
    -- stylua: ignore
    vim.keymap.set( "n", "<leader>tR", '<CMD>lua require("neotest").run.run_last()<CR>', { desc = "Re-run the last test position" })
    -- stylua: ignore
    vim.keymap.set( "n", "<leader>tf", '<CMD>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', { desc = "Run tests in current file" })
    -- stylua: ignore
    vim.keymap.set( "n", "<leader>ta", '<CMD>lua require("neotest").run.run("tests")<CR>', { desc = "Run the whole test suite" })
    -- -- stylua: ignore
    -- vim.keymap.set( "n", "<leader>ta", '<CMD>lua require("neotest").run.run({ suite = true })<CR>', { desc = "Run the whole test suite" })
    -- stylua: ignore
    vim.keymap.set( "n", "<leader>td", '<CMD>lua require("neotest").run.run({ strategy = "dap" })<CR>', { desc = "Debug nearest test" })
    -- stylua: ignore
    vim.keymap.set( "n", "<leader>tD", '<CMD>lua require("neotest").run.run({vim.fn.expand("%"), strategy = "dap" })<CR>', { desc = "Debug tests in current file" })
    -- stylua: ignore
    vim.keymap.set( "n", "<leader>ts", '<CMD>lua require("neotest").run.stop()<CR>', { desc = "Stop running nearest test" })
    -- stylua: ignore
    vim.keymap.set( "n", "<leader>to", '<CMD>lua require("neotest").output.open({ enter = true })<CR>', { desc = "Open result output" })
    -- stylua: ignore
    vim.keymap.set( "n", "<leader>tO", '<CMD>lua require("neotest").output_panel.toggle()<CR>', { desc = "Toggle test output panel" })
    -- stylua: ignore
    vim.keymap.set( "n", "<leader>tS", '<CMD>lua require("neotest").summary.toggle()<CR>', { desc = "Toggle test summary" })
    -- stylua: ignore
    vim.keymap.set( "n", "<leader>tm", '<CMD>lua require("neotest").summary.run_marked()<CR>', { desc = "Run marked tests from summary" })
    -- stylua: ignore
    vim.keymap.set( "n", "<leader>tl", '<CMD>lua require("neotest").summary.run_last()<CR>', { desc = "Run last test from summary" })
  end,
  -- Stops working for some reason if set with whichKey
  -- keys = {
  --   -- stylua: ignore
  --   { "<leader>tt", function () require("neotest").run.run() end, desc = "Run the nearest test to the cursor", },
  --   -- stylua: ignore
  --   { "<leader>tR", function () require("neotest").run.run_last() end, desc = "Re-run the last test position", },
  --   -- stylua: ignore
  --   { "<leader>tf", function () require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run tests in current file", },
  --   -- stylua: ignore
  --   { "<leader>ta", function () require("neotest").run.run({ suite = true }) end, desc = "Run the whole test suite", },
  --   -- stylua: ignore
  --   { "<leader>td", function () require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test", },
  --   -- stylua: ignore
  --   { "<leader>tD", function () require("neotest").run.run({vim.fn.expand("%"), strategy = "dap" }) end, desc = "Debug tests in current file", },
  --   -- stylua: ignore
  --   { "<leader>ts", function () require("neotest").run.stop() end, desc = "Stop running nearest test", },
  --   -- stylua: ignore
  --   { "<leader>ta", function () require("neotest").run.attach() end, desc = "Attach to the nearest test", },
  --   -- stylua: ignore
  --   { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Open result output", },
  --   -- stylua: ignore
  --   { "<leader>tO", function () require("neotest").output_panel.toggle() end, desc = "Toggle test output panel", },
  --   -- stylua: ignore
  --   { "<leader>tS", function () require("neotest").summary.toggle() end, desc = "Toggle test summary", },
  --   -- stylua: ignore
  --   { "<leader>tm", function () require("neotest").summary.run_marked() end, desc = "Run marked tests from summary", },
  --   -- stylua: ignore
  --   { "<leader>tk", function () require("neotest").summary.run_last() end, desc = "Run last test from summary", },
  -- },
}
