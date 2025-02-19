local float = {
  style = "minimal",
  border = "rounded",
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float)

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "antosha417/nvim-lsp-file-operations",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-neo-tree/neo-tree.nvim",
      },
      config = function()
        require("lsp-file-operations").setup()
      end,
    },
  },
  config = function()
    ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
    local progress = vim.defaulttable()
    vim.api.nvim_create_autocmd("LspProgress", {
      ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= "table" then
          return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
          if i == #p + 1 or p[i].token == ev.data.params.token then
            p[i] = {
              token = ev.data.params.token,
              msg = ("[%3d%%] %s%s"):format(
                value.kind == "end" and 100 or value.percentage or 100,
                value.title or "",
                value.message and (" **%s**"):format(value.message) or ""
              ),
              done = value.kind == "end",
            }
            break
          end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
          return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(table.concat(msg, "\n"), "info", {
          id = "lsp_progress",
          title = client.name,
          opts = function(notif)
            notif.icon = #progress[client.id] == 0 and " "
              or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          end,
        })
      end,
    })
  end,
  opts = {
    -- make sure mason installs the server
    servers = {
      docker_compose_language_service = {},
      dockerls = {},
      lua_ls = {},
      -- intelephense = {
      --   ---@type lspconfig.options.intelephense
      --   init_options = {
      --     licenseKey = "00TJPX959XHH6KQ",
      --     files = {
      --       maxSize = 10000000,
      --     },
      --   },
      -- },
      phpactor = {},
      emmet_language_server = {
        filetypes = {
          "css",
          "html",
          "xhtml",
          "xml",
          "javascript",
          "javascript.jsx",
          "javascriptreact",
          "json",
          "typescript",
          "typescript.tsx",
          "typescriptreact",
          "vue",
        },
        init_options = {
          showSuggestionsAsSnippets = true,
        },
      },
      vtsls = {
        on_attach = function(client)
          -- disable formatting, since we use prettier
          client.server_capabilities.documentFormattingProvider = false
        end,
        ---@diagnostic disable-next-line: missing-fields
        settings = {},
      },
      tailwindcss = {
        -- exclude a filetype from the default_config
        filetypes_exclude = { "php", "md", "markdown" },
        -- add additional filetypes to the default_config
        filetypes_include = {},
        -- to fully override the default_config, change the below
        -- filetypes = {}
      },
      volar = {
        filetypes = {
          "javascript",
          "javascript.jsx",
          "javascriptreact",
          "json",
          "typescript",
          "typescript.tsx",
          "typescriptreact",
          "vue",
        },
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
        on_attach = function(client)
          -- disable formatting, since we use prettier
          client.server_capabilities.documentFormattingProvider = false
        end,
      },
    },
  },
}
