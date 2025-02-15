return {
  "willothy/nvim-cokeline",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for v0.4.0+
  },
  config = function()
    local colors = require("catppuccin.palettes").get_palette("mocha")
    local mappings = require("cokeline.mappings")

    local comments_fg = colors.overlay0
    local errors_fg = colors.red
    local warnings_fg = colors.yellow
    local info_fg = colors.sky
    local hints_fg = colors.teal

    local text = colors.subtext0
    local highligted_text = colors.peach
    local transparent = colors.base
    local background = colors.mantle

    local red = colors.red
    local yellow = colors.yellow

    local components = {
      space = {
        text = " ",
        bg = transparent,
        truncation = { priority = 1 },
      },
      left_separator = {
        text = "",
        fg = background,
        bg = transparent,
        truncation = { priority = 1 },
      },
      icon = {
        text = function(buffer)
          return (mappings.is_picking_focus() or mappings.is_picking_close()) and buffer.pick_letter .. " "
            or buffer.devicon.icon
        end,
        fg = function(buffer)
          return (mappings.is_picking_focus() and yellow)
            or (mappings.is_picking_close() and red)
            or buffer.devicon.color
        end,
        style = function(_)
          return (mappings.is_picking_focus() or mappings.is_picking_close()) and "italic,bold" or nil
        end,
        truncation = { priority = 1 },
      },
      index = {
        text = function(buffer)
          return buffer.index .. ": "
        end,
        truncation = { priority = 1 },
      },
      unique_prefix = {
        text = function(buffer)
          return buffer.unique_prefix
        end,
        fg = comments_fg,
        style = "italic",
        truncation = {
          priority = 3,
          direction = "left",
        },
      },
      filename = {
        text = function(buffer)
          return buffer.filename
        end,
        style = function(buffer)
          return ((buffer.is_focused and buffer.diagnostics.errors ~= 0) and "bold,underline")
            or (buffer.is_focused and "bold,italic")
            or (buffer.diagnostics.errors ~= 0 and "underline")
            or nil
        end,
        truncation = {
          priority = 2,
          direction = "left",
        },
      },
      diagnostics = {
        text = function(buffer)
          return (buffer.diagnostics.errors ~= 0 and "  " .. buffer.diagnostics.errors)
            or (buffer.diagnostics.warnings ~= 0 and "  " .. buffer.diagnostics.warnings)
            or (buffer.diagnostics.infos ~= 0 and "  " .. buffer.diagnostics.infos)
            or (buffer.diagnostics.hints ~= 0 and " 󰌵 " .. buffer.diagnostics.hints)
            or ""
        end,
        fg = function(buffer)
          return (buffer.diagnostics.errors ~= 0 and errors_fg)
            or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
            or (buffer.diagnostics.infos ~= 0 and info_fg)
            or (buffer.diagnostics.hints ~= 0 and hints_fg)
            or nil
        end,
        truncation = { priority = 1 },
      },
      unsaved = {
        text = function(buffer)
          return buffer.is_modified and " ●" or ""
        end,
        fg = function(buffer)
          return buffer.is_modified and yellow
        end,
        truncation = { priority = 1 },
      },
      right_separator = {
        text = "",
        fg = background,
        bg = transparent,
        truncation = { priority = 1 },
      },
    }
    require("cokeline").setup({
      show_if_buffers_are_at_least = 2,
      buffers = {
        -- filter_valid = function(buffer) return buffer.type ~= 'terminal' end,
        -- filter_visible = function(buffer) return buffer.type ~= 'terminal' end,
        -- new_buffers_position = "next",
      },
      rendering = {
        max_buffer_width = 32,
      },
      default_hl = {
        fg = function(buffer)
          return buffer.is_focused and highligted_text or text
        end,
        bg = background,
      },
      fill_hl = "Normal",
      sidebar = {
        filetype = { "neo-tree" },
        components = {
          {
            text = function(buf)
              return " Neotree"
            end,
            bg = transparent,
            bold = true,
          },
        },
      },
      components = {
        components.space,
        components.left_separator,
        components.icon,
        components.unique_prefix,
        components.filename,
        components.diagnostics,
        components.unsaved,
        components.right_separator,
      },
    })

    vim.keymap.set("n", "<S-h>", "<Plug>(cokeline-focus-prev)", { silent = true, desc = "Focus Previous Buffer" })
    vim.keymap.set("n", "<S-l>", "<Plug>(cokeline-focus-next)", { silent = true, desc = "Focus Next Buffer" })
    vim.keymap.set("n", "<Leader>bp", "<Plug>(cokeline-pick-focus)", { silent = true, desc = "Pick a Buffer" })
    vim.keymap.set("n", "<Leader>bc", "<Plug>(cokeline-pick-close)", { silent = true, desc = "Pick a Buffer to Close" })
  end,
}
