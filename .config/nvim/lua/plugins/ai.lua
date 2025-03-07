return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    build = "make", -- If you want to build from source then do `make BUILD_FROM_SOURCE=true`
    opts = function(_, opts)
      require("avante.providers")

      -- Ollama for Avante
      -- Ollama API Documentation https://github.com/ollama/ollama/blob/main/docs/api.md#generate-a-completion

      local role_map = {
        user = "user",
        assistant = "assistant",
        system = "system",
        tool = "tool",
      }

      ---@type fun(opts: AvanteProvider, prompt_opts: AvantePromptOptions): {}
      local parse_messages = function(opts, prompt_opts)
        local messages = {}
        local has_images = prompt_opts.image_paths and #prompt_opts.image_paths > 0
        -- Ensure opts.messages is always a table
        local msg_list = prompt_opts.messages or {}
        -- Convert Avante messages to Ollama format
        for _, msg in ipairs(msg_list) do
          local role = role_map[msg.role] or "assistant"
          local content = msg.content or "" -- Default content to empty string
          -- Handle multimodal content if images are present
          -- *Experimental* not tested
          if has_images and role == "user" then
            local message_content = {
              role = role,
              content = content,
              images = {},
            }
            for _, image_path in ipairs(prompt_opts.image_paths) do
              local base64_content = vim.fn.system(string.format("base64 -w 0 %s", image_path)):gsub("\n", "")
              table.insert(message_content.images, "data:image/png;base64," .. base64_content)
            end
            table.insert(messages, message_content)
          else
            table.insert(messages, {
              role = role,
              content = content,
            })
          end
        end
        return messages
      end

      ---@type fun(opts: AvanteProvider, code_opts: AvantePromptOptions): AvanteCurlOutput
      local function parse_curl_args(opts, code_opts)
        -- Create the messages array starting with the system message
        local messages = {
          { role = "system", content = code_opts.system_prompt },
        }
        -- Extend messages with the parsed conversation messages
        vim.list_extend(messages, opts:parse_messages(code_opts))
        -- Construct options separately for clarity
        local options = {
          num_ctx = (opts.options and opts.options.num_ctx) or 4096,
          temperature = code_opts.temperature or (opts.options and opts.options.temperature) or 0,
        }
        -- Check if tools table is empty
        local tools = (code_opts.tools and next(code_opts.tools)) and code_opts.tools or nil
        -- Return the final request table
        return {
          url = opts.endpoint .. "/api/chat",
          headers = {
            Accept = "application/json",
            ["Content-Type"] = "application/json",
          },
          body = {
            model = opts.model,
            messages = messages,
            options = options,
            -- tools = tools, -- Optional tool support
            stream = true, -- Keep streaming enabled
          },
        }
      end

      ---@type fun(data: string, handler_opts: AvanteHandlerOptions): nil
      local function parse_stream_data(data, handler_opts)
        local json_data = vim.fn.json_decode(data)
        if json_data then
          if json_data.done then
            handler_opts.on_stop({ reason = json_data.done_reason or "stop" })
            return
          end
          if json_data.message then
            local content = json_data.message.content
            if content and content ~= "" then
              handler_opts.on_chunk(content)
            end
          end
          -- Handle tool calls if present
          if json_data.tool_calls then
            for _, tool in ipairs(json_data.tool_calls) do
              handler_opts.on_tool(tool)
            end
          end
        end
      end

      return {
        provider = "openai", -- ollama | claude | openai | copilot
        auto_suggestions_provider = "copilot", -- ollama | claude | openai | copilot
        cursor_applying_provider = "groq", -- groq | fastapply

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
        },

        -- Experimental
        dual_boost = {
          enabled = false,
          first_provider = "openai",
          second_provider = "claude",
          prompt = "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
          timeout = 60000, -- Timeout in milliseconds
        },

        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-3-7-sonnet-latest",
          temperature = 0,
          max_tokens = 8192,
        },

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
          ---@type AvanteProvider
          ollama = {
            api_key_name = "",
            endpoint = "http://127.0.0.1:11434",
            model = "qwen2.5-coder:14b", -- Specify your model here
            parse_messages = parse_messages,
            parse_curl_args = parse_curl_args,
            parse_stream_data = parse_stream_data,
          },

          fastapply = {
            __inherited_from = "openai",
            api_key_name = "",
            endpoint = "http://localhost:11434/v1",
            model = "hf.co/Kortix/FastApply-7B-v1.0_GGUF:Q4_K_M",
          },

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
          --- @alias FileSelectorProvider "native" | "fzf" | "mini.pick" | "snacks" | "telescope" | string | fun(params: avante.file_selector.IParams|nil): nil
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
