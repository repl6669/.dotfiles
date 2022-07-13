local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
    return
end

-- local trouble_status_ok, trouble = pcall(require, "trouble.providers.telescope")
-- if not trouble_status_ok then
--     return
-- end

telescope.load_extension("media_files")

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
-- local previewers = require "telescope.previewers"

telescope.setup({
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
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            filetypes = { "png", "webp", "jpg", "jpeg", "svg" },
            find_cmd = "rg", -- find command (defaults to `fd`)
        },
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
    },
})

vim.lsp.handlers["textDocument/references"] = builtin.lsp_references
vim.lsp.handlers["textDocument/definition"] = builtin.lsp_definitions
vim.lsp.handlers["textDocument/inplementation"] = builtin.lsp_implementations
vim.lsp.handlers["textDocument/typeDefinition"] = builtin.lsp_type_definitions

keymap("n", "<Leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<Leader>fhf", "<cmd>Telescope find_files hidden=true<cr>", opts)
keymap("n", "<Leader>fr", "<cmd>Telescope lsp_document_symbols<cr>", opts)
keymap("n", "<Leader>fg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<Leader>fb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<Leader>fh", "<cmd>Telescope help_tags<cr>", opts)
keymap("n", "<Leader>fd", "<cmd>Telescope diagnostics<cr>", opts)

telescope.load_extension("lazygit")
telescope.load_extension("fzf")
telescope.load_extension("ui-select")
telescope.load_extension('projects')
-- telescope.load_extension("session-lens")
