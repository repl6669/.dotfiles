---@module "lazy"
---@type LazySpec
return {

  -- Codecompanion
  -- olimoriss's dotfiles: https://github.com/olimorris/dotfiles/blob/main/.config/nvim/lua/plugins/coding.lua
  {
    "olimorris/codecompanion.nvim",
    version = "*",
    cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionChat" },
    init = function()
      require("plugins.custom.cc-spinner"):init()
    end,
    opts = function(_, opts)
      opts = opts or {}

      -- Detect completion provider: prefer blink.cmp, fallback to nvim-cmp
      local completion_provider = (function()
        local ok_blink = pcall(require, "blink.cmp")
        if ok_blink then
          return "blink"
        end
        local ok_cmp = pcall(require, "cmp")
        if ok_cmp then
          return "cmp"
        end
        return "default"
      end)()

      opts.display = {
        action_palette = { provider = "fzf_lua" },
        diff = { provider = "mini_diff" },
      }

      opts.strategies = {
        chat = {
          adapter = {
            name = "copilot",
            model = "gpt-5",
          },
          roles = {
            llm = function(adapter)
              return string.format("%s (%s)", adapter.formatted_name, adapter.model.name)
            end,
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
            completion_provider = completion_provider, -- blink|cmp
          },
          tools = {
            opts = {
              auto_submit_errors = true, -- Send any errors to the LLM automatically?
              auto_submit_success = true, -- Send any successful output to the LLM automatically?
            },
          },
          variables = {
            ["run_tests_command"] = {
              ---@return string|fun(): nil
              callback = function()
                return require("utils.docker").docker_enabled()
                    and "docker compose -f compose.local.yml run --rm --no-deps api ./vendor/bin/pest"
                  or "./vendor/bin/pest"
              end,
              description = "Command for running tests",
              opts = {
                contains_code = false,
              },
            },
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
          adapter = {
            name = "copilot",
            model = "gpt-5-mini",
          },
        },
      }

      opts.adapters = {
        acp = {
          gemini_cli = function()
            return require("codecompanion.adapters").extend("gemini_cli", {
              model = {
                default = "gemini-2.5-pro",
              },
              -- env = {
              --   api_key = 'cmd:op read "op://Private/Gemini/API_KEY" --no-newline',
              -- },
            })
          end,
        },
        http = {
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              schema = {
                model = {
                  default = "claude-sonnet-4-20250514",
                },
                temperature = {
                  default = 0,
                },
                top_p = {
                  default = 1,
                },
              },
              env = {
                api_key = 'cmd:op read "op://Private/Anthropic/API_KEY" --no-newline',
              },
            })
          end,
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              opts = {
                stream = true,
              },
              env = {
                api_key = 'cmd:op read "op://Private/OpenAI/API_KEY" --no-newline',
              },
            })
          end,
          tavily = function()
            return require("codecompanion.adapters").extend("tavily", {
              env = {
                api_key = 'cmd:op read "op://Private/Tavily/API_KEY" --no-newline',
              },
            })
          end,
          mistral = function()
            return require("codecompanion.adapters").extend("mistral", {
              schema = {
                model = {
                  default = "claude-sonnet-4-20250514",
                },
              },
              env = {
                url = "https://codestral.mistral.ai/v1/fim/completions",
                api_key = 'cmd:op read "op://Private/Mistral/CODESTRAL_API_KEY" --no-newline',
                chat_url = "https://codestral.mistral.ai/v1/chat/completions",
              },
            })
          end,
          openrouter = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "https://openrouter.ai/api",
                api_key = 'cmd:op read "op://Private/OpenRouter/API_KEY" --no-newline',
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = "qwen/qwen3-32b",
                },
              },
            })
          end,
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              schema = {
                num_ctx = {
                  default = 1024 * 128,
                },
                model = {
                  default = "codestral:latest",
                },
              },
              opts = {
                stream = true,
                tools = true,
                vision = false,
              },
            })
          end,
        },
      }

      opts.prompt_library = {}

      opts.extensions = {
        mcphub = {
          enabled = true,
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true, -- Show mcp tool results in chat
            make_vars = true, -- Convert resources to #variables
            make_slash_commands = true, -- Add prompts as /slash commands
          },
        },
        vectorcode = {
          enabled = vim.fn.executable("vectorcode") == 1,
          opts = {
            tool_group = {
              enabled = true,
              extras = { "file_search" },
              collapse = false,
            },
            tool_opts = {
              ---@type VectorCode.CodeCompanion.LsToolOpts
              ls = { use_lsp = true },
              ---@type VectorCode.CodeCompanion.VectoriseToolOpts
              vectorise = {
                use_lsp = true,
                requires_approval = false,
              },
              ---@type VectorCode.CodeCompanion.QueryToolOpts
              query = {
                default_num = { document = 15, chunks = 100 },
                chunk_mode = true,
                use_lsp = true,
              },
            },
          },
        },
        history = {
          enabled = true,
          opts = {
            keymap = "gh", -- Keymap to open history from chat buffer (default: gh)
            save_chat_keymap = "sc", -- Keymap to save the current chat manually (when auto_save is disabled)
            auto_save = true, -- Save all chats by default (disable to save only manually using 'sc')
            picker = "fzf-lua", -- Picker interface ("telescope" or "snacks" or "fzf-lua" or "default")
            auto_generate_title = true, ---Automatically generate titles for new chats
            continue_last_chat = false, ---On exiting and entering neovim, loads the last chat on opening chat
            delete_on_clearing_chat = false, ---When chat is cleared with `gx` delete the chat from history
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history", ---Directory path to save the chats
            enable_logging = false, ---Enable detailed logging for history extension
            summary = {
              create_summary_keymap = "gcs",
              browse_summaries_keymap = "gbs",
              preview_summary_keymap = "gps",

              generation_opts = {
                context_size = 90000,
                include_references = true, -- Include slash command content (default: true)
                include_tool_outputs = true, -- Include tool outputs (default: true)
              },
            },
          },
        },
      }
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
      "ravitemer/codecompanion-history.nvim",
      "nvim-mini/mini.diff",
      "j-hui/fidget.nvim",
      "ibhagwan/fzf-lua",

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

      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        cmd = "PasteImage",
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

  -- VectorCode
  {
    -- Install CPU only version with [lsp,mcp] dependencies
    -- uv tool install vectorcode --index https://download.pytorch.org/whl/cpu --index-strategy unsafe-best-match --with 'pygls<2.0.0' --with  'lsprotocol' --with 'mcp<2.0.0' --with 'pydantic'
    "Davidyz/VectorCode",
    version = "*", -- optional, depending on whether you're on nightly or release
    build = "uv tool upgrade vectorcode", -- optional but recommended. This keeps your CLI up-to-date.
    cmd = "VectorCode",
    cond = function()
      return vim.fn.executable("vectorcode") == 1
    end,
    opts = function()
      return {
        async_backend = "lsp",
        notify = true,
        on_setup = { lsp = true },
        n_query = 10,
        timeout_ms = 10 * 1000,
        async_opts = {},
      }
    end,
    config = function(_, opts)
      require("vectorcode").setup(opts)
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "j-hui/fidget.nvim",

      {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
          table.insert(opts.sections.lualine_x, {
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
          })
        end,
      },
    },
  },
}
