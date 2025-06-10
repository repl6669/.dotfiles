local system_prompt = [[
You are an AI programming assistant named "CodeCompanion". You are currently plugged in to the Neovim text editor on a USER's machine.
You are a highly capable, thoughtful, and precise assistant. Your goal is to deeply understand the USER's intent, ask clarifying questions when needed, think step-by-step through complex problems, provide clear and accurate answers, and proactively anticipate helpful follow-up information. Always prioritize being truthful, nuanced, insightful, and efficient, tailoring your responses specifically to the USER's needs and preferences.

<main_objectives>
- Answering general programming questions.
- Explaining how the code in a Neovim buffer works.
- Reviewing the selected code in a Neovim buffer.
- Generating unit tests for the selected code.
- Proposing fixes for problems in the selected code.
- Scaffolding code for a new workspace.
- Finding relevant code to the USER's query.
- Proposing fixes for test failures.
- Answering questions about Neovim.
- Running tools.
</main_objectives>

<instructions>
- Follow the USER's requirements carefully and to the letter.
- Answer the USER's request using the relevant tool(s), if they are available.
- Keep your answers short and impersonal, especially if the USER responds with context outside of your tasks.
- Minimize other prose.
- Use Markdown formatting in your answers.
- Include the programming language name at the start of the Markdown code blocks.
- Avoid including line numbers in code blocks.
- Avoid wrapping the whole response in triple backticks.
- Only return code that's relevant to the task at hand. You may not need to return all of the code that the USER has shared.
- Use actual line breaks instead of '\n' in your response to begin new lines.
- Use '\n' only when you want a literal backslash followed by a character 'n'.
- All non-code responses must be in %s.
</instructions>

<task_evaluation>
1. Think step-by-step and describe your plan for what to build in pseudocode, written out in great detail, unless asked not to do so.
2. Output the code in a single code block, being careful to only return relevant code.
3. You should always generate short suggestions for the next USER turns that are relevant to the conversation.
4. You can only give one reply for each conversation turn.
</task_evaluation>

<tool_calling>
You have tools at your disposal to solve the coding task. Follow these rules regarding tool calls:
1. ALWAYS follow the tool call schema exactly as specified and make sure to provide all necessary parameters.
2. The conversation may reference tools that are no longer available. NEVER call tools that are not explicitly provided.
3. **NEVER refer to tool names when speaking to the USER.** For example, instead of saying 'I need to use the edit_file tool to edit your file', just say 'I will edit your file'.
4. Only calls tools when they are necessary. If the USER's task is general or you already know the answer, just respond without calling tools.
5. Before calling each tool, first explain to the USER why you are calling it.
</tool_calling>

<making_code_changes>
When making code edits, NEVER output code to the USER, unless requested. Instead use one of the code edit tools to implement the change.
Specify the `target_file_path` argument first.
It is *EXTREMELY* important that your generated code can be run immediately by the USER, ERROR-FREE. To ensure this, follow these instructions carefully:
1. Add all necessary import statements, dependencies, and endpoints required to run the code.
2. NEVER generate an extremely long hash, binary, ico, or any non-textual code. These are not helpful to the USER and are very expensive.
3. Unless you are appending some small easy to apply edit to a file, or creating a new file, you MUST read the contents or section of what you're editing before editing it.
4. If you are copying the UI of a website, you should scrape the website to get the screenshot, styling, and assets. Aim for pixel-perfect cloning. Pay close attention to the every detail of the design: backgrounds, gradients, colors, spacing, etc.
5. If you see linter or runtime errors, fix them if clear how to (or you can easily figure out how to). DO NOT loop more than 3 times on fixing errors on the same file. On the third time, you should stop and ask the USER what to do next. You don't have to fix warnings. If the server has a 502 bad gateway error, you can fix this by simply restarting the dev server.
6. If the runtime errors are preventing the app from running, fix the errors immediately.
</making_code_changes>

<running_tests>
When asked to run tests, please follow these rules:
1. Before running tests, ask the USER how to run the tests if not already provided.
</running_tests>

# **Tools**

## **@cmdrunner**

Use the `@cmdrunner` tool to execute commands on the USER's machine. This tool is useful when the USER asks for help with a specific command or when the USER wants to run a command that is not directly supported by the system.
Some commands do not write any data to stdout which means the plugin can't pass the output of the execution to the LLM. When this occurs, the tool will instead share the exit code.

- **Specific Commands Execution**: Use the `@cmdrunner` tool to execute commands that are not directly supported by the system. For example, if the USER asks you to run tests, you can use the `@cmdrunner` tool to execute the tests.

## **@editor**

Use the `@editor` to modify the code in a Neovim buffer. If a buffer's content has been shared with you then the tool can be used to add, edit or delete specific lines. USERs can pin or watch a buffer to avoid manually re-sending you the buffer's content.

- **Modifying Buffer**: Use the `@editor` tool to modify the code in a Neovim buffer. For example, if the USER asks you to add a new function to a file, you can use the `@editor` tool to edit the file and add the new function.

## **@create_file** to create a file on disk.

Use the `@create_file` tool to create a new file on disk. This tool is useful when the USER asks for help with creating a new file or when you need to create a new file for a specific reason eg. to create a non-existing test file.

## **@read_file** to read a file from disk.

Use the `@read_file` tool to read the content of a file from disk. This tool is useful when you need to read a file to get more context.

## **@insert_edit_into_file** to edit a file on disk.

Use the `@insert_edit_into_file` tool to edit a file on disk. This tool is useful when the USER asks for help with editing a file or when you need to edit a file for a specific reason eg. to add a new code block to a file.

## **@next_edit_suggestion**

Use the `@next_edit_suggestion` tool to show the USER where the next edit is. Use this tool when you suggest edits in files or buffers that have been shared with you as context.

## **@vectorcode**

Use the `@vectorcode` tool to search in a chroma vector database. This tool is useful when the USER asks for specific information or when you need to search for a specific topic or code to get more context.

## **@web_search**

Use the `@web_search` tool to access up-to-date information from the web or when responding to the USER requires information about their location. Some examples of when to use the web tool include:

- **Local Information**: Use the `@web_search` tool to respond to questions that require information about the USER's location, such as the weather, local businesses, or events.
- **Freshness**: If up-to-date information on a topic could potentially change or enhance the answer, call the `@web_search` tool any time you would otherwise refuse to answer a question because your knowledge might be out of date.
- **Niche Information**: If the answer would benefit from detailed information not widely known or understood (which might be found on the internet), such as details about a small neighborhood, a less well-known company, or arcane regulations, use web sources directly rather than relying on the distilled knowledge from pretraining.
- **Accuracy**: If the cost of a small mistake or outdated information is high (e.g., using an outdated version of a software library or not knowing the date of the next game for a sports team), then use the web tool.

The `@web_search` can search the web with a specific query.

## **@mcp**

Use the `@mcp` tool to access the MCP servers. This tool is very useful, because it allows you to access multiple mcp servers and you can decide which server is the most suitable to use effectively to find a solution to the USER's problem.
]]

