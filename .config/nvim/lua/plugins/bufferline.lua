return {
  "akinsho/bufferline.nvim",
  config = function()
    local palette = require("rose-pine.palette")

    require("bufferline").setup({
      highlights = {
        buffer_visible = {
          fg = palette.subtle,
          bg = palette.base,
        },
        buffer_selected = {
          fg = palette.text,
          bg = palette.surface,
          bold = true,
          italic = true,
        },
      },
      options = {
        indicator = {
          icon = "", -- this should be omitted if indicator style is not 'icon'
          style = "underline",
        },
        max_name_length = 25,
        separator_style = "thin",
        show_buffer_close_icons = false,
        show_close_icon = false,
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
