---@module "lazy"
---@type LazySpec
return {
  "folke/which-key.nvim",
  opts = {
    preset = "modern", -- modern | helix
    show_help = false,
    spec = {
      { "<leader>a", group = "+ai" },
      { "<leader>ag", group = "+ai/rag" },
      ["<leader>t"] = { name = "+test" },
      ["<leader>d"] = { name = "+debug" },
      ["<leader>cp"] = { name = "+php" },
      ["<leader>cpi"] = { name = "+php/import" },
      ["<leader>cpp"] = { name = "+php/phpstan" },
      ["<leader>cg"] = { name = "+chat-gpt" },
      ["<leader>o"] = { name = "+obsidian" },
      ["<leader>a"] = { name = "+annotations/docblocks" },
      ["<leader>p"] = { name = "+pomodoro" },
      ["<leader>g"] = { name = "+github" },
      ["<leader>m"] = { name = "+markdown" },
    },
  },
}
