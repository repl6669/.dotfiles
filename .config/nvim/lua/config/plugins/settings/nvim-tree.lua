local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        adaptive_size = true,
        mappings = {
            list = {
                { key = { "l", "<CR>", "o" }, action = "edit" },
                { key = "<C-e>", action = "edit_in_place" },
                { key = "O", action = "edit_no_picker" },
                { key = { "<C-]>" }, action = "cd" },
                { key = "<C-v>", action = "vsplit" },
                { key = "<C-x>", action = "split" },
                { key = "<C-t>", action = "tabnew" },
                { key = "<", action = "prev_sibling" },
                { key = ">", action = "next_sibling" },
                { key = "P", action = "parent_node" },
                { key = "h", action = "close_node" },
                { key = "<Tab>", action = "preview" },
                { key = "K", action = "first_sibling" },
                { key = "J", action = "last_sibling" },
                { key = "I", action = "toggle_git_ignored" },
                { key = "H", action = "toggle_dotfiles" },
                { key = "U", action = "toggle_custom" },
                { key = "R", action = "refresh" },
                { key = { "n", "N" }, action = "create" },
                { key = "d", action = "remove" },
                { key = "dd", action = "trash" },
                { key = { "M", "m", "r" }, action = "rename" },
                { key = "<C-r>", action = "full_rename" },
                { key = "x", action = "cut" },
                { key = "c", action = "copy" },
                { key = "p", action = "paste" },
                { key = "y", action = "copy_name" },
                { key = "Y", action = "copy_path" },
                { key = "gy", action = "copy_absolute_path" },
                { key = "[e", action = "prev_diag_item" },
                { key = "[c", action = "prev_git_item" },
                { key = "]e", action = "next_diag_item" },
                { key = "]c", action = "next_git_item" },
                { key = { "-", "<BS>" }, action = "dir_up" },
                { key = "s", action = "system_open" },
                { key = "f", action = "live_filter" },
                { key = "F", action = "clear_live_filter" },
                { key = "q", action = "close" },
                { key = "W", action = "collapse_all" },
                { key = "E", action = "expand_all" },
                { key = "S", action = "search_node" },
                { key = ".", action = "run_file_command" },
                { key = "<C-k>", action = "toggle_file_info" },
                { key = "g?", action = "toggle_help" },
            },
        },
    },
    renderer = {
        group_empty = true,
        icons = {
            glyphs = {
                folder = {
                    default = "",
                    open = "",
                    symlink = "",
                },
            },
        },
    },
    filters = {
        dotfiles = true,
    },
    git = {
        enable = false,
    },
    actions = {
        change_dir = {
            enable = false,
        },
        open_file = {
            quit_on_open = true,
        }
    }
})

keymap("n", "<Leader><Leader>", ":NvimTreeToggle .<CR>", opts)
