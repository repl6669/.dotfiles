return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      -- theme = "catppuccin",
      theme = "rose-pine",
      globalstatus = true,
      disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
      component_separators = "",
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = {
        { "mode", separator = { left = "" } },
      },
      lualine_z = {
        {
          function()
            return " " .. os.date("%R")
          end,
          separator = { right = "" },
          left_padding = 2,
        },
      },
    },
  },
}
