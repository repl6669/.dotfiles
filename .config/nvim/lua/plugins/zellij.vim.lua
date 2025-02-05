if true then
  return {}
end

return {
  "https://github.com/fresh2dev/zellij.vim.git",
  lazy = false,
  keys = {
    { "<C-h>", ":ZellijNavigateLeft<CR>", mode = { "n" }, { noremap = true } },
    { "<C-j>", ":ZellijNavigateDown<CR>", mode = { "n", "i" }, { noremap = true } },
    { "<C-k>", ":ZellijNavigateUp<CR>", mode = { "n", "i" }, { noremap = true } },
    { "<C-l>", ":ZellijNavigateRight<CR>", mode = { "n", "i" }, { noremap = true } },
    { "<leader>zn", ":ZellijNewPane<CR>", mode = { "n" }, { noremap = true } },
    { "<M-f>", ":ZellijNewPane<CR>", mode = { "n", "i" }, { noremap = true } },
    { "<M-t>", ":ZellijNewPaneSplit<CR>", mode = { "n", "i" }, { noremap = true } },
    { "<M-v>", ":ZellijNewPaneVSplit<CR>", mode = { "n", "i" }, { noremap = true } },
  },
  config = function()
    -- Disable default mappings
    -- vim.g.zellij_navigator_no_default_mappings = 1

    -- Autocommand which names the current Zellij tab after Vim's current working directory
    vim.api.nvim_create_autocmd({ "DirChanged", "WinEnter", "BufEnter" }, {
      pattern = "*",
      callback = function()
        vim.fn.system('zellij action rename-tab "' .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. '"')
      end,
    })
  end,
}
