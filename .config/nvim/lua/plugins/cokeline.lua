return {
  "willothy/nvim-cokeline",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for v0.4.0+
  },
  config = function()
    local palette = require("repl69.palette")
    local mappings = require("cokeline.mappings")

    local icons = {
      error = LazyVim.config.icons.diagnostics.Error,
      warn = LazyVim.config.icons.diagnostics.Warn,
      hint = LazyVim.config.icons.diagnostics.Hint,
      info = LazyVim.config.icons.diagnostics.Info,
    }

    local colors = {
      text = palette.gray550,
      dimmed = palette.gray700,
      highlight = palette.gray150,
      error = palette.red,
      warning = palette.orange,
      info = palette.cyan,
      hint = palette.cyan,
      background = palette.gray925,
      transparent = palette.background,
    }

    local components = {
      space = {
        text = " ",
        bg = colors.transparent,
        truncation = { priority = 1 },
      },
      left_separator = {
        text = "",
        fg = colors.background,
        bg = colors.transparent,
        truncation = { priority = 1 },
      },
      icon = {
        text = function(buffer)
          return (mappings.is_picking_focus() or mappings.is_picking_close()) and buffer.pick_letter .. " "
            or buffer.devicon.icon
        end,
        fg = function(buffer)
          return (mappings.is_picking_focus() and colors.warning)
            or (mappings.is_picking_close() and colors.error)
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
        fg = colors.dimmed,
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
          return (buffer.diagnostics.errors ~= 0 and " " .. icons.error .. buffer.diagnostics.errors)
            or (buffer.diagnostics.warnings ~= 0 and " " .. icons.warn .. buffer.diagnostics.warnings)
            or (buffer.diagnostics.infos ~= 0 and " " .. icons.info .. buffer.diagnostics.infos)
            or (buffer.diagnostics.hints ~= 0 and " " .. icons.hint .. buffer.diagnostics.hints)
            or ""
        end,
        fg = function(buffer)
          return (buffer.diagnostics.errors ~= 0 and colors.error)
            or (buffer.diagnostics.warnings ~= 0 and colors.warning)
            or (buffer.diagnostics.infos ~= 0 and colors.info)
            or (buffer.diagnostics.hints ~= 0 and colors.hint)
            or nil
        end,
        truncation = { priority = 1 },
      },
      unsaved = {
        text = function(buffer)
          return buffer.is_modified and " ●" or ""
        end,
        fg = function(buffer)
          return buffer.is_modified and colors.warning
        end,
        truncation = { priority = 1 },
      },
      right_separator = {
        text = "",
        fg = colors.background,
        bg = colors.transparent,
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
          return buffer.is_focused and colors.highlight or colors.text
        end,
        bg = colors.background,
      },
      fill_hl = "Normal",
      sidebar = {
        filetype = { "neo-tree" },
        components = {
          {
            text = function(buf)
              return " Neotree"
            end,
            bg = colors.transparent,
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
