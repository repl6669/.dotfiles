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
    vim.lsp.config("phpantom_lsp", load_lsp_config("phpantom_lsp"))
    vim.lsp.config("emmet_language_server", load_lsp_config("emmet_language_server"))

    -- Enable LSP servers after configuration
    vim.lsp.enable("docker_compose_language_service")
    vim.lsp.enable("dockerls")
    vim.lsp.enable("vtsls")
    vim.lsp.enable("tailwindcss")
    vim.lsp.enable("vectorcode_server")
    vim.lsp.enable("volar")
    vim.lsp.enable("phpantom_lsp")
    vim.lsp.enable("emmet_language_server")
  end,
})

-- Once phpantom finishes indexing, re-pull diagnostics for its open buffers
-- (results pulled during indexing can be wrong and never get replaced).
vim.api.nvim_create_autocmd("LspProgress", {
  pattern = "end",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "phpantom_lsp" then
      return
    end
    local lsp_diag = require("vim.lsp.diagnostic")
    if not lsp_diag._refresh then
      return
    end
    for buf in pairs(client.attached_buffers) do
      lsp_diag._refresh(buf, client.id)
    end
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
    -- if client:supports_method("textDocument/inlayHint") then
    --   vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    -- end

    -- PHP-specific setup for phpantom
    if client.name == "phpantom_lsp" then
      -- Custom PHP-specific keymaps (optional)
      local opts = { buffer = bufnr, silent = true }

      -- phpantom advertises workspace diagnostics, so Neovim stops re-pulling
      -- per-buffer diagnostics after indexing and keeps showing stale results
      -- (e.g. "Unused import" for a trait that is used). Re-pull on enter/save.
      local function refresh()
        local ok, lsp_diag = pcall(require, "vim.lsp.diagnostic")
        if ok and lsp_diag._refresh and vim.api.nvim_buf_is_valid(bufnr) then
          lsp_diag._refresh(bufnr, client.id)
        end
      end
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
        group = vim.api.nvim_create_augroup("PhpantomDiagRefresh" .. bufnr, { clear = true }),
        buffer = bufnr,
        callback = refresh,
      })

      -- Import missing classes from anywhere in the file. phpantom only offers its
      -- actions with the cursor on an unresolved name, and "Import all missing
      -- classes" only when 2+ names have a single candidate. So: target the first
      -- unknown class ourselves, bulk-import if offered, else pick for that name.
      -- Press again to continue with the next ambiguous name.
      vim.keymap.set("n", "<leader>ci", function()
        local missing = vim.tbl_filter(function(d)
          return d.code == "unknown_class"
        end, vim.diagnostic.get(bufnr))
        if #missing == 0 then
          vim.notify("No missing classes", vim.log.levels.INFO, { title = "phpantom" })
          return
        end
        table.sort(missing, function(a, b)
          return a.lnum < b.lnum or (a.lnum == b.lnum and a.col < b.col)
        end)
        local d = missing[1]
        local range = { start = { d.lnum + 1, d.col }, ["end"] = { d.lnum + 1, d.col } }

        local params = {
          textDocument = vim.lsp.util.make_text_document_params(bufnr),
          range = {
            start = { line = d.lnum, character = d.col },
            ["end"] = { line = d.lnum, character = d.col },
          },
          context = { diagnostics = {} },
        }
        client:request("textDocument/codeAction", params, function(_, actions)
          local has_bulk = vim.iter(actions or {}):any(function(a)
            return a.title == "Import all missing classes"
          end)
          vim.lsp.buf.code_action({
            apply = true, -- auto-applies when exactly one action matches
            range = range,
            filter = function(a)
              if has_bulk then
                return a.title == "Import all missing classes"
              end
              return vim.startswith(a.title, "Import ")
            end,
          })
        end, bufnr)
      end, vim.tbl_extend("force", opts, { desc = "Import missing classes" }))

      -- These keymaps complement the phpactor RPC commands (lua/utils/phpactor.lua)
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
