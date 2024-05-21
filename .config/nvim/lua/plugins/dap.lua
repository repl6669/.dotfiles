-- Neovim debug adapter protocol
return {
  "mfussenegger/nvim-dap",
  dependencies = {

    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {
        commented = true,
      },
    },

    {
      "nvim-telescope/telescope-dap.nvim",
      opts = {},
    },
  },
  opts = function()
    local dap = require("dap")

    if not dap.adapters["php"] then
      require("dap").adapters["php"] = {
        type = "executable",
        command = "php-debug-adapter",
      }
    end
    if not dap.adapters["pwa-node"] then
      require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          -- 💀 Make sure to update this path to point to your installation
          args = {
            require("mason-registry").get_package("js-debug-adapter"):get_install_path()
              .. "/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }
    end
    if not dap.configurations["php"] then
      dap.configurations["php"] = {
        {
          name = "Listen for Xdebug",
          type = "php",
          request = "launch",
          port = 9003,
          pathMappings = {
            ["/var/www/html/"] = "${workspaceFolder}",
          },
        },
      }
    end
    for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
      if not dap.configurations[language] then
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end
  end,
}
