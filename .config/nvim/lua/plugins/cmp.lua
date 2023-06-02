return {
  "hrsh7th/nvim-cmp",

  dependencies = {
    -- "f3fora/cmp-spell",
    -- "uga-rosa/cmp-dictionary",
    -- "amarakon/nvim-cmp-buffer-lines",
  },
  opts = function(_, opts)
    local cmp = require("cmp")
    local cmp_buffer = require("cmp_buffer")
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

    vim.list_extend(opts, {
      sorting = {
        comparators = {
          function(...)
            return cmp_buffer:compare_locality(...)
          end,
          -- The rest of your comparators...
        },
      },
    })

    if type(opts.sources) == "table" then
      vim.list_extend(opts.sources, {
        {
          name = "buffer",
          option = {
            keyword_length = 2,
            keyword_pattern = [[\k\+]],
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
          },
        },
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
