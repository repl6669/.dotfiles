---@module "lazy"
---@type LazySpec
return {
  -- Pi (coding agent)
  {
    "pablopunk/pi.nvim",
    cmd = { "PiAsk", "PiAskSelection", "PiCancel", "PiLog" },
    keys = {
      { "<Leader>ai", "<cmd>PiAsk<CR>", desc = "Ask pi", mode = "n" },
      { "<Leader>ai", "<cmd>PiAskSelection<CR>", desc = "Ask pi (selection)", mode = "v" },
    },
    opts = {
      provider = "github-copilot",
      model = "claude-opus-4.6",
    },
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
