return {
  "williamboman/mason.nvim",
  opts = {
    ui = {
      border = "rounded",
    },
    ensure_installed = {
      "php-debug-adapter",
      "markdownlint",
      "marksman",
    },
  },
}
