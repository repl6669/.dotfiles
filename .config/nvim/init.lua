require("config.lazy")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    -- Global LSP settings
    vim.lsp.config("*", {
      -- Global capabilities for all LSP servers
      capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        -- Add nvim-cmp capabilities if cmp_nvim_lsp is available (compat)
        (function()
          local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
          if ok and type(cmp_nvim_lsp.default_capabilities) == "function" then
            return cmp_nvim_lsp.default_capabilities()
          end
          return {}
        end)(),
        -- Add blink.cmp capabilities if available
        (function()
          local ok, blink = pcall(require, "blink.cmp")
          if ok and type(blink.get_lsp_capabilities) == "function" then
            return blink.get_lsp_capabilities()
          end
          return {}
        end)()
      ),
    })

    -- Configure LSP diagnostics (equivalent to your old opts.diagnostics)
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = false,
    })

    -- Configure individual LSP servers using vim.lsp.config()
    -- Helper function to load LSP config files
    local function load_lsp_config(name)
      local config_path = vim.fn.stdpath("config") .. "/lsp/" .. name .. ".lua"
      if vim.fn.filereadable(config_path) == 1 then
        return dofile(config_path)
      else
        vim.notify("LSP config not found: " .. config_path, vim.log.levels.ERROR)
        return {}
      end
    end

    -- Configure individual LSP servers using vim.lsp.config()
    vim.lsp.config("docker_compose_language_service", load_lsp_config("docker_compose_language_service"))
    vim.lsp.config("dockerls", load_lsp_config("dockerls"))
    vim.lsp.config("vtsls", load_lsp_config("vtsls"))
    vim.lsp.config("tailwindcss", load_lsp_config("tailwindcss"))
    vim.lsp.config("vectorcode_server", load_lsp_config("vectorcode_server"))
    vim.lsp.config("volar", load_lsp_config("volar"))
    vim.lsp.config("phpactor", load_lsp_config("phpactor"))
    vim.lsp.config("emmet_language_server", load_lsp_config("emmet_language_server"))

    -- Enable LSP servers after configuration
    vim.lsp.enable("docker_compose_language_service")
    vim.lsp.enable("dockerls")
    vim.lsp.enable("vtsls")
    vim.lsp.enable("tailwindcss")
    vim.lsp.enable("vectorcode_server")
    vim.lsp.enable("volar")
    vim.lsp.enable("phpactor")
    vim.lsp.enable("emmet_language_server")
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf

    -- Enable completion if supported
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    end

    -- Enable inlay hints if supported
    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    -- PHP-specific setup for phpactor
    if client.name == "phpactor" then
      -- Custom PHP-specific keymaps (optional)
      local opts = { buffer = bufnr, silent = true }

      -- These keymaps complement the phpactor.nvim plugin commands
      -- You can uncomment if you want LSP-specific bindings
      -- vim.keymap.set('n', '<leader>lpi', vim.lsp.buf.implementation, opts)
      -- vim.keymap.set('n', '<leader>lpr', vim.lsp.buf.references, opts)
      -- vim.keymap.set('n', '<leader>lps', vim.lsp.buf.document_symbol, opts)

      -- Disable semantic tokens if causing issues (uncomment if needed)
      -- client.server_capabilities.semanticTokensProvider = nil
    end
    -- Auto-format on save for certain filetypes (optional)
    -- Uncomment if you want auto-formatting
    -- if client:supports_method('textDocument/formatting') then
    --   vim.api.nvim_create_autocmd('BufWritePre', {
    --     buffer = bufnr,
    --     callback = function()
    --       vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
    --     end,
    --   })
    -- end
  end,
})
