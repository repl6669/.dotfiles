return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      theme = "repl69",
      globalstatus = true,
      disabled_filetypes = {
        statusline = {
          "dashboard",
          "lazy",
          "alpha",
          "snacks_dashboard",
        },
      },
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
    extensions = {
      "neo-tree",
      "lazy",
      "fzf",
    },
  },
}
