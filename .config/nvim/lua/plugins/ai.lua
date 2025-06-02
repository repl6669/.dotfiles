return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    build = "make", -- If you want to build from source then do `make BUILD_FROM_SOURCE=true`
    opts = function(_, opts)
      return {
        provider = "copilot",
        auto_suggestions_provider = "copilot", -- ollama | claude | openai | copilot
        cursor_applying_provider = nil, -- "groq", -- groq

        web_search_engine = {
          provider = "tavily", -- tavily, serpapi, searchapi or google
        },

        behaviour = {
          auto_focus_sidebar = true,
          auto_suggestions = false, -- Experimental stage
          auto_suggestions_respect_ignore = false,
          auto_set_highlight_group = true,
          auto_set_keymaps = true,
          auto_apply_diff_after_generation = false,
          jump_result_buffer_on_finish = false,
          support_paste_from_clipboard = false,
          minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
          enable_token_counting = true, -- Whether to enable token counting. Default to true.
          use_cwd_as_project_root = true,
          auto_focus_on_diff_view = false,
          enable_cursor_planning_mode = true,
          enable_claude_text_editor_tool_mode = true,
        },

        -- Experimental
        dual_boost = {
          enabled = false,
          first_provider = "openai",
          second_provider = "claude",
          prompt = "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
          timeout = 60000, -- Timeout in milliseconds
        },

        ---@type {[string]: AvanteProvider}
        providers = {
          ---@type AvanteSupportedProvider
          claude = {
            endpoint = "https://api.anthropic.com",
            model = "claude-3-7-sonnet-20250219",
            extra_request_body = {
              temperature = 0.75,
              max_tokens = 20480,
            },
          },
          ---@type AvanteSupportedProvider
          copilot = {
            endpoint = "https://api.githubcopilot.com",
            model = "claude-3.7-sonnet",
            allow_insecure = false,
            timeout = 30000,
            extra_request_body = {
              temperature = 0.75,
              max_tokens = 81920,
              max_completion_tokens = 81920,
              reasoning_effort = "high",
            },
          },
          ---@type AvanteSupportedProvider
          openai = {
            endpoint = "https://api.openai.com/v1",
            model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
            timeout = 30000, -- timeout in milliseconds
            extra_request_body = {
              temperature = 0.75,
              max_completion_tokens = 16384, -- Increase this to include reasoning tokens (for reasoning models)
              reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
            },
          },

          ---@type AvanteSupportedProvider
          groq = { -- define groq provider
            __inherited_from = "openai",
            api_key_name = "GROQ_API_KEY",
            endpoint = "https://api.groq.com/openai/v1/",
            model = "llama-3.3-70b-versatile",
            extra_request_body = {
              max_completion_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
            },
          },

          ---@type AvanteSupportedProvider
          ["claude-3-7-sonnet"] = {
            __inherited_from = "claude",
            model = "claude-3-7-sonnet-20250219",
            extra_request_body = {
              temperature = 1,
              max_tokens = 20480,
            },
          },

          ---@type AvanteSupportedProvider
          ["claude-3-5-sonnet"] = {
            __inherited_from = "claude",
            model = "claude-3-5-sonnet-20241022",
            extra_request_body = {
              temperature = 1,
              max_tokens = 4096,
            },
          },

          ---@type AvanteSupportedProvider
          ["deepseek-coder"] = {
            __inherited_from = "openai",
            api_key_name = "DEEPSEEK_API_KEY",
            endpoint = "https://api.deepseek.com",
            model = "deepseek-coder",
          },
        },

        disabled_tools = {
          "list_files", -- Built-in file operations
          "search_files",
          "read_file",
          "create_file",
          "rename_file",
          "delete_file",
          "create_dir",
          "rename_dir",
          "delete_dir",
          "bash", -- Built-in terminal access
        },

        file_selector = {
          --- @type FileSelectorProvider
          provider = "fzf",
          -- Options override for custom providers
          provider_opts = {},
        },

        mappings = {
          --- @class AvanteConflictMappings
          diff = {
            ours = "co",
            theirs = "ct",
            all_theirs = "ca",
            both = "cb",
            cursor = "cc",
            next = "]x",
            prev = "[x",
          },
          suggestion = {
            accept = "<D-l>",
            next = "<D-]>",
            prev = "<D-[>",
            dismiss = "<C-]>",
          },
          jump = {
            next = "]]",
            prev = "[[",
          },
          submit = {
            normal = "<CR>",
            insert = "<D-Enter>",
          },
          sidebar = {
            apply_all = "A",
            apply_cursor = "a",
            switch_windows = "<Tab>",
            reverse_switch_windows = "<S-Tab>",
          },
        },

        hints = { enabled = false },

        windows = {
          position = "right",
          width = 35, -- 35% of the width of the window
          sidebar_header = {
            enabled = false, -- true, false to enable/disable the header
            align = "left", -- left, center, right for title
            rounded = false,
          },
        },

        -- system_prompt as function ensures LLM always has latest MCP server state
        -- This is evaluated for every message, even in existing chats
        system_prompt = function()
          local hub = require("mcphub").get_hub_instance()
          return hub and hub:get_active_servers_prompt() or ""
        end,
        -- Using function prevents requiring mcphub before it's loaded
        custom_tools = function()
          return {
            require("mcphub.extensions.avante").mcp_tool(),
          }
        end,
      }
    end,

    dependencies = {
      -- {
      --   "stevearc/dressing.nvim",
      --   lazy = true,
      --   opts = {
      --     input = { enabled = false },
      --     select = { enabled = false },
      --   },
      -- },
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.icons",
      "hrsh7th/nvim-cmp", -- Autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- For file_selector provider fzf
      "zbirenbaum/copilot.lua", -- For providers='copilot'
      {
        -- Support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- Recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- Required for Windows users
            use_absolute_path = true,
          },
        },
      },
    },
  },

  {
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
      workspace_folders = {
        "/Users/theimer/Developer/php",
      },
      copilot_model = "",
      copilot_node_command = "/opt/homebrew/bin/node",
    },
  },

  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    cmd = "MCPHub", -- lazy load by default
    build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
    -- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
    config = function()
      require("mcphub").setup({
        auto_approve = true,
        extensions = {
          avante = {
            make_slash_commands = true, -- make /slash commands from MCP server prompts
          },
        },
      })
    end,
  },
}
