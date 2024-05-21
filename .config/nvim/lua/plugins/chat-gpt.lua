-- ChatGPT
return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("chatgpt").setup({
      api_key_cmd = 'op read "op://Private/op54pbs2bcvrdekea3uqg4p62a/API key" --no-newline',
      -- edit_with_instructions = {
      --   keymaps = {
      --     close = "<C-c>",
      --     accept = "<C-y>",
      --     toggle_diff = "<C-d>",
      --     toggle_settings = "<C-o>",
      --     toggle_help = "<C-h>",
      --     cycle_windows = "<Tab>",
      --     use_output_as_input = "<C-i>",
      --   },
      -- },
      chat = {
        question_sign = "󰙃", -- 🙂
        answer_sign = "󱙺", -- 🤖
        sessions_window = {
          active_sign = "  ",
          inactive_sign = "  ",
          current_line_sign = "",
          border = {
            style = "rounded",
            text = {
              top = " Sessions ",
            },
          },
          win_options = {
            winhighlight = "Float:Float,FloatBorder:FloatBorder",
          },
        },
        --   keymaps = {
        --     close = "<C-c>",
        --     yank_last = "<C-y>",
        --     yank_last_code = "<C-k>",
        --     scroll_up = "<C-u>",
        --     scroll_down = "<C-d>",
        --     new_session = "<C-n>",
        --     cycle_windows = "<Tab>",
        --     cycle_modes = "<C-f>",
        --     next_message = "<C-j>",
        --     prev_message = "<C-k>",
        --     select_session = "<Space>",
        --     rename_session = "r",
        --     delete_session = "d",
        --     draft_message = "<C-r>",
        --     edit_message = "e",
        --     delete_message = "d",
        --     toggle_settings = "<C-o>",
        --     toggle_sessions = "<C-p>",
        --     toggle_help = "<C-h>",
        --     toggle_message_role = "<C-r>",
        --     toggle_system_role_open = "<C-s>",
        --     stop_generating = "<C-x>",
        --   },
      },
      popup_window = {
        win_options = {
          winhighlight = "Float:Float,FloatBorder:FloatBorder",
        },
      },
      system_window = {
        win_options = {
          winhighlight = "Float:Float,FloatBorder:FloatBorder",
        },
      },
      popup_input = {
        win_options = {
          winhighlight = "Float:Float,FloatBorder:FloatBorder",
        },
      },
      settings_window = {
        win_options = {
          winhighlight = "Float:Float,FloatBorder:FloatBorder",
        },
      },
      help_window = {
        win_options = {
          winhighlight = "Float:Float,FloatBorder:FloatBorder",
        },
      },
      openai_params = {
        model = "gpt-4-o",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 300,
        temperature = 0,
        top_p = 1,
        n = 1,
      },
      openai_edit_params = {
        model = "gpt-4o",
        frequency_penalty = 0,
        presence_penalty = 0,
        temperature = 0,
        top_p = 1,
        n = 1,
      },
    })
  end,
  keys = {
    { "<leader>cpic", ":PhpActor import_class<CR>", mode = { "n" }, desc = "Import Class" },
    { "<leader>cgc", "<cmd>ChatGPT<CR>", desc = "ChatGPT" },
    { "<leader>cge", "<cmd>ChatGPTEditWithInstruction<CR>", desc = "Edit with instruction", mode = { "n", "v" } },
    { "<leader>cgg", "<cmd>ChatGPTRun grammar_correction<CR>", desc = "Grammar Correction", mode = { "n", "v" } },
    { "<leader>cgt", "<cmd>ChatGPTRun translate<CR>", desc = "Translate", mode = { "n", "v" } },
    { "<leader>cgk", "<cmd>ChatGPTRun keywords<CR>", desc = "Keywords", mode = { "n", "v" } },
    { "<leader>cgd", "<cmd>ChatGPTRun docstring<CR>", desc = "Docstring", mode = { "n", "v" } },
    { "<leader>cga", "<cmd>ChatGPTRun add_tests<CR>", desc = "Add Tests", mode = { "n", "v" } },
    { "<leader>cgo", "<cmd>ChatGPTRun optimize_code<CR>", desc = "Optimize Code", mode = { "n", "v" } },
    { "<leader>cgs", "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize", mode = { "n", "v" } },
    { "<leader>cgf", "<cmd>ChatGPTRun fix_bugs<CR>", desc = "Fix Bugs", mode = { "n", "v" } },
    { "<leader>cgx", "<cmd>ChatGPTRun explain_code<CR>", desc = "Explain Code", mode = { "n", "v" } },
    { "<leader>cgr", "<cmd>ChatGPTRun roxygen_edit<CR>", desc = "Roxygen Edit", mode = { "n", "v" } },
    {
      "<leader>cgl",
      "<cmd>ChatGPTRun code_readability_analysis<CR>",
      desc = "Code Readability Analysis",
      mode = { "n", "v" },
    },
  },
}
