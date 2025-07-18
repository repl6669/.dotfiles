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
        -- Add nvim-cmp capabilities
        require("cmp_nvim_lsp").default_capabilities()
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

