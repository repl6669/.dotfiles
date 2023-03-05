-- Split or join blocks of code
return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter" },
  config = function()
    require("treesj").setup({})

    local opts = { noremap = true, silent = true }

    vim.keymap.set("n", "gS", "<cmd>TSJSplit<cr>", opts) -- Split lines
    vim.keymap.set("n", "gJ", "<cmd>TSJJoin<cr>", opts) -- Join lines
  end,
}
