return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    {
      "linrongbin16/lsp-progress.nvim",
      config = function()
        local api = require("lsp-progress.api")

        require("lsp-progress").setup({
          format = function(client_messages)
            -- icon: nf-fa-gear \uf013
            local sign = " LSP"
            if #client_messages > 0 then
              return sign .. " " .. table.concat(client_messages, " ")
            end
            if #api.lsp_clients() > 0 then
              return sign
            end
            return ""
          end,
        })

        vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
        vim.api.nvim_create_autocmd("User", {
          group = "lualine_augroup",
          pattern = "LspProgressStatusUpdated",
          callback = require("lualine").refresh,
        })
      end,
    },
  },
  optional = true,
  event = "VeryLazy",
  opts = function(_, opts)
    -- Add LSP progress
    table.insert(opts.sections.lualine_x, 1, {
      function()
        -- invoke `progress` here.
        return require("lsp-progress").progress()
      end,
    })
  end,
}
