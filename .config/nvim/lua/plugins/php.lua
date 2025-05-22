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
        branch = "master",
        bin = vim.fn.stdpath("data") .. "/mason/packages/phpactor/phpactor.phar",
        php_bin = "php",
        -- php_bin = (
        --   require("utils.docker").docker_enabled()
        --   and "docker compose -f"
        --     .. require("lazyvim.util").root.get({ normalize = true })
        --     .. "/compose.local.yml exec api php"
        -- ) or "php",
        composer_bin = "composer",
        git_bin = "git",
        check_on_startup = "none",
      },
      lspconfig = {
        options = {
          cmd = { vim.fn.stdpath("data") .. "/mason/bin/phpactor", "language-server" },
          language_server_diagnostics_on_update = false,
          -- root_dir = function(pattern)
          --   return require("lazyvim.util").root.get({ normalize = true }) .. "/api"
          -- end,
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
            vim.notify("Docker is not enabled", vim.log.levels.ERROR, {
              id = "phpstan_docker_check",
              title = "PHPStan",
            })
            return
          end

          local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
          local start_time = vim.uv.hrtime()

          vim.schedule(function()
            vim.notify("Analyzing files...", vim.log.levels.INFO, {
              id = "phpstan_progress",
              title = "PHPStan",
              opts = function(notif)
                notif.icon = spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
              end,
              keep = function()
                return true
              end,
            })
          end)

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
            "--error-format=json",
            "--memory-limit=2G",
          }, " ")

          local stdout_data = {}
          local failed = false

          vim.fn.jobstart(command, {

            on_stdout = function(_, data)
              if not data or #data == 0 or (data[1] == "" and #data == 1) then
                return
              end

              for _, line in ipairs(data) do
                if line and line ~= "" then
                  table.insert(stdout_data, line)
                end
              end
            end,

            on_stderr = function(_, data)
              if not data or #data == 0 or (data[1] == "" and #data == 1) then
                return
              end

              local error = table.concat(data)

              if error:match("^Note: Using configuration file") then
                -- -- Config file message
                -- vim.notify(error, vim.log.levels.WARN, {
                --   id = "phpstan_config",
                --   title = "PHPStan",
                -- })
              else
                -- PHPStan error before analysis
                failed = true
                vim.notify(error, vim.log.levels.ERROR, {
                  title = "PHPStan",
                  id = "phpstan_error",
                })
              end
            end,

            on_exit = function(_, data)
              local end_time = vim.uv.hrtime()
              local duration = string.format("%.2f", (end_time - start_time) / 1e9)

              vim.schedule(function()
                if failed then
                  vim.notify(
                    table.concat({
                      "PHPStan failed",
                      "Please run phpstan in terminal and fix the errors",
                      "Duration: " .. duration .. "s",
                    }, "\n"),
                    vim.log.levels.ERROR,
                    {
                      id = "phpstan_progress",
                      title = "PHPStan",
                      replace = true,
                    }
                  )
                  return
                end

                local qf_entries = {}
                local root = require("lazyvim.util").root.get({ normalize = true })

                -- Parse JSON output
                if #stdout_data > 0 then
                  local json_str = table.concat(stdout_data)
                  local ok, parsed = pcall(vim.json.decode, json_str)

                  if ok and parsed and parsed.files then
                    for file_path, file_data in pairs(parsed.files) do
                      for _, message in ipairs(file_data.messages) do
                        local filename = file_path:gsub("^/app/", root .. "/")
                        table.insert(qf_entries, {
                          filename = filename,
                          lnum = message.line,
                          text = message.message,
                          type = "E",
                        })
                      end
                    end
                  end
                end

                if #qf_entries > 0 then
                  -- Set issues to quickfix list
                  vim.fn.setqflist(qf_entries, "r")

                  -- Success with issues
                  vim.notify(
                    table.concat({
                      "Added " .. #qf_entries .. " to quickfix list",
                      "Duration: " .. duration .. "s",
                    }, "\n"),
                    vim.log.levels.ERROR,
                    {
                      id = "phpstan_progress",
                      title = "PHPStan",
                      replace = true,
                    }
                  )

                  -- Open quickfix list
                  require("trouble").open("quickfix")
                  return
                end

                -- Success with no issues
                vim.notify(
                  table.concat({
                    "No issues found",
                    "Duration: " .. duration .. "s",
                  }, "\n"),
                  vim.log.levels.INFO,
                  {
                    id = "phpstan_progress",
                    title = "PHPStan",
                    replace = true,
                  }
                )
              end)
            end,
          })
        end,
        desc = "Add phpstan errors to quickfix list",
      },
    },
  },

  {
    "ricardoramirezr/blade-nav.nvim",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    ft = { "blade", "php" },
    opts = {
      close_tag_on_complete = true,
    },
  },
}
