return {
  "akinsho/bufferline.nvim",
  config = function()
    require("bufferline").setup({
      options = {
        max_name_length = 25,
        separator_style = "slope",
        show_buffer_close_icons = false,
        show_close_icon = false,
        modified_icon = "",
        custom_areas = {
          left = function()
            return {
              { text = "    ", fg = "#8fff6d" },
            }
          end,
        },
      },
    })
  end,
}
