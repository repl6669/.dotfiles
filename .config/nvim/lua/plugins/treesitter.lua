return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      opts = {
        custom_calculation = function(_, language_tree)
          if vim.bo.filetype == "blade" and language_tree._lang ~= "javascript" and language_tree._lang ~= "php" then
            return "{{-- %s --}}"
          end
        end,
      },
    },
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  opts = {
    ensure_installed = {
      "bash",
      "diff",
      "html",
      "javascript",
      "jsdoc",
      "kdl",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "php",
      "php_only",
      "phpdoc",
      "python",
      "query",
      "regex",
      "rust",
      "sql",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "vue",
      "yaml",
    },
    autotag = {
      enable = true,
      enable_rename = true,
      enable_close = true,
      enable_close_on_slash = true,
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "markdown" },
    },
    indent = {
      enable = true,
    },
  },
  config = function(_, opts)
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

    parser_config.blade = {
      install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = { "src/parser.c" },
        branch = "main",
      },
      filetype = "blade",
    }

    vim.filetype.add({
      pattern = {
        [".*%.blade%.php"] = "blade",
      },
    })

    require("nvim-treesitter.configs").setup(opts)
  end,
}
