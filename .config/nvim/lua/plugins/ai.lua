---@module "lazy"
---@type LazySpec
return {

  -- Codecompanion
  -- olimoriss's dotfiles: https://github.com/olimorris/dotfiles/blob/main/.config/nvim/lua/plugins/coding.lua
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionChat" },
    init = function()
      require("plugins.custom.spinner"):init()
    end,
    opts = {
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
          adapter = {
            name = "copilot",
            model = "gpt-4.1",
          },
        },
      },
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            schema = {
              model = {
                default = "claude-sonnet-4-20250514",
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
        openrouter = function()
          local openai = require("codecompanion.adapters.openai")
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://openrouter.ai/api",
              api_key = 'cmd:op read "op://Private/OpenRouter/API_KEY" --no-newline',
              chat_url = "/v1/chat/completions",
            },
            handlers = {
              form_parameters = function(self, params, messages)
                local result = openai.handlers.form_parameters(self, params, messages)
                return result
              end,
              form_messages = function(self, messages)
                local result = openai.handlers.form_messages(self, messages)

                local fun = require("utils.functions")
                fun.map(result.messages, function(v)
                  local ok, json_res = pcall(function()
                    return vim.fn.json_decode(v.content)
                  end, "not a json")
                  if ok then
                    v.content = json_res
                    return v
                  end
                  return v
                end)

                return result
              end,
            },
            schema = {
              model = {
                default = "qwen/qwen3-32b",
              },
            },
          })
        end,
        ollama = function()
          local openai = require("codecompanion.adapters.openai")

          return require("codecompanion.adapters").extend("ollama", {
            opts = {
              stream = true,
              tools = true,
              vision = false,
            },
            handlers = {
              --- Use the OpenAI adapter for the bulk of the work
              setup = function(self)
                return openai.handlers.setup(self)
              end,
              tokens = function(self, data)
                return openai.handlers.tokens(self, data)
              end,
              form_parameters = function(self, params, messages)
                return openai.handlers.form_parameters(self, params, messages)
              end,
              form_messages = function(self, messages)
                return openai.handlers.form_messages(self, messages)
              end,
              form_tools = function(self, tools)
                return openai.handlers.form_tools(self, tools)
              end,
              chat_output = function(self, data)
                return openai.handlers.chat_output(self, data)
              end,
              tools = {
                format_tool_calls = function(self, tools)
                  return openai.handlers.tools.format_tool_calls(self, tools)
                end,
                output_response = function(self, tool_call, output)
                  return openai.handlers.tools.output_response(self, tool_call, output)
                end,
              },
              inline_output = function(self, data, context)
                return openai.handlers.inline_output(self, data, context)
              end,
              on_exit = function(self, data)
                return openai.handlers.on_exit(self, data)
              end,
            },
            schema = {
              model = {
                default = "qwen3:14b",
              },
              num_ctx = {
                default = 20000,
              },
            },
          })
        end,
      },
      prompt_library = {},
      extensions = {
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
          enabled = true,
          opts = {
            add_tool = true,
            add_slash_command = true,
            tool_opts = {},
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
    },

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
      "echasnovski/mini.diff",
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
            opts = function(_, opts)
              table.insert(opts.sections.lualine_x, { require("mcphub.extensions.lualine") })
            end,
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
    opts = function()
      return {
        async_backend = "lsp",
        notify = true,
        on_setup = { lsp = false },
        n_query = 10,
        timeout_ms = -1,
        async_opts = {
          events = { "BufWritePost" },
          single_job = true,
          query_cb = require("vectorcode.utils").make_surrounding_lines_cb(40),
          debounce = -1,
          n_query = 30,
        },
      }
    end,
    config = function(_, opts)
      require("vectorcode").setup(opts)
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",

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

  -- Minuet
  {
    "milanglacier/minuet-ai.nvim",
    enabled = false,
    event = "VeryLazy",
    config = function(_, opts)
      local num_docs = 10

      local has_vc, vectorcode_config = pcall(require, "vectorcode.config")
      local vectorcode_cacher = nil
      if has_vc then
        vectorcode_cacher = vectorcode_config.get_cacher_backend()
      end

      -- roughly equate to 2000 tokens for LLM
      local RAG_Context_Window_Size = 8000

      opts = {
        add_single_line_entry = true,
        n_completions = 1,
        after_cursor_filter_length = 0,
        provider = "openai_fim_compatible",
        provider_options = {
          openai = {
            api_key = function()
              local handle = io.popen('op read "op://Private/OpenAI/API_KEY" --no-newline')
              if handle then
                local result = handle:read("*a")
                handle:close()
                return result
              else
                return nil
              end
            end,
          },
          anthropic = {
            api_key = function()
              local handle = io.popen('op read "op://Private/Anthropic/API_KEY" --no-newline')
              if handle then
                local result = handle:read("*a")
                handle:close()
                return result
              else
                return nil
              end
            end,
          },
          openai_fim_compatible = {
            model = os.getenv("OLLAMA_CODE_MODEL"),
            template = {
              prompt = function(pref, suff, _)
                local prompt_message = ""
                if has_vc then
                  for _, file in ipairs(vectorcode_cacher.query_from_cache(0)) do
                    prompt_message = prompt_message .. "<|file_sep|>" .. file.path .. "\n" .. file.document
                  end
                end

                prompt_message = vim.fn.strcharpart(prompt_message, 0, RAG_Context_Window_Size)

                return prompt_message .. "<|fim_prefix|>" .. pref .. "<|fim_suffix|>" .. suff .. "<|fim_middle|>"
              end,
              suffix = false,
            },
          },
        },
        request_timeout = 10,
      }
      local num_ctx = 1024 * 32
      local job = require("plenary.job"):new({
        command = "curl",
        args = { os.getenv("OLLAMA_HOST"), "--connect-timeout", "1" },
        on_exit = function(self, code, signal)
          if code == 0 then
            opts.provider_options.openai_fim_compatible = {
              api_key = "TERM",
              name = "Ollama",
              stream = false,
              end_point = os.getenv("OLLAMA_HOST") .. "/v1/completions",
              model = os.getenv("OLLAMA_CODE_MODEL"),
              optional = {
                max_tokens = 256,
                num_ctx = num_ctx,
              },
              template = {
                prompt = function(pref, suff)
                  if vim.bo.filetype == "gitcommit" then
                    local git_diff = vim.system({ "git", "diff" }, {}, nil):wait().stdout
                    if git_diff then
                      return "You are a experienced software developer, writing a conventional git commit message for the following patch.<|file_sep|>"
                        .. git_diff
                        .. "<|fim_middle|>"
                    end
                  end
                  local prompt_message = ([[Perform fill-in-middle from the following snippet of a %s code. Respond with only the filled in code.]]):format(
                    vim.bo.filetype
                  )
                  local has_vc, vectorcode_config = pcall(require, "vectorcode.config")
                  if has_vc then
                    local cache_result = vectorcode_config.get_cacher_backend().make_prompt_component(0)
                    num_docs = cache_result.count
                    prompt_message = prompt_message .. cache_result.content
                  end

                  return prompt_message .. "<|fim_prefix|>" .. pref .. "<|fim_suffix|>" .. suff .. "<|fim_middle|>"
                end,
                suffix = false,
              },
            }
          end
          vim.schedule(function()
            require("minuet").setup(opts)
            local openai_fim_compatible = require("minuet.backends.openai_fim_compatible")
            local orig_get_text_fn = openai_fim_compatible.get_text_fn
            openai_fim_compatible.get_text_fn = function(json)
              local bufnr = vim.api.nvim_get_current_buf()
              local co = coroutine.create(function()
                vim.b[bufnr].ai_raw_response = json
                local has_vc, vectorcode_config = pcall(require, "vectorcode.config")
                if not has_vc then
                  return
                end
                if vectorcode_config.get_cacher_backend().buf_is_registered() then
                  local new_num_query = num_docs
                  if json.usage.total_tokens > num_ctx then
                    new_num_query = math.max(num_docs - 1, 1)
                  elseif json.usage.total_tokens < num_ctx * 0.9 then
                    new_num_query = num_docs + 1
                  end
                  vectorcode_config.get_cacher_backend().register_buffer(0, { n_query = new_num_query })
                end
              end)
              coroutine.resume(co)
              return orig_get_text_fn(json)
            end
          end)
        end,
      })
      job:start()
    end,
    dependencies = { "ibhagwan/fzf-lua" },
  },
}
