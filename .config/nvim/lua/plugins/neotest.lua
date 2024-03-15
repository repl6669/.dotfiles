-- NOTE: https://github.com/V13Axel/neotest-pest
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-plenary",
      "V13Axel/neotest-pest",
    },
    opts = {
      log_level = vim.log.levels.DEBUG,
      adapters = {
        -- "neotest-plenary",
        ["neotest-pest"] = {
          -- Root files
          root_files = { "tests/Pest.php" },

          -- Ignore these directories when looking for tests
          ignore_dirs = { "vendor", "node_modules" },

          -- Ignore any projects containing "phpunit-only.tests"
          root_ignore_files = {},

          -- Specify suffixes for files that should be considered tests
          test_file_suffixes = { "Test.php" },

          -- Enable Docker support
          sail_enabled = function()
            return true
          end,

          -- vim.fn.fnamemodify(require("lazyvim.util").root.get({ normalize = true }), ":h:t") .. "-api-fpm-1",

          -- WARNING: Not used?
          -- Docker executable
          sail_executable = {
            "docker",
            "compose",
            "-f",
            "../docker-compose.dev.yml",
            "exec",
            "api-fpm",
          },

          -- Custom pest binary.
          pest_cmd = {
            "docker",
            "compose",
            "-f",
            "../docker-compose.dev.yml",
            "exec",
            "api-fpm",
            "vendor/bin/pest",
          },

          -- Run N tests in parallel, <=1 doesn't pass --parallel to pest at all
          parallel = 0,

          -- Enable ["compact" output printer](https://pestphp.com/docs/optimizing-tests#content-compact-printer)
          compact = false,

          results_path = function()
            return "storage/app/tests/" .. os.date("pest-%Y%m%d-%H%M%S")
          end,
        },
      },
    },
  },
}

-- -- Run tests
-- return {
--   "nvim-neotest/neotest",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "nvim-treesitter/nvim-treesitter",
--     "antoinemadec/FixCursorHold.nvim",
--     { "theutz/neotest-pest" },
--     "rouge8/neotest-rust",
--     "nvim-neotest/neotest-plenary",
--   },
--   -- dev = true,
--   config = function()
--     require("neotest").setup({
--       discovery = {
--         enabled = true,
--         concurrent = 2,
--         -- filter_dir = function(name, rel_path, root)
--         --   return name ~= "vendor"
--         -- end,
--       },
--       adapters = {
--         -- require("neotest-plenary"),
--         require("neotest-pest")({
--           pest_cmd = function()
--             return "/vendor/bin/pest"
--           end,
--         }),
--         -- require("neotest-rust"),
--       },
--       open = {
--         enabled = true,
--         open_on_run = true,
--       },
--       floating = {
--         border = "rounded",
--         max_height = 0.6,
--         max_width = 0.6,
--         options = {},
--       },
--       output_panel = {
--         enabled = true,
--         open = "botright split | resize 30",
--       },
--       log_level = vim.log.levels.INFO,
--     })
--
--     -- stylua: ignore
--     vim.keymap.set( "n", "<leader>tt", '<CMD>lua require("neotest").run.run()<CR>', { desc = "Run the nearest test to the cursor" })
--     -- stylua: ignore
--     vim.keymap.set( "n", "<leader>tR", '<CMD>lua require("neotest").run.run_last()<CR>', { desc = "Re-run the last test position" })
--     -- stylua: ignore
--     vim.keymap.set( "n", "<leader>tf", '<CMD>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', { desc = "Run tests in current file" })
--     -- stylua: ignore
--     vim.keymap.set( "n", "<leader>ta", '<CMD>lua require("neotest").run.run("tests")<CR>', { desc = "Run the whole test suite" })
--     -- -- stylua: ignore
--     -- vim.keymap.set( "n", "<leader>ta", '<CMD>lua require("neotest").run.run({ suite = true })<CR>', { desc = "Run the whole test suite" })
--     -- stylua: ignore
--     vim.keymap.set( "n", "<leader>td", '<CMD>lua require("neotest").run.run({ strategy = "dap" })<CR>', { desc = "Debug nearest test" })
--     -- stylua: ignore
--     vim.keymap.set( "n", "<leader>tD", '<CMD>lua require("neotest").run.run({vim.fn.expand("%"), strategy = "dap" })<CR>', { desc = "Debug tests in current file" })
--     -- stylua: ignore
--     vim.keymap.set( "n", "<leader>ts", '<CMD>lua require("neotest").run.stop()<CR>', { desc = "Stop running nearest test" })
--     -- stylua: ignore
--     vim.keymap.set( "n", "<leader>to", '<CMD>lua require("neotest").output.open({ enter = true })<CR>', { desc = "Open result output" })
--     -- stylua: ignore
--     vim.keymap.set( "n", "<leader>tO", '<CMD>lua require("neotest").output_panel.toggle()<CR>', { desc = "Toggle test output panel" })
--     -- stylua: ignore
--     vim.keymap.set( "n", "<leader>tS", '<CMD>lua require("neotest").summary.toggle()<CR>', { desc = "Toggle test summary" })
--     -- stylua: ignore
--     vim.keymap.set( "n", "<leader>tm", '<CMD>lua require("neotest").summary.run_marked()<CR>', { desc = "Run marked tests from summary" })
--     -- stylua: ignore
--     vim.keymap.set( "n", "<leader>tl", '<CMD>lua require("neotest").summary.run_last()<CR>', { desc = "Run last test from summary" })
--   end,
--   -- Stops working for some reason if set with whichKey
--   -- keys = {
--   --   -- stylua: ignore
--   --   { "<leader>tt", function () require("neotest").run.run() end, desc = "Run the nearest test to the cursor", },
--   --   -- stylua: ignore
--   --   { "<leader>tR", function () require("neotest").run.run_last() end, desc = "Re-run the last test position", },
--   --   -- stylua: ignore
--   --   { "<leader>tf", function () require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run tests in current file", },
--   --   -- stylua: ignore
--   --   { "<leader>ta", function () require("neotest").run.run({ suite = true }) end, desc = "Run the whole test suite", },
--   --   -- stylua: ignore
--   --   { "<leader>td", function () require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test", },
--   --   -- stylua: ignore
--   --   { "<leader>tD", function () require("neotest").run.run({vim.fn.expand("%"), strategy = "dap" }) end, desc = "Debug tests in current file", },
--   --   -- stylua: ignore
--   --   { "<leader>ts", function () require("neotest").run.stop() end, desc = "Stop running nearest test", },
--   --   -- stylua: ignore
--   --   { "<leader>ta", function () require("neotest").run.attach() end, desc = "Attach to the nearest test", },
--   --   -- stylua: ignore
--   --   { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Open result output", },
--   --   -- stylua: ignore
--   --   { "<leader>tO", function () require("neotest").output_panel.toggle() end, desc = "Toggle test output panel", },
--   --   -- stylua: ignore
--   --   { "<leader>tS", function () require("neotest").summary.toggle() end, desc = "Toggle test summary", },
--   --   -- stylua: ignore
--   --   { "<leader>tm", function () require("neotest").summary.run_marked() end, desc = "Run marked tests from summary", },
--   --   -- stylua: ignore
--   --   { "<leader>tk", function () require("neotest").summary.run_last() end, desc = "Run last test from summary", },
--   -- },
-- }
