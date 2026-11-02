---@module "lazy"
---@type LazySpec
return {
  -- Claude Code
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for git operations
    },
    config = function()
      require("claude-code").setup()
    end,
  },

  -- -- Copilot
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   opts = function()
  --     return {
  --       panel = {
  --         enabled = false,
  --       },
  --       suggestion = {
  --         enabled = false,
  --         auto_trigger = false,
  --         keymap = {
  --           accept_word = "<C-l>",
  --           accept_line = "<C-j>",
  --         },
  --       },
  --       workspace_folders = {
  --         os.getenv("HOME") .. "/Developer/php",
  --       },
  --       copilot_model = "",
  --       copilot_node_command = "/opt/homebrew/bin/node",
  --     }
  --   end,
  -- },

  {
    "ravitemer/mcphub.nvim", -- Manage MCP servers
    cmd = "MCPHub",
    build = "npm install -g mcp-hub@latest",
    config = function()
      require("mcphub").setup()
    end,
    dependencies = {
      {
        "nvim-lualine/lualine.nvim",
        -- WARNING: Deprecated
        -- opts = function(_, opts)
        --   table.insert(opts.sections.lualine_x, { require("mcphub.extensions.lualine") })
        -- end,
      },
    },
  },
}
