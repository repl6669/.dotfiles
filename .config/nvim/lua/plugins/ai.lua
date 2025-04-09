return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    build = "make", -- If you want to build from source then do `make BUILD_FROM_SOURCE=true`
    opts = function(_, opts)
      return {
        ---@type ProviderName
        provider = "claude",
        auto_suggestions_provider = "copilot", -- ollama | claude | openai | copilot
        cursor_applying_provider = "groq", -- groq

        web_search_engine = {
          provider = "tavily", -- tavily, serpapi, searchapi or google
        },

        behaviour = {
          auto_suggestions = false, -- Experimental stage
          auto_set_highlight_group = true,
          auto_set_keymaps = true,
          auto_apply_diff_after_generation = false,
          support_paste_from_clipboard = false,
          minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
          enable_token_counting = true, -- Whether to enable token counting. Default to true.
          enable_cursor_planning_mode = false,
          use_cwd_as_project_root = true,
        },

        -- Experimental
        dual_boost = {
          enabled = false,
          first_provider = "openai",
          second_provider = "claude",
          prompt = "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
          timeout = 60000, -- Timeout in milliseconds
        },

        -- claude = {
        --   endpoint = "https://api.anthropic.com",
        --   model = "claude-3-5-sonnet-latest",
        --   temperature = 0,
        --   max_tokens = 8192,
        -- },

        copilot = {
          model = "claude-3.7-sonnet",
          temperature = 0,
          max_tokens = 8192,
        },

        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
          timeout = 30000, -- timeout in milliseconds
          temperature = 0, -- adjust if needed
          max_tokens = 4096,
        },

        vendors = {
          groq = {
            __inherited_from = "openai",
            api_key_name = "GROQ_API_KEY",
            endpoint = "https://api.groq.com/openai/v1/",
            model = "llama-3.3-70b-versatile",
            max_tokens = 32768, -- increase this value, otherwise it will stop generating halfway
          },

          --   deepseek = {
          --     __inherited_from = "openai",
          --     api_key_name = "DEEPSEEK_API_KEY",
          --     endpoint = "https://api.deepseek.com",
          --     model = "deepseek-coder",
          --   },
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
      }
    end,

    dependencies = {
      {
        "stevearc/dressing.nvim",
        lazy = true,
        opts = {
          input = { enabled = false },
          select = { enabled = false },
        },
      },
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
      copilot_node_command = "/opt/homebrew/bin/node",
    },
  },
}
