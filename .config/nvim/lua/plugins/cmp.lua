return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    {
      "tzachar/cmp-fuzzy-buffer",
      dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        { "tzachar/fuzzy.nvim" },
      },
    },
  },
  opts = function(_, opts)
    local cmp = require("cmp")

    cmp.setup.cmdline("/", {
      sources = cmp.config.sources({
        { name = "fuzzy_buffer" },
      }),
    })

    -- vim.list_extend(opts, {
    --   sorting = {
    --     comparators = {
    --       require("cmp_fuzzy_buffer.compare"),
    --       compare.offset,
    --       compare.exact,
    --       compare.score,
    --       compare.recently_used,
    --       compare.kind,
    --       compare.sort_text,
    --       compare.length,
    --       compare.order,
    --     },
    --   },
    -- })

    if type(opts.sources) == "table" then
      vim.list_extend(opts.sources, {
        name = "fuzzy_buffer",
        option = {
          max_matches = 5,
          get_bufnrs = function()
            local bufs = {}
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
              if buftype ~= "nofile" and buftype ~= "prompt" then
                bufs[#bufs + 1] = buf
              end
            end
            return bufs
          end,
        },
      })
    end
  end,
}
