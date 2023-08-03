return {
  "hrsh7th/nvim-cmp",

  dependencies = {
    -- "f3fora/cmp-spell",
    -- "uga-rosa/cmp-dictionary",
    -- "amarakon/nvim-cmp-buffer-lines",
    {
      "tzachar/cmp-fuzzy-buffer",
      dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        "tzachar/fuzzy.nvim",
      },
    },
  },
  opts = function(_, opts)
    local cmp = require("cmp")
    -- local cmp_buffer = require("cmp_buffer")
    -- local dict = require("cmp_dictionary")

    -- dict.setup({
    --   -- The following are default values.
    --   exact = 2,
    --   first_case_insensitive = false,
    --   document = false,
    --   document_command = "wn %s -over",
    --   async = false,
    --   sqlite = false,
    --   max_items = -1,
    --   capacity = 5,
    --   debug = false,
    -- })
    --
    -- dict.switcher({
    --   spelllang = {
    --     en = "/Users/theimer/dict/en.dict",
    --     cs = "/Users/theimer/dict/cs.dict",
    --     de = "/Users/theimer/dict/de.dict",
    --   },
    -- })

    local compare = require("cmp.config.compare")

    cmp.setup.cmdline("/", {
      sources = cmp.config.sources({
        { name = "fuzzy_buffer" },
      }),
    })

    vim.list_extend(opts, {
      sorting = {
        comparators = {
          require("cmp_fuzzy_buffer.compare"),
          compare.offset,
          compare.exact,
          compare.score,
          compare.recently_used,
          compare.kind,
          compare.sort_text,
          compare.length,
          compare.order,
        },
      },
    })

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
        -- {
        --   name = "buffer",
        --   option = {
        --     get_bufnrs = function()
        --       local bufs = {}
        --       for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        --         local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
        --         if buftype ~= "nofile" and buftype ~= "prompt" then
        --           bufs[#bufs + 1] = buf
        --         end
        --       end
        --       return bufs
        --     end,
        --   },
        -- },
        -- {
        -- },
        -- {
        --   name = "buffer-lines",
        --   option = {},
        -- },
        -- {
        --   name = "dictionary",
        --   keyword_length = 4,
        -- },
        -- name = "spell",
        -- option = {
        --   keep_all_entries = false,
        --   enable_in_context = function()
        --     return true
        --   end,
        -- },
      })
    end
  end,
}