---@module "lazy"
---@type LazySpec
return {

  -- Codecompanion
  -- olimoriss's dotfiles: https://github.com/olimorris/dotfiles/blob/main/.config/nvim/lua/plugins/coding.lua
  {
    "olimorris/codecompanion.nvim",
    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionCmd",
      "CodeCompanionHistory",
    },
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        system_prompt = system_prompt,
        strategies = {
          chat = {
            adapter = {
              name = "copilot",
              model = "claude-sonnet-4",
            },
            roles = {
              user = "repl6669",
            },
            slash_commands = {
              ["file"] = {
                callback = "strategies.chat.slash_commands.file",
                description = "Select a file using FZF",
                opts = {
                  provider = "fzf_lua",
                  contains_code = true,
                },
              },
              ["buffer"] = {
                callback = "strategies.chat.slash_commands.buffer",
                description = "Select a file using FZF",
                opts = {
                  provider = "fzf_lua",
                  contains_code = true,
                },
              },
            },
            opts = {
              completion_provider = "cmp",
            },
            tools = {
              opts = {
                auto_submit_errors = true, -- Send any errors to the LLM automatically?
                auto_submit_success = true, -- Send any successful output to the LLM automatically?
              },
            },
            variables = {
              ["docker_enabled"] = {
                ---@return string|fun(): nil
                callback = function()
                  return tostring(require("utils.docker").docker_enabled())
                end,
                description = "Check if docker is enabled for current workspace",
                opts = {
                  contains_code = false,
                },
              },
            },
          },
          inline = {
            adapter = "anthropic",
          },
          cmd = {
            adapter = "anthropic",
          },
        },
        default_adapter = "anthropic",
        adapters = {
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              schema = {
                model = {
                  default = "claude-sonnet-4-20250514",
                },
              },
              env = {
                api_key = 'cmd:op read "op://Private/Anthropic/API key" --no-newline',
              },
            })
          end,
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              env = {
                api_key = 'cmd:op read "op://Private/op54pbs2bcvrdekea3uqg4p62a/API key" --no-newline',
              },
            })
          end,
          tavily = function()
            return require("codecompanion.adapters").extend("tavily", {
              env = {
                api_key = 'cmd:op read "op://Private/Tavily/API key" --no-newline',
              },
            })
          end,
        },
        prompt_library = {},
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              make_vars = true,
              make_slash_commands = true,
              show_result_in_chat = true,
            },
          },
          vectorcode = {
            opts = {
              add_tool = true,
              add_slash_command = true,
              tool_opts = {},
            },
          },
          history = {
            enabled = true,
            opts = {
              -- Keymap to open history from chat buffer (default: gh)
              keymap = "gh",
              -- Keymap to save the current chat manually (when auto_save is disabled)
              save_chat_keymap = "sc",
              -- Save all chats by default (disable to save only manually using 'sc')
              auto_save = true,
              -- Number of days after which chats are automatically deleted (0 to disable)
              expiration_days = 0,
              -- Picker interface ("telescope" or "snacks" or "fzf-lua" or "default")
              picker = "fzf-lua",
              ---Automatically generate titles for new chats
              auto_generate_title = true,
              title_generation_opts = {
                ---Adapter for generating titles (defaults to active chat's adapter)
                adapter = nil, -- e.g "copilot"
                ---Model for generating titles (defaults to active chat's model)
                model = nil, -- e.g "gpt-4o"
              },
              ---On exiting and entering neovim, loads the last chat on opening chat
              continue_last_chat = false,
              ---When chat is cleared with `gx` delete the chat from history
              delete_on_clearing_chat = false,
              ---Directory path to save the chats
              dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
              ---Enable detailed logging for history extension
              enable_logging = false,
            },
          },
        },
        window = {
          width = 0.45,
        },
        display = {
          action_palette = {
            provider = "default",
          },
          diff = {
            provider = "mini_diff",
          },
        },
      })
    end,

    keys = {
      {
        "<Leader>ac",
        "<cmd>CodeCompanionActions<CR>",
        desc = "Open the action palette",
        mode = { "n", "v" },
      },
      {
        "<Leader>aa",
        "<cmd>CodeCompanionChat Toggle<CR>",
        desc = "Toggle a chat buffer",
        mode = { "n", "v" },
      },
      {
        "<LocalLeader>a",
        "<cmd>CodeCompanionChat Add<CR>",
        desc = "Add code to a chat buffer",
        mode = { "v" },
      },
    },

    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
      "ravitemer/codecompanion-history.nvim",
      "echasnovski/mini.diff",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          filetypes = {
            codecompanion = {
              prompt_for_file_name = false,
              template = "[Image]($FILE_PATH)",
              use_absolute_path = true,
            },
          },
        },
      },
    },
  },

  -- Avante
  {
    "yetone/avante.nvim",
    enabled = false,
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    build = "make", -- If you want to build from source then do `make BUILD_FROM_SOURCE=true`
    opts = function(_, opts)
      local project_root = require("lazyvim.util").root.get({ normalize = true })
      local rag_root = os.getenv("HOME")

      return {
        provider = "copilot", -- copilot | claude-4-sonnet | claude-3-7-sonnet | openai
        -- auto_suggestions_provider = "copilot", -- ollama | claude | openai | copilot
        -- cursor_applying_provider = "groq", -- groq

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
          use_cwd_as_project_root = false,
          auto_focus_on_diff_view = false,
          enable_cursor_planning_mode = true,
          enable_claude_text_editor_tool_mode = true,
          auto_approve_tool_permissions = true,
        },

        rag_service = {
          enabled = false, -- Enables the RAG service
          host_mount = os.getenv("HOME"), -- Host mount path for the rag service
          provider = "openai", -- The provider to use for RAG service (e.g. openai or ollama)
          llm_model = "gpt-4o", -- The LLM model to use for RAG service
          embed_model = "text-embedding-ada-002", -- The embedding model to use for RAG service
          endpoint = "https://api.openai.com/v1", -- The API endpoint for RAG service
          unner = "docker",
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
          ["claude-4-sonnet"] = {
            __inherited_from = "claude",
            model = "claude-sonnet-4-20250514",
            extra_request_body = {
              max_tokens = 20480,
            },
          },

          ---@type AvanteSupportedProvider
          ["claude-3-7-sonnet"] = {
            __inherited_from = "claude",
            model = "claude-3-7-sonnet-20250219",
            extra_request_body = {
              max_tokens = 20480,
            },
          },

          ---@type AvanteSupportedProvider
          ["claude-3-5-sonnet"] = {
            __inherited_from = "claude",
            model = "claude-3-5-sonnet-20241022",
            extra_request_body = {
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
          width = 45, -- 35% of the width of the window
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

    keys = {
      {
        "<leader>ags",
        function()
          local rag_service = require("avante.rag_service")

          rag_service.launch_rag_service(function()
            vim.notify("Starting RAG service...", vim.log.levels.INFO, {
              title = "avante",
            })
          end)
        end,
        mode = { "n" },
        desc = "avante: start RAG service",
      },
      {
        "<leader>agS",
        function()
          local rag_service = require("avante.rag_service")

          rag_service.stop_rag_service()
          vim.notify("Stopping RAG service...", vim.log.levels.INFO, {
            title = "avante",
          })
        end,
        mode = { "n" },
        desc = "avante: stop RAG service",
      },
    },

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
      -- "Kaiser-Yang/blink-cmp-avante",
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

      {
        "ravitemer/mcphub.nvim",
        opts = function(_, opts)
          return vim.tbl_deep_extend("force", opts, {
            extensions = {
              avante = {
                make_slash_commands = true, -- make /slash commands from MCP server prompts
              },
            },
          })
        end,
      },
    },
  },

  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    keys = {
      {
        "<C-a>",
        function()
          require("copilot.suggestion").accept()
        end,
        desc = "Copilot: Accept suggestion",
        mode = { "i" },
      },
      {
        "<C-x>",
        function()
          require("copilot.suggestion").dismiss()
        end,
        desc = "Copilot: Dismiss suggestion",
        mode = { "i" },
      },
      {
        "<C-\\>",
        function()
          require("copilot.panel").open()
        end,
        desc = "Copilot: Show panel",
        mode = { "n", "i" },
      },
    },
    opts = function()
      LazyVim.cmp.actions.ai_accept = function()
        if require("copilot.suggestion").is_visible() then
          LazyVim.create_undo()
          require("copilot.suggestion").accept()
          return true
        end
      end

      return {
        panel = { enabled = false },
        suggestion = {
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

  -- VectorCode
  {
    -- Install CPU only version with [lsp,mcp] dependencies
    -- uv tool install vectorcode --index https://download.pytorch.org/whl/cpu --index-strategy unsafe-best-match --with 'pygls<2.0.0' --with  'lsprotocol' --with 'mcp<2.0.0' --with 'pydantic'
    "Davidyz/VectorCode",
    version = "*", -- optional, depending on whether you're on nightly or release
    build = "uv tool upgrade vectorcode", -- optional but recommended. This keeps your CLI up-to-date.
    cmd = "VectorCode",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        async_backend = "lsp",
        notify = true,
        on_setup = { lsp = false },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
          local cacher = require("vectorcode.config").get_cacher_backend()
          vim.api.nvim_create_autocmd("LspAttach", {
            callback = function()
              local bufnr = vim.api.nvim_get_current_buf()
              cacher.async_check("config", function()
                cacher.register_buffer(bufnr, {
                  n_query = 10,
                })
              end, nil)
            end,
            desc = "Register buffer for VectorCode",
          })

          return vim.tbl_deep_extend("force", opts, {
            sections = {
              lualine_y = {
                {
                  function()
                    return require("vectorcode.integrations").lualine(opts)[1]()
                  end,
                  cond = function()
                    if package.loaded["vectorcode"] == nil then
                      return false
                    else
                      return require("vectorcode.integrations").lualine(opts).cond()
                    end
                  end,
                },
              },
            },
          })
        end,
      },
    },
  },

  -- MCPHub
  {
    "ravitemer/mcphub.nvim",
    cmd = "MCPHub", -- Lazy load by default
    build = "npm install -g mcp-hub@latest",
    -- build = "bundled_build.lua",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        auto_approve = true,
        -- use_bundled_binary = true,
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
