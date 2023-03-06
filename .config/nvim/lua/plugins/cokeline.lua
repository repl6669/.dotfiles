return {
  "noib3/nvim-cokeline",
  config = function()
    local get_hex = require("cokeline/utils").get_hex

    require("cokeline").setup({
      default_hl = {
        fg = function(buffer)
          return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg")
        end,
        bg = get_hex("ColorColumn", "bg"),
      },

      components = {
        {
          text = " ",
          bg = get_hex("Normal", "bg"),
        },
        {
          text = "",
          fg = get_hex("ColorColumn", "bg"),
          bg = get_hex("Normal", "bg"),
        },
        {
          text = function(buffer)
            return buffer.devicon.icon
          end,
          fg = function(buffer)
            return buffer.devicon.color
          end,
        },
        {
          text = " ",
        },
        {
          text = function(buffer)
            return buffer.filename .. " "
          end,
          style = function(buffer)
            return buffer.is_focused and "bold" and "italic" or nil
          end,
        },
        {
          text = "",
          fg = get_hex("ColorColumn", "bg"),
          bg = get_hex("Normal", "bg"),
        },
      },
    })
  end,
}
