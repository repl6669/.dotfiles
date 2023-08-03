if true then
  return {}
end

return {
  "williamboman/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "docker-compose-language-service",
      "dockerfile-language-server",
      "js-debug-adapter",
      "json-lsp",
      "lua-language-server",
      "php-debug-adapter",
      "phpcs",
      "pint",
      "sqlls",
      "stylua",
      "typescript-language-server",
      "vue-language-server",
      -- "psalm",
      -- "intelephense",
    },
  },
}
