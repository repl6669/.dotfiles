local Util = require("lazyvim.util")
local actions = require("telescope.actions")
local trouble = require("trouble.sources.telescope")

local find_files_no_ignore = function()
  local action_state = require("telescope.actions.state")
  local line = action_state.get_current_line()
  Util.telescope("find_files", { no_ignore = true, default_text = line })()
end
local find_files_with_hidden = function()
  local action_state = require("telescope.actions.state")
  local line = action_state.get_current_line()
  Util.telescope("find_files", { hidden = true, default_text = line })()
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "rcarriga/nvim-notify",
  },
  keys = {
    { "<leader>fh", find_files_with_hidden, desc = "Find Hidden Files" },
    { "<leader>fi", find_files_no_ignore, desc = "Find Ignored Files" },
  },
  opts = {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "smart" },
      winblend = 0,
      mappings = {
        i = {
          ["<c-n>"] = actions.cycle_history_next,
          ["<c-p>"] = actions.cycle_history_prev,
          ["<c-j>"] = actions.preview_scrolling_down,
          ["<c-k>"] = actions.preview_scrolling_up,
        },
        n = {
          ["?"] = actions.which_key,
          ["t"] = trouble.open,
        },
      },
    },
  },
}
