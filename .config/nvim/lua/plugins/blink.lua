---@module "lazy"
---@type LazySpec
return {
  {
    "saghen/blink.cmp",

    dependencies = {
      "mikavilpas/blink-ripgrep.nvim",
      "folke/snacks.nvim",
      "lukas-reineke/cmp-rg",
      "nvim-mini/mini.icons",
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      sources = {
        providers = {
          path = {
            min_keyword_length = 0,
          },
          snippets = {
            min_keyword_length = 2,
          },
          buffer = {
            max_items = 5,
          },
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 0,
            async = true,
          },
        },
      },

      appearance = {
        -- kind_icons = vim.tbl_extend("force", opts.appearance.kind_icons or {}, LazyVim.config.icons.kinds),
      },

      signature = {
        enabled = true,

        window = {
          show_documentation = true,
          border = "rounded",
        },
      },

      completion = {
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          border = "rounded",
          draw = {
            treesitter = { "lsp" },
            -- components = {},
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          treesitter_highlighting = true,
          window = { border = "rounded" },
        },
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
      },

      cmdline = {
        enabled = false,
      },

      keymap = {
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
      },

      fuzzy = { implementation = "prefer_rust" },
    },
  },
}
