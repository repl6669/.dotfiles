return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      theme = "rose-pine",
      globalstatus = true,
      disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
  },
}
