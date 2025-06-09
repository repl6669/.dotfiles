---@module "lazy"
---@type LazySpec
return {
  {
    "giuxtaposition/blink-cmp-copilot",
    enabled = false,
  },

  {
    "saghen/blink.compat",
    enabled = false,
    version = "*",
    lazy = true,
    opts = {},
  },

  {
    "saghen/blink.cmp",

    dependencies = {
      "mikavilpas/blink-ripgrep.nvim",
      "fang2hou/blink-copilot",
      "Kaiser-Yang/blink-cmp-avante",
      "folke/snacks.nvim",
      "lukas-reineke/cmp-rg",
      "echasnovski/mini.icons",
    },

    opts = function(_, opts)
      opts.fuzzy = {
        sorts = {
          "exact",
          "score",
          "sort_text",
        },
      }

      opts.appearance = {
        kind_icons = vim.tbl_extend("force", opts.appearance.kind_icons or {}, LazyVim.config.icons.kinds),
      }

      opts.signature = {
        enabled = true,

        window = {
          show_documentation = true,
        },
      }

      opts.completion = {
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
            -- components = {},
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
      }

      opts.cmdline = {
        enabled = true,
      }

      opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
        default = { "avante", "copilot", "lsp", "path", "snippets", "buffer", "rg" },

        providers = {
          lsp = {
            enabled = true,
            name = "lsp",
            module = "blink.cmp.sources.lsp",
            kind = "LSP",
            min_keyword_length = 2,
            score_offset = 80,
          },

          path = {
            enabled = true,
            name = "Path",
            module = "blink.cmp.sources.path",
            fallbacks = { "snippets", "buffer" },
            score_offset = 20,
            opts = {
              get_cwd = function(_)
                return vim.fn.getcwd()
              end,
            },
          },

          buffer = {
            enabled = true,
            name = "Buffer",
            module = "blink.cmp.sources.buffer",
            fallbacks = { "rg" },
            min_keyword_length = 2,
            max_items = 3,
            score_offset = 10,
            opts = {
              -- Get completion from all "normal" open buffers
              get_bufnrs = function()
                return vim.tbl_filter(function(bufnr)
                  return vim.bo[bufnr].buftype == ""
                end, vim.api.nvim_list_bufs())
              end,
            },
          },

          snippets = {
            enabled = true,
            name = "Snippets",
            module = "blink.cmp.sources.snippets",
            max_items = 5,
            min_keyword_length = 2,
            score_offset = 30,
          },

          copilot = {
            enabled = true,
            name = "Copilot",
            module = "blink-copilot",
            score_offset = 90,
          },

          rg = {
            enabled = true,
            name = "rg",
            module = "blink.compat.source",
            min_keyword_length = 3,
            max_items = 5,
            score_offset = 5,
          },

          lazydev = {
            enabled = false,
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100, -- show at a higher priority than lsp
          },

          avante = {
            name = "Avante",
            module = "blink-cmp-avante",
            opts = {
              kind_icons = {
                Avante = "󰖷",
                AvanteCmd = "󰖷",
                AvanteMention = "󰖷",
              },
              avante = {
                command = {
                  get_kind_name = function(_)
                    return "AvanteCmd"
                  end,
                },
                mention = {
                  get_kind_name = function(_)
                    return "AvanteMention"
                  end,
                },
              },
            },
          },

          -- ripgrep = {
          --   name = "Ripgrep",
          --   module = "blink-ripgrep",
          --   score_offset = -10,
          --   ---@module "blink-ripgrep"
          --   ---@type blink-ripgrep.Options
          --   opts = {
          --     prefix_min_len = 3,
          --     context_size = 5,
          --     max_filesize = "256K",
          --     project_root_marker = { "composer.json", "package.json", ".git" },
          --     project_root_fallback = true,
          --   },
          -- },
        },
      })

      opts.keymap = {
        preset = "enter",
        -- ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        -- ["<C-e>"] = { "hide", "fallback" },
        -- ["<CR>"] = { "accept", "fallback" },
        --
        -- ["<Tab>"] = { "snippet_forward", "fallback" },
        -- ["<S-Tab>"] = { "snippet_backward", "fallback" },
        --
        -- ["<Up>"] = { "select_prev", "fallback" },
        -- ["<Down>"] = { "select_next", "fallback" },
        -- ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        -- ["<C-n>"] = { "select_next", "fallback_to_mappings" },
        --
        -- ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        -- ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        --
        -- ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
        ["<C-y>"] = { "select_and_accept" },
        ["<S-k>"] = { "scroll_documentation_up", "fallback" },
        ["<S-j>"] = { "scroll_documentation_down", "fallback" },
      }

      return opts
    end,
  },
}
