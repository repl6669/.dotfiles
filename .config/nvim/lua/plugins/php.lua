return {
  -- Native phpactor configuration using our custom implementation
  {
    "folke/trouble.nvim", -- Still needed for phpstan integration
    optional = true,
  },

  {
    "LazyVim/LazyVim",
    opts = function()
      -- Setup phpactor commands and keymaps
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "php", "blade" },
        callback = function()
          local phpactor = require("utils.phpactor")

          -- Configure phpactor for Docker if needed
          -- Uncomment and modify this if you use Docker
          -- if require("utils.docker").docker_enabled() then
          --   phpactor.config.php_bin = "docker compose -f " ..
          --     require("lazyvim.util").root.get({ normalize = true }) ..
          --     "/compose.local.yml exec api php"
          -- end
        end,
      })

      -- Create phpactor commands
      vim.api.nvim_create_user_command("PhpActor", function(opts)
        local phpactor = require("utils.phpactor")
        if opts.args == "" then
          phpactor.context_menu()
        else
          -- Handle specific phpactor commands
          local commands = {
            context_menu = phpactor.context_menu,
            import_class = phpactor.import_class,
            import_missing_classes = phpactor.import_missing_classes,
            new_class = phpactor.new_class,
            change_visibility = phpactor.change_visibility,
            expand_class = phpactor.expand_class,
            transform = phpactor.transform,
            copy_class = phpactor.copy_class,
            cache_clear = phpactor.cache_clear,
            status = phpactor.status,
            reindex = phpactor.reindex,
          }

          local cmd = commands[opts.args]
          if cmd then
            cmd()
          else
            vim.notify("Unknown phpactor command: " .. opts.args, vim.log.levels.ERROR)
          end
        end
      end, {
        nargs = "?",
        complete = function()
          return {
            "context_menu",
            "import_class",
            "import_missing_classes",
            "new_class",
            "change_visibility",
            "expand_class",
            "transform",
            "copy_class",
            "cache_clear",
            "status",
            "reindex",
          }
        end,
        desc = "Phpactor commands",
      })
    end,

    keys = {
      {
        "<leader>cpc",
        function()
          require("utils.phpactor").context_menu()
        end,
        ft = { "php", "blade" },
        desc = "phpactor: Context Menu",
      },
      {
        "<leader>cpic",
        function()
          require("utils.phpactor").import_class()
        end,
        ft = { "php", "blade" },
        desc = "phpactor: Import Class",
      },
      {
        "<leader>cpim",
        function()
          require("utils.phpactor").import_missing_classes()
        end,
        ft = { "php", "blade" },
        desc = "phpactor: Import Missing Classes",
      },
      {
        "<leader>cpn",
        function()
          require("utils.phpactor").new_class()
        end,
        ft = { "php", "blade" },
        desc = "phpactor: New Class",
      },
      {
        "<leader>cpv",
        function()
          require("utils.phpactor").change_visibility()
        end,
        ft = { "php", "blade" },
        desc = "phpactor: Change Visibility",
      },
      {
        "<leader>cpe",
        function()
          require("utils.phpactor").expand_class()
        end,
        ft = { "php", "blade" },
        desc = "phpactor: Expand Class",
      },
      {
        "<leader>cpt",
        function()
          require("utils.phpactor").transform()
        end,
        ft = { "php", "blade" },
        desc = "phpactor: Transform",
      },
      {
        "<leader>cpy",
        function()
          require("utils.phpactor").copy_class()
        end,
        ft = { "php", "blade" },
        desc = "phpactor: Copy Class Name",
      },
      {
        "<leader>cpx",
        function()
          require("utils.phpactor").cache_clear()
        end,
        ft = { "php", "blade" },
        desc = "phpactor: Clear Cache",
      },
      {
        "<leader>cpls",
        function()
          require("utils.phpactor").status()
        end,
        ft = { "php", "blade" },
        desc = "phpactor: LSP Status",
      },
      {
        "<leader>cplr",
        function()
          require("utils.phpactor").reindex()
        end,
        ft = { "php", "blade" },
        desc = "phpactor: Reindex LSP",
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
}
