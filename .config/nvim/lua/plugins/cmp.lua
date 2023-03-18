return {
  "hrsh7th/nvim-cmp",

  opts = function(_, opts)
    local cmp = require("cmp")

    if type(opts.sources) == "table" then
      vim.list_extend(opts.sources, {
        {
          name = "buffer",
          option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
          },
        },
      })
    end
  end,
}
