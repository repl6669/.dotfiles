return {
  {
    "gbprod/phpactor.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required to update phpactor
      "neovim/nvim-lspconfig", -- required to automatically register lsp server
      "folke/trouble.nvim", -- required to show phpactor errors
    },
    ft = { "php", "blade" },
    opts = {
      install = {
        -- path = vim.fn.stdpath("data") .. "/opt/",
        -- branch = "master",
        bin = vim.fn.stdpath("data") .. "/mason/bin/phpactor",
        -- php_bin = "php",
        -- composer_bin = "composer",
        -- git_bin = "git",
        check_on_startup = "daily",
      },
      lspconfig = {
        options = {
          language_server_diagnostics_on_update = false,
        },
      },
    },
    keys = {
      {
        "<leader>cpc",
        function()
          require("phpactor").rpc("context_menu", {})
        end,
        mode = { "n" },
        desc = "Open PhpActor Context Menu",
      },
      {
        "<leader>cpic",
        function()
          require("phpactor").rpc("import_class", {})
        end,
        mode = { "n" },
        desc = "Import Class",
      },
      {
        "<leader>cpim",
        function()
          require("phpactor").rpc("import_missing_classes", {})
        end,
        mode = { "n" },
        desc = "Import Missing Classes",
      },
      {
        "<leader>cpn",
        function()
          require("phpactor").rpc("class_new", {})
        end,
        mode = { "n" },
        desc = "New Class",
      },
      {
        "<leader>cpv",
        function()
          require("phpactor").rpc("change_visibility", {})
        end,
        mode = { "n" },
        desc = "Change Visibility",
      },
      {
        "<leader>cpe",
        function()
          require("phpactor").rpc("expand_class", {})
        end,
        mode = { "n" },
        desc = "Expand Class",
      },
      {
        "<leader>cpt",
        function()
          require("phpactor").rpc("transform", {})
        end,
        mode = { "n" },
        desc = "Transform Class",
      },
      {
        "<leader>cpy",
        function()
          require("phpactor").rpc("copy_class", {})
        end,
        mode = { "n" },
        desc = "Copy Class Name",
      },
      {
        "<leader>cpx",
        function()
          require("phpactor").rpc("cache_clear", {})
        end,
        mode = { "n" },
        desc = "Clear PhpActor Cache",
      },
      {
        "<leader>cpls",
        function()
          require("phpactor").rpc("status", {})
        end,
        mode = { "n" },
        desc = "PhpActor LSP Status",
      },
      {
        "<leader>cplr",
        function()
          require("phpactor").rpc("reindex", {})
        end,
        mode = { "n" },
        desc = "Reindex PhpActor LSP",
      },
      -- Phpstan
      {
        "<leader>cppq",
        function()
          if not require("utils.docker").docker_enabled() then
            vim.notify("🔍 PHPStan\n\nDocker is not enabled", vim.log.levels.WARN)
            return
          end

          vim.notify("🔍 PHPStan\n\nRunning analysis...", vim.log.levels.INFO)

          local command = table.concat({
            "docker",
            "compose",
            "-f",
            "../compose.local.yml",
            "exec",
            "api",
            "vendor/bin/phpstan",
            "analyse",
            "--no-progress",
            "--error-format=raw",
          }, " ")

          vim.fn.jobstart(command, {
            on_stdout = function(_, data)
              if not data or #data == 0 or (data[1] == "" and #data == 1) then
                vim.notify("🔍 PHPStan\n\nNo errors found", vim.log.levels.INFO)
                return
              end

              local qf_entries = {}
              local root = require("lazyvim.util").root.get({ normalize = true })

              for _, line in ipairs(data) do
                if line and line ~= "" then
                  -- Parse the line into filename, lnum, and text
                  local filename, lnum, text = line:match("([^:]+):(%d+):(.+)")
                  if filename and lnum and text then
                    -- Replace /app/ with project root
                    filename = filename:gsub("^/app/", root .. "/")
                    table.insert(qf_entries, {
                      filename = filename,
                      lnum = tonumber(lnum),
                      text = text:gsub("^%s*(.-)%s*$", "%1"), -- trim whitespace
                      type = "E",
                    })
                  end
                end
              end

              if #qf_entries > 0 then
                vim.schedule(function()
                  vim.fn.setqflist(qf_entries, "r")
                  vim.notify("🔍 PHPStan\n\nFound " .. #qf_entries .. " issues", vim.log.levels.WARN)
                  require("trouble").open("quickfix")
                end)
              end
            end,
            on_stderr = function(_, data)
              if data and #data > 1 then
                vim.schedule(function()
                  if data[1]:match("^Note: Using configuration file") then
                    vim.notify("🔍 PHPStan\n\n" .. data[1], vim.log.levels.INFO)
                  else
                    vim.notify("🔍 PHPStan\n\nError: " .. table.concat(data, "\n"), vim.log.levels.ERROR)
                  end
                end)
              end
            end,
            on_exit = function(_, code)
              if code == 0 then
                local qf_list = vim.fn.getqflist()
                if #qf_list == 0 then
                  vim.schedule(function()
                    vim.notify("🔍 PHPStan\n\nNo issues found", vim.log.levels.INFO)
                  end)
                end
              end
            end,
            stdout_buffered = true,
            stderr_buffered = true,
          })
        end,
        desc = "Add phpstan errors to quickfix list",
      },
    },
  },
}
