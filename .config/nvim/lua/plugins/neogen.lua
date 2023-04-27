return {
  "danymat/neogen",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    -- stylua: ignore
    { "<leader>af", function () require('neogen').generate({ type = 'func' }) end, desc = "Generate function annotations" },
    -- stylua: ignore
    { "<leader>at", function () require('neogen').generate({ type = 'type' }) end, desc = "Generate type annotations" },
    -- stylua: ignore
    { "<leader>ac", function () require('neogen').generate({ type = 'class' }) end, desc = "Generate class annotations" },
  },
  config = function()
    require("neogen").setup({
      enabled = true,
      snippet_engine = "luasnip",
    })
  end,
}
