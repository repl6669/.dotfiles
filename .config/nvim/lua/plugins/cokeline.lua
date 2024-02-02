return {
  "willothy/nvim-cokeline",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for v0.4.0+
  },
  config = function()
    local get_hex = require("cokeline.hlgroups").get_hl_attr
    local mappings = require("cokeline.mappings")

    local red = vim.g.terminal_color_1
    local yellow = vim.g.terminal_color_3

    local comments_fg = get_hex("Comment", "fg")
    local errors_fg = get_hex("DiagnosticError", "fg")
    local warnings_fg = get_hex("DiagnosticWarn", "fg")

    local p = require("rose-pine.palette")
    local rose_pine_config = require("rose-pine.config")

    local bg_base = p.base
    if rose_pine_config.options.styles.transparency then
      bg_base = "NONE"
    end

    local bg_hl = "NONE"
    local transparent_bg = bg_base
    local bg = nil

    local inactive_fg = p.subtle
    local inactive_bg = bg

    local active_fg = p.gold
    local active_bg = bg

    local components = {
      space = {
        text = " ",
        bg = transparent_bg,
        truncation = { priority = 1 },
      },
      left_separator = {
        -- text = "",
        text = "",
        fg = function(buffer)
          return buffer.is_focused and active_bg or inactive_bg
        end,
        bg = transparent_bg,
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
          return (buffer.diagnostics.errors ~= 0 and "  " .. buffer.diagnostics.errors)
            or (buffer.diagnostics.warnings ~= 0 and "  " .. buffer.diagnostics.warnings)
            or ""
        end,
        fg = function(buffer)
          return (buffer.diagnostics.errors ~= 0 and errors_fg)
            or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
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
        -- text = "",
        text = "",
        fg = function(buffer)
          return buffer.is_focused and active_bg or inactive_bg
        end,
        bg = transparent_bg,
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
          return buffer.is_focused and active_fg or inactive_fg
        end,
        bg = function(buffer)
          return buffer.is_focused and active_bg or inactive_bg
        end,
        italic = function(buffer)
          return buffer.is_focused
        end,
      },
      fill_hl = bg_hl,
      sidebar = {
        filetype = { "neo-tree" },
        components = {
          {
            text = function(buf)
              return " Neotree"
            end,
            bg = transparent_bg,
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
