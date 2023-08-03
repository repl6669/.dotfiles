local Util = require("lazyvim.util")

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      "rcarriga/nvim-notify",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("notify")
      end,
      keys = {
        -- stylua: ignore
        { "<leader>fh", function() Util.telescope("find_files", { hidden = true })() end, desc = "Find Hidden Files", },
        -- stylua: ignore
        { "<leader>fi", function() Util.telescope("find_files", { no_ignore = true })() end, desc = "Find Ignored Files", },
      },
    },
  },

  opts = {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "smart" },
      mappings = {
        i = {
          ["<C-t>"] = function(...)
            return require("trouble.providers.telescope").open_with_trouble(...)
          end,
          ["<A-†>"] = function(...)
            return require("trouble.providers.telescope").open_selected_with_trouble(...)
          end,
          ["<A-i>"] = function()
            Util.telescope("find_files", { no_ignore = true })()
          end,
          ["<A-˙>"] = function()
            Util.telescope("find_files", { hidden = true })()
          end,
          ["<C-Down>"] = function(...)
            return require("telescope.actions").cycle_history_next(...)
          end,
          ["<C-Up>"] = function(...)
            return require("telescope.actions").cycle_history_prev(...)
          end,
          ["<C-f>"] = function(...)
            return require("telescope.actions").preview_scrolling_down(...)
          end,
          ["<C-b>"] = function(...)
            return require("telescope.actions").preview_scrolling_up(...)
          end,
          ["<C-n>"] = function(...)
            return require("telescope.actions").cycle_history_next(...)
          end,
          ["<C-p>"] = function(...)
            return require("telescope.actions").cycle_history_prev(...)
          end,
          ["<C-j>"] = function(...)
            return require("telescope.actions").move_selection_next(...)
          end,
          ["<C-k>"] = function(...)
            return require("telescope.actions").move_selection_previous(...)
          end,
        },

        n = {
          ["p"] = function(...)
            return require("telescope.actions").close(...)
          end,
          ["?"] = function(...)
            return require("telescope.actions").which_key(...)
          end,
          ["t"] = function(...)
            return require("trouble.providers.telescope").open_selected_with_trouble(...)
          end,
        },
      },
    },
  },
}
-- ["<C-n>"] = actions.cycle_history_next,
-- ["<C-p>"] = actions.cycle_history_prev,
--
-- ["<C-j>"] = actions.move_selection_next,
-- ["<C-k>"] = actions.move_selection_previous,
--
-- ["<C-c>"] = actions.close,
--
-- ["<Down>"] = actions.move_selection_next,
-- ["<Up>"] = actions.move_selection_previous,
--
-- ["<CR>"] = actions.select_default,
-- ["<C-x>"] = actions.select_horizontal,
-- ["<C-v>"] = actions.select_vertical,
-- ["<C-t>"] = actions.select_tab,
--
-- ["<C-u>"] = actions.preview_scrolling_up,
-- ["<C-d>"] = actions.preview_scrolling_down,
--
-- ["<PageUp>"] = actions.results_scrolling_up,
-- ["<PageDown>"] = actions.results_scrolling_down,
--
-- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
-- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
-- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
-- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
-- ["<C-l>"] = actions.complete_tag,
-- ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
