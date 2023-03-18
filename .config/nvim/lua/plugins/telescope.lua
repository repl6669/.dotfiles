local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local previewers = require("telescope.previewers")

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  keys = {
    { "<leader>fr", ":Telescope lsp_document_symbols<cr>", desc = "Find Document Symbols" },
  },
  opts = {
    defaults = {
      path_display = { "smart" },
      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,

          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,

          ["<C-c>"] = actions.close,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,

          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["<C-l>"] = actions.complete_tag,
          ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>

          -- ["<C-t>"] = trouble.open_with_trouble, -- Open with Trouble
        },

        n = {
          ["<esc>"] = actions.close,
          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["H"] = actions.move_to_top,
          ["M"] = actions.move_to_middle,
          ["L"] = actions.move_to_bottom,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["gg"] = actions.move_to_top,
          ["G"] = actions.move_to_bottom,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["?"] = actions.which_key,

          -- ["<C-t>"] = trouble.open_with_trouble, -- Open with Trouble
        },
      },
    },
  },
}

-- vim.keymap.set("n", "<Leader><Leader>", "<cmd>Telescope find_files<cr>", opts)
-- vim.keymap.set("n", "<Leader>fhf", "<cmd>Telescope find_files hidden=true<cr>", opts)
-- vim.keymap.set("n", "<Leader>fr", "<cmd>Telescope lsp_document_symbols<cr>", opts)
-- vim.keymap.set("n", "<Leader>fg", "<cmd>Telescope live_grep<cr>", opts)
-- vim.keymap.set("n", "<Leader>fb", "<cmd>Telescope buffers<cr>", opts)
-- vim.keymap.set("n", "<Leader>fh", "<cmd>Telescope help_tags<cr>", opts)
-- vim.keymap.set("n", "<Leader>fd", "<cmd>Telescope diagnostics<cr>", opts)
-- vim.keymap.set("n", "<Leader>fs", "<cmd>Telescope session-lens search_session<cr>", opts)
-- vim.keymap.set("n", "<Leader>ft", "<cmd>TodoTelescope<cr>", opts)
-- vim.keymap.set("n", "<Leader>ff", "<cmd>Telescope file_browser<cr>", opts)
