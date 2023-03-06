return {
  "noib3/nvim-cokeline",
  config = function()
    local get_hex = require("cokeline/utils").get_hex
    local is_picking_focus = require("cokeline/mappings").is_picking_focus
    local is_picking_close = require("cokeline/mappings").is_picking_close

    local red = vim.g.terminal_color_1
    local yellow = vim.g.terminal_color_3

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
            return (is_picking_focus() or is_picking_close()) and buffer.pick_letter .. " " or buffer.devicon.icon
          end,
          fg = function(buffer)
            return (is_picking_focus() and yellow) or (is_picking_close() and red) or buffer.devicon.color
          end,
          style = function(_)
            return (is_picking_focus() or is_picking_close()) and "italic,bold" or nil
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

    vim.keymap.set("n", "<Leader>bp", "<Plug>(cokeline-pick-focus)", { silent = true, desc = "Pick a Buffer" })
    vim.keymap.set("n", "<Leader>bc", "<Plug>(cokeline-pick-close)", { silent = true, desc = "Pick a Buffer to Close" })
  end,
}
