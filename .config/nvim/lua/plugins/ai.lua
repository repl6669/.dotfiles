---@module "lazy"
---@type LazySpec
return {
  -- Pi (coding agent)
  {
    "carderne/pi-nvim",
    cmd = { "Pi", "PiSend", "PiSendFile", "PiSendSelection", "PiSendBuffer", "PiPing", "PiSessions" },
    keys = {
      { "<Leader>ai", "<cmd>Pi<CR>", desc = "Send to pi", mode = "n" },
      { "<Leader>ai", "<cmd>Pi<CR>", desc = "Send to pi (selection)", mode = "v" },
      { "<Leader>ap", "<cmd>PiSend<CR>", desc = "Send prompt to Pi", mode = "n" },
      { "<Leader>af", "<cmd>PiSendFile<CR>", desc = "Send file to Pi", mode = "n" },
      { "<Leader>as", "<cmd>PiSendSelection<CR>", desc = "Send selection to Pi", mode = "v" },
      { "<Leader>ab", "<cmd>PiSendBuffer<CR>", desc = "Send buffer to Pi", mode = "n" },
      { "<Leader>ag", "<cmd>PiPing<CR>", desc = "Ping Pi", mode = "n" },
      { "<Leader>ao", "<cmd>PiSessions<CR>", desc = "Pi sessions", mode = "n" },
    },
    config = function()
      require("pi-nvim").setup()
    end,
  },

  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = function()
      return {
        panel = {
          enabled = false,
        },
        suggestion = {
          enabled = false,
          auto_trigger = false,
          keymap = {
            accept_word = "<C-l>",
            accept_line = "<C-j>",
          },
        },
        workspace_folders = {
          os.getenv("HOME") .. "/Developer/php",
        },
        copilot_model = "",
        copilot_node_command = "/opt/homebrew/bin/node",
      }
    end,
  },
}
