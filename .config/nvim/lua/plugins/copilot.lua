return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  build = ":Copilot auth",
  opts = {
    panel = {
      enabled = false,
      auto_refresh = false,
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<CR>",
        refresh = "gr",
        open = "<D-CR>",
      },
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 50,
      keymap = {
        accept = "<D-l>",
        accept_word = false,
        accept_line = false,
        prev = "<D-[>",
        next = "<D-]>",
        dismiss = "<C-]>",
      },
    },
    filetypes = {
      markdown = true,
      help = true,
    },
    copilot_node_command = "/opt/homebrew/bin/node",
  },
}
